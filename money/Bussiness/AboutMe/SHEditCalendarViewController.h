//
//  SHEditCalendarViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-4.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"
@class SHEditCalendarViewController;

@protocol SHEditCalendarViewControllerDelegate <NSObject>

- (void)editCalendarViewControllerSubmit;

@end

@interface SHEditCalendarViewController : SHViewController
{
    UIButton * mButton;
    SHCalendarViewController * calendarcontroller;

}
- (IBAction)btnStartTimeOnTouch:(id)sender;
- (IBAction)btnEndTimeOnTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UIButton *btnStartTime;
@property (weak, nonatomic) IBOutlet UIButton *btnEndTime;
@end
