//
//  SHMyCalendarViewCell.h
//  money
//
//  Created by zywang on 14-6-14.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHMyCalendarViewCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
- (IBAction)btnDelete:(id)sender;

@end
