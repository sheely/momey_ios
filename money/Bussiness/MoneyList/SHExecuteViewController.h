//
//  SHExecuteViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-16.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHExecuteViewController : SHViewController<SHCalendarViewControllerDelegate>

{
    __weak IBOutlet UILabel *labExecuter;
    SHCalendarViewController * calendarcontroller;
    __weak IBOutlet UIButton *btnStart;
    __weak IBOutlet UIButton *btnEnd;
    __weak IBOutlet UITextField *txtPlace;
    __weak IBOutlet UITextField *txtBudge;
    __weak IBOutlet UITextField *txtMark;
    UIButton * mButton;
}
- (IBAction)btnSeeOnTouch:(id)sender;
- (IBAction)btnCalendarOnTouch:(id)sender;
@end
