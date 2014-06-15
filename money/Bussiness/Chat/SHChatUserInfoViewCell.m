//
//  SHChatUserInfoViewCell.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-10.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatUserInfoViewCell.h"

@implementation SHChatUserInfoViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)loadSkin
{
    [super loadSkin];
    self.btnAddFavorate.titleLabel.font = [NVSkin.instance fontOfStyle:@"FontScaleSmall"];
    self.btnSendChat.titleLabel.font = [NVSkin.instance fontOfStyle:@"FontScaleSmall"];

}
@end
