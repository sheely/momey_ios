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
    NSArray * listRegion;
    NSDictionary * dicType;
    NSDictionary * dicRegion;
    NSDictionary * dicCompany;
    UITapGestureRecognizer* _tapGestureRec;
}
@property (weak, nonatomic) IBOutlet UIButton *btnRegion;
@property (weak, nonatomic) IBOutlet UIButton *btnType;
@property (weak, nonatomic) IBOutlet UIButton *btnCompany;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
- (IBAction)btnSearchOnTouch:(id)sender;
- (IBAction)btnTypeOnTouch:(id)sender;
- (IBAction)btnCompanyOnTouch:(id)sender;
- (IBAction)btnRegionOnTouch:(id)sender;
@end
