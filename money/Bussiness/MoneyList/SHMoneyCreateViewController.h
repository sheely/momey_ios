//
//  SHMoneyCreateViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-28.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@class SHMoneyCreateViewController;

@protocol SHMoneyCreateViewControllerDelegate<NSObject>
- (void)moneyCreateViewControllerDidSubmit;
@end

@interface SHMoneyCreateViewController : SHViewController
{
    NSArray *array;
    __weak IBOutlet UITextField *txtTitle;
    NSDictionary * mdic;
    __weak IBOutlet UITextView *txtContent;
    UITapGestureRecognizer* _tapGestureRec;

}
- (IBAction)btnOnTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnType;
@end
