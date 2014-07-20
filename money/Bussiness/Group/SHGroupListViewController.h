//
//  SHGroupListViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-1.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"
#import "SHCompanySearchViewController.h"
#import "SHTeamSearchViewController.h"

@interface SHGroupListViewController : SHTableViewController<SHCompanySearchViewControllerDelegate,SHTeamSearchViewControllerDelegate>

{
    BOOL isTeam;
    NSDictionary * diccompany;
    NSString * companyname;
    NSString* teamcreatname;
    NSString* teammembername;
    NSString* teamname;
}
- (IBAction)btnTeamOnTouch:(id)sender;
- (IBAction)btCompanyOnTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCompany;
@property (weak, nonatomic) IBOutlet UIButton *btnTeam;
@end
