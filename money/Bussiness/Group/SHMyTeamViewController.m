//
//  SHMyTeamViewController.m
//  money
//
//  Created by zywang on 14-6-14.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHMyTeamViewController.h"
#import "SHMyTeamTableViewCell.h"
@interface SHMyTeamViewController ()

@end

@implementation SHMyTeamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的团队";
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryTeam.do");
    [post.postArgs setValue: [[NSUserDefaults standardUserDefaults] valueForKey:LOGIN_INFO] forKey:@"ownerUserName"];
    [post.postArgs setValue:@"" forKey:@"teamName"];
    [post.postArgs setValue:@"" forKey:@"memberUserName"];
    [post.postArgs setValue:[Entironment.instance loginName] forKey:@"ownerUserId"];
    
    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [t.result valueForKey:@"teams"];
        [self.tableView reloadData];
        [self dismissWaitDialog];
        
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
        [t.respinfo show];
    }];


    // Do any additional setup after loading the view from its nib.
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHMyTeamTableViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHMyTeamTableViewCell" owner:nil options:nil] objectAtIndex:0];
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    cell.labTitle.text = [dic valueForKey:@"teamName"];
    if([[dic valueForKey:@"isCreatedByMe"] integerValue]){
        cell.labContent.text = @"我参与的";
    }else {
        cell.labContent.text = @"我发起的";
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHIntent * intent = [[SHIntent alloc]init:@"teamdetail" delegate:nil containner:self.navigationController];
    [intent.args setValue: [dic valueForKey:@"teamId"] forKey:@"teamId"];
    
    [[UIApplication sharedApplication]open:intent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
