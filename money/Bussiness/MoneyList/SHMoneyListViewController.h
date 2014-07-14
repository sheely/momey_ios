//
//  SHMoneyListViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-5-31.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"
#import "SHMoneySearchViewController.h"

@interface SHMoneyListViewController : SHTableViewController<SHMoneySearchViewControllerDelegate>
{
    int type;
    NSString * oppoType;
    NSString * bossName;
    NSString * oppoTitle;
    
}
@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UIButton *btnParticipate;
@property (weak, nonatomic) IBOutlet UIButton *btnBidding;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
- (IBAction)btnParticipateOnTouch:(id)sender;
- (IBAction)btnAllOnTouch:(id)sender;
- (IBAction)btnBiddingOnTouch:(id)sender;
- (IBAction)btnStartOnTouch:(id)sender;

@end
