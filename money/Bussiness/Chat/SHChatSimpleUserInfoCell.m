//
//  SHChatSimpleUserInfoCell.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatSimpleUserInfoCell.h"

@implementation SHChatSimpleUserInfoCell

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
    self.btnAdd.titleLabel.font = [NVSkin.instance fontOfStyle:@"FontScaleSmall"];
    self.btnChat.titleLabel.font = [NVSkin.instance fontOfStyle:@"FontScaleSmall"];
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
