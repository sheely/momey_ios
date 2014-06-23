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

- (void) moneysearchviewcontrollerDidSubmit:(NSObject*)obj;
@end

@interface SHMoneySearchViewController  : SHViewController
{
    NSArray * mList;
}
@property (weak, nonatomic) IBOutlet UIButton *btnType;
- (IBAction)btnTypeOnTouch:(id)sender;
@property (nonatomic,weak) id<SHMoneySearchViewControllerDelegate>delegate;
- (IBAction)btnSearchOnTouch:(id)sender;
@end
