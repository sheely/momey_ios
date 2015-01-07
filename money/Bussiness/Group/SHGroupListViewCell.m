//
//  SHGroupListViewCell.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-5.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHGroupListViewCell.h"

@implementation SHGroupListViewCell

- (void)loadSkin
{
    [super loadSkin];
    self.imgView.layer.cornerRadius = 5;
    self.imgView.layer.masksToBounds = YES;
}
@end
