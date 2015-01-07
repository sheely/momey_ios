//
//  SHTeamMemberCell.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-30.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTeamMemberCell.h"

@implementation SHTeamMemberCell

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
    self.labContent.textColor = [UIColor orangeColor];
    self.imgView.layer.cornerRadius = 5;
    self.imgView.layer.masksToBounds = YES;
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
