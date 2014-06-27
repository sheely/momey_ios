//
//  SHMoneyListViewCell.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-4.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHMoneyListViewCell.h"

@implementation SHMoneyListViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)loadSkin
{
    [super loadSkin];
    self.btnEmployee.titleLabel.font = [NVSkin.instance fontOfStyle:@"FontScaleSmall"];
    self.btnState.titleLabel.font = [NVSkin.instance fontOfStyle:@"FontScaleSmall"];
    self.btnMark.titleLabel.font = [NVSkin.instance fontOfStyle:@"FontScaleSmall"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
