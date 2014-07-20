//
//  SHTeamSearchViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"
#import "SHChatSearchViewController.h"
#import "SHTeamSearchUserViewController.h"

@class SHTeamSearchViewController;

@protocol SHTeamSearchViewControllerDelegate  <NSObject>

- (void)teamSearchViewController:(SHTeamSearchViewController*)controller createName:(NSString*)createName teamName:(NSString*)teamName username:(NSString*)username;

@end

@interface SHTeamSearchViewController : SHViewController<SHChatSearchViewControllerDelegate,SHTeamSearchUserViewControllerDelegate>
{
    UIButton * mBtnTemp;
}
- (IBAction)btnSubmit:(id)sender;
- (IBAction)btnCreateOnTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtTeam;
@property (weak, nonatomic) IBOutlet UIButton *btnCreate;
@property (weak, nonatomic) IBOutlet UIButton *btnTeamMember;
@end
