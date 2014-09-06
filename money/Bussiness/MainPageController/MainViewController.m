//
//  SHMainViewController.m
//  crowdfunding-arcturus
//
//  Created by WSheely on 14-4-8.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//
#import "MainViewController.h"
#import "SHMoneyListViewController.h"
#import "SHGroupListViewController.h"
#import "SHChatListViewController.h"
#import "SHAboutMeViewController.h"
#import "SHChatListHelper.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabbar.selectedItem = [self.tabbar.items objectAtIndex:0];
   // [self tabBar:self.tabbar didSelectItem:self.tabbar.selectedItem];
    self.tabbar.selectedImageTintColor = [UIColor colorWithRed:255/255.0 green:130/255.0  blue:46/255.0  alpha:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:NOTIFICATION_NEED_LOGIN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessful:) name:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    [self login:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:CORE_NOTIFICATION_CONFIG_STATUS_CHANGED object:nil];

    SHConfigManager.instance.URL = @"http://www.isheely.com/a/getconfig.html";
    SHConfigManager.instance.get = YES;
    [SHConfigManager.instance refresh];
    // [self performSelector:@selector(nedlogin) withObject:nil afterDelay:0.5];
    //引导页加载
}

- (void)notification:(NSNotification*)s
{
    SHConfigManager.instance.show;
}

- (void)login:(NSObject*)o
{
    loginViewController = [[SHLoginViewController alloc]init];
    [self.view addSubview:loginViewController.view];
    
}

- (void)message:(NSObject*)sender
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miReceiveMessage.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    
    [post start:^(SHTask * t) {
       // [[self.tabbar.items objectAtIndex:1]setBadgeValue:@"😄"]; ;

        NSArray * array = [t.result valueForKey:@"immessages"];
        if(array.count > 0){
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_MESSAGE object:array];
            UITabBarItem * item = [self.tabbar.items objectAtIndex:1];
            
            if(item != self.tabbar.selectedItem){
                item.badgeValue = @"😄";
            }
            
            for (NSDictionary*dic in array) {
                SHChatItem * item = [[SHChatItem alloc]init] ;
                item.userid = [dic valueForKey:@"senderuserid"];
                item.content = [dic valueForKey:@"chatcontent"];
                item.date = [dic valueForKey:@"sendtime"];
                item.headicon = [dic valueForKey:@"senderheadicon"];
                item.username = [dic valueForKey:@"senderusername"];
                item.isNew = YES;
                [[SHChatListHelper instance] addItem: item];
            }
            [[SHChatListHelper instance]notice];
        }
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
          }];
}

- (void)loginSuccessful:(NSObject *)sender
{
    [UIView setAnimationDuration:1];
    [UIView animateWithDuration:1 animations:^{
        CGRect rect = loginViewController.view.frame;
        rect.origin.y = [UIApplication sharedApplication].keyWindow.frame.size.height - rect.origin.y;
        loginViewController.view.frame = rect;
    } completion:^(BOOL finished) {
        [loginViewController.view removeFromSuperview];
    }];
    [self tabBar:self.tabbar didSelectItem:self.tabbar.selectedItem];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(message:) userInfo:nil repeats:YES];

}

#pragma  mark Tabbar

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{ // called when a new view is selected by the user (but not programatically)
    UINavigationController * nacontroller;
    CGRect bound = self.view.bounds;
    bound.size.height -= 50;
    if(item.tag == 0){
        nacontroller =[ mDictionary valueForKey:@"SHMoneyListViewController"];
        if(!nacontroller){
            SHMoneyListViewController * viewcontroller = [[SHMoneyListViewController alloc]init];
            nacontroller = [[UINavigationController alloc]initWithRootViewController:viewcontroller];
            [mDictionary setValue:nacontroller forKey:@"SHMoneyListViewController"];
        }
    }
    else if(item.tag == 1){
        nacontroller =[ mDictionary valueForKey:@"SHChatListViewController"];
        if(!nacontroller){
            SHChatListViewController * viewcontroller = [[SHChatListViewController alloc]init];
            nacontroller = [[UINavigationController alloc]initWithRootViewController:viewcontroller];
            [mDictionary setValue:nacontroller forKey:@"SHChatListViewController"];
        }
        item.badgeValue = nil;
    }
    else if(item.tag == 2){
        nacontroller =[ mDictionary valueForKey:@"SHGroupListViewController"];
        if(!nacontroller){
            SHGroupListViewController * viewcontroller = [[SHGroupListViewController alloc]init];
            nacontroller = [[UINavigationController alloc]initWithRootViewController:viewcontroller];
            [mDictionary setValue:nacontroller forKey:@"SHGroupListViewController"];
        }
    }
    else if(item.tag == 3){
        nacontroller =[ mDictionary valueForKey:@"SHAboutMeViewController"];
        if(!nacontroller){
            SHAboutMeViewController * viewcontroller = [[SHAboutMeViewController alloc]init];
            nacontroller = [[UINavigationController alloc]initWithRootViewController:viewcontroller];
            [mDictionary setValue:nacontroller forKey:@"SHAboutMeViewController"];
        }
    }
    
    if(lastnacontroller != nacontroller){
        NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
        [nacontroller.navigationBar setTitleTextAttributes:attributes];
        nacontroller.navigationBar.translucent = NO;
        
        nacontroller.navigationBar.tintColor = [UIColor whiteColor];
        if(!iOS7){
            nacontroller.navigationBar.clipsToBounds = YES;
        }
        nacontroller.navigationBar.barTintColor = [UIColor colorWithRed:31/255.0 green:129/255.0 blue:198/255.0 alpha:1];
        nacontroller.view.frame = bound;
        [self.view insertSubview:nacontroller.view belowSubview:loginViewController.view];
        [lastnacontroller.view removeFromSuperview];
        lastnacontroller = nacontroller;
    }
}
@end
