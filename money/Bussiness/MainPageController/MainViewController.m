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
    
   // [self performSelector:@selector(nedlogin) withObject:nil afterDelay:0.5];
    //引导页加载
    loginViewController = [[SHLoginViewController alloc]init];
    [self.view addSubview:loginViewController.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessful:) name:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
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
