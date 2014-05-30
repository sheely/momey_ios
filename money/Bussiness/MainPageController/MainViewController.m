//
//  SHMainViewController.m
//  crowdfunding-arcturus
//
//  Created by WSheely on 14-4-8.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//
#import "MainViewController.h"
#import "SHMoneyListViewController.h"

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
    [self tabBar:self.tabbar didSelectItem:self.tabbar.selectedItem];
    //引导页加载
 
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
    if(lastnacontroller != nacontroller){
        NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
        [nacontroller.navigationBar setTitleTextAttributes:attributes];
        nacontroller.navigationBar.translucent = NO;
        
        nacontroller.navigationBar.tintColor = [UIColor whiteColor];
        if(!iOS7){
            nacontroller.navigationBar.clipsToBounds = YES;
        }
        nacontroller.navigationBar.barTintColor = [UIColor colorWithRed:109/255.0 green:202/255.0 blue:65/255.0 alpha:1];
        nacontroller.view.frame = bound;
        [self.view addSubview:nacontroller.view];
        [lastnacontroller.view removeFromSuperview];
        lastnacontroller = nacontroller;
    }
}




@end
