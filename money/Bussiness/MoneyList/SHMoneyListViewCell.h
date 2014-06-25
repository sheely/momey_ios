//
//  SHMoneyListViewCell.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-4.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHMoneyListViewCell : SHTableViewTitleContentBottomCell

@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UIButton *btnEmployee;

@property (weak, nonatomic) IBOutlet UIButton *btnState;
@end
