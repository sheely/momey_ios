//
//  SHChatSearchViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"
@class SHChatSearchViewController;
@protocol SHChatSearchViewControllerDelegate <NSObject>

- (void)chatsearchviewcontrollerDidSubmit:(SHChatSearchViewController*)controller list:(NSArray * )list;

@end

@interface SHChatSearchViewController : SHViewController
{
    NSArray * listType ;
    NSArray * listCompany;
    NSDictionary * dicType;
    NSDictionary * dicCompany;
}
@property (weak, nonatomic) IBOutlet UIButton *btnType;
@property (weak, nonatomic) IBOutlet UIButton *btnCompany;
- (IBAction)btnSearchOnTouch:(id)sender;
- (IBAction)btnTypeOnTouch:(id)sender;
- (IBAction)btnCompanyOnTouch:(id)sender;
@end
