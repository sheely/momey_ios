//
//  SHGroupListViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-1.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHGroupListViewController.h"
#import "SHGroupListViewCell.h"

@interface SHGroupListViewController ()

@end

@implementation SHGroupListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        [[SHMsgManager instance]connect:@"192.168.1.109" port:1984];
//        SHMsgM * msg = [[SHMsgM alloc]init];
//        msg.target  = @"login";
//        [msg.args setValue:@"xxx" forKey:@"user"];
//        [msg start:nil taskWillTry:nil taskDidFailed:nil];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"财圈";
    isTeam = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[NVSkin.instance image:@"navi_search_nest"] target:self action:@selector(btnSearch:)];
    [self request];
    // Do any additional setup after loading the view from its nib.
}

- (void) btnSearch:(NSObject * )sender
{
    if(isTeam){
        
        SHIntent * indent = [[SHIntent alloc]init:@"teamsearch" delegate:self containner:self.navigationController];
        [[UIApplication sharedApplication]open:indent];

    }else{
        SHIntent * indent = [[SHIntent alloc]init:@"companysearch" delegate:self containner:self.navigationController];
        [[UIApplication sharedApplication]open:indent];

    }
  
}

- (void) request
{
    [self showWaitDialogForNetWork];
    if(isTeam){
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"miQueryTeam.do");
        [post.postArgs setValue:teamcreatname == nil ? @"" :teamcreatname forKey:@"ownerUserName"];
        [post.postArgs setValue:@"" forKey:@"ownerUserId"];
        
        [post.postArgs setValue:teamname == nil ? @"" : teamname forKey:@"teamName"];
        [post.postArgs setValue:teammembername == nil ?  @"" : teammembername forKey:@"memberUserName"];
        [post start:^(SHTask * t) {
            mIsEnd  = YES;
            mList = [t.result valueForKey:@"teams"];
            [self.tableView reloadData];
            [self dismissWaitDialog];

        } taskWillTry:nil taskDidFailed:^(SHTask * t) {
            [self dismissWaitDialog];
            [t.respinfo show];
        }];

    }else{
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"queryCompany.do");
        [post.postArgs setValue: diccompany == nil ? @"": [diccompany valueForKey:@"key"]  forKey:@"companyCategoryKey"];
        [post.postArgs setValue:companyname == nil ? @"":companyname forKey:@"companyName"];
        
        [post start:^(SHTask * t) {
            mIsEnd  = YES;
            mList = [t.result valueForKey:@"companys"];
            [self.tableView reloadData];
            [self dismissWaitDialog];
        } taskWillTry:nil taskDidFailed:^(SHTask * t) {
            [t.respinfo show];
            [self dismissWaitDialog];

        }];

    }
}

- (void)loadSkin
{
    [self.btnCompany setBackgroundImage:[NVSkin.instance stretchImage:@"tab_selected.png"] forState:UIControlStateHighlighted];
    [self.btnCompany setBackgroundImage:[NVSkin.instance stretchImage:@"tab_selected.png"] forState:UIControlStateSelected];
    [self.btnTeam setBackgroundImage:[NVSkin.instance stretchImage:@"tab_selected.png"] forState:UIControlStateHighlighted];
    [self.btnTeam setBackgroundImage:[NVSkin.instance stretchImage:@"tab_selected.png"] forState:UIControlStateSelected];
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHGroupListViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHGroupListViewCell" owner:nil options:nil] objectAtIndex:0];
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    if(isTeam){
        cell.labTitle.text = [dic valueForKey:@"teamName"];
        [cell.imgView setUrl:[dic valueForKey:@"teamHeadIcon"]];
    }else{
        cell.labTitle.text = [dic valueForKey:@"companyName"];
        [cell.imgView setUrl:[dic valueForKey:@"companyHeadIcon"]];
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mList.count;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    if(isTeam){
        SHIntent * intent = [[SHIntent alloc]init:@"teamdetail" delegate:nil containner:self.navigationController];
        [intent.args setValue: [dic valueForKey:@"teamId"] forKey:@"teamId"];

        [[UIApplication sharedApplication]open:intent];
    }else{
        SHIntent * intent = [[SHIntent alloc]init:@"companydetail" delegate:nil containner:self.navigationController];
        
        [intent.args setValue: [dic valueForKey:@"companyId"] forKey:@"companyId"];
        [[UIApplication sharedApplication]open:intent];
    }
  
}

- (void) companysearchviewcontrollerDidSubmit:(SHCompanySearchViewController *)controller type:(NSDictionary *)type company:(NSString *)company_
{
    diccompany = type ;
    companyname = company_;
    [self.navigationController popViewControllerAnimated:YES];

    [self request];
}
- (void)teamSearchViewController:(SHTeamSearchViewController*)controller createName:(NSString*)createName teamName:(NSString*)teamName_ username:(NSString*)username
{
    teamname = teamName_;
    teamcreatname = createName;
    teammembername = username;
    [self.navigationController popViewControllerAnimated:YES];
    [self request];
}

- (IBAction)btnTeamOnTouch:(id)sender {
    self.btnCompany.selected = NO;
    self.btnTeam.selected = YES;
    isTeam = YES;
    [self request];
}

- (IBAction)btCompanyOnTouch:(id)sender {
    self.btnCompany.selected = YES;
    self.btnTeam.selected = NO;
    isTeam = NO;
    [self request];
}
@end
