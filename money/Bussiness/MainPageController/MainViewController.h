//
//  SHMainViewController.h
//  crowdfunding-arcturus
//
//  Created by WSheely on 14-4-8.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHViewController.h"
#import "SHLoginViewController.h"

@interface MainViewController : SHViewController <UITabBarDelegate,SHTaskDelegate>
{
    NSMutableDictionary* mDictionary;
    UINavigationController* lastnacontroller;
    SHLoginViewController * loginViewController;
}
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
- (void)login;
// 设置消息 个数
@end
