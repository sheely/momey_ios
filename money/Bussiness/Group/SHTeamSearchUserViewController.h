//
//  SHTeamSearchUserViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewController.h"
@class SHTeamSearchUserViewController;

@protocol SHTeamSearchUserViewControllerDelegate <NSObject>

- (void)teamSearchUserViewController:(SHTeamSearchUserViewController*)controller selectd:(NSDictionary*)dic;

@end

@interface SHTeamSearchUserViewController : SHTableViewController

@end
