//
//  SHMoneySearchViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-17.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@class SHMoneySearchViewController;

@protocol SHMoneySearchViewControllerDelegate <NSObject>

- (void) moneysearchviewcontrollerDidSubmit:(SHMoneySearchViewController*)obj type:(NSDictionary*)type boss:(NSString*)boss title:(NSString*)title;
@end

@interface SHMoneySearchViewController  : SHViewController
{
    NSArray * mList;
    NSDictionary * dictype;
}
@property (weak, nonatomic) IBOutlet UIButton *btnType;
- (IBAction)btnTypeOnTouch:(id)sender;
@property (nonatomic,weak) id<SHMoneySearchViewControllerDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtBoss;
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
- (IBAction)btnSearchOnTouch:(id)sender;
@end
