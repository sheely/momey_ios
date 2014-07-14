//
//  SHMyFollowViewCell.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-13.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHMyFollowViewCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnChat;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnCalendar;

@property (weak, nonatomic) IBOutlet UILabel *labUserName;
@property (weak, nonatomic) IBOutlet SHImageView *imgView;
@end
