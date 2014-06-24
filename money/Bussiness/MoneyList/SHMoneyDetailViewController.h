//
//  SHMoneyDetailViewController.h
//  money
//
//  Created by zywang on 14-6-14.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHMoneyDetailViewController : SHViewController
{
    __weak IBOutlet UILabel *labOrder;
    __weak IBOutlet UITextView *labContent;
    __weak IBOutlet UILabel *labTitle;
    __weak IBOutlet UILabel *labType;
    NSDictionary * dic ;
}
- (IBAction)btnMegOnTouch:(id)sender;
- (IBAction)btnSeeOnTouch:(id)sender;
- (IBAction)btnAttachmentOnTouch:(id)sender;
- (IBAction)btnExecuteOnTouch:(id)sender;
@end
