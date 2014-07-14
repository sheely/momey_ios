//
//  SHMyFollowViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-13.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHMyFollowViewController.h"
#import "SHMyFollowViewCell.h"

@interface SHMyFollowViewController ()

@end

@implementation SHMyFollowViewController

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
    self.title = @"我的关注";
    
    // Do any additional setup after loading the view from its nib.
}

-(void)loadNext
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryFollowers.do");
    [post start:^(SHTask *t) {
        mList = [t.result valueForKey:@"followers"];
        mIsEnd = YES;
        [self.tableView reloadData];
        [self dismissWaitDialog];

    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHMyFollowViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHMyFollowViewCell" owner:nil options:nil]objectAtIndex:0];
    [cell.imgView setUrl:[dic valueForKey:@"followerHeadIcon"]];
    cell.labUserName.text = [dic valueForKey:@"followerName"];
    cell.btnCancel.tag = indexPath.row;
    [cell.btnCancel addTarget:self action:@selector(btnCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)btnCancel:(UIButton*)btn
{
    [self showAlertDialog:@"确认删除关注?" button:@"确认" otherButton:@"取消" tag:btn.tag];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        [self showWaitDialogForNetWork];
        NSDictionary * dic = [mList objectAtIndex:alertView.tag];
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"miFollowerAdd.do");
        [post.postArgs setValue:Entironment.instance.loginName forKey:@"myUsername"];
        [post.postArgs setValue:[dic valueForKey:@"followerId"] forKey:@"followerUsername"];
        [post.postArgs setValue:[NSNumber numberWithInt:0] forKey:@"addOrDelete"];
        [post start:^(SHTask *t) {
            [mList removeObjectAtIndex:alertView.tag];
            [self.tableView reloadData];
            [self dismissWaitDialog];
            
        } taskWillTry:nil taskDidFailed:^(SHTask *t) {
            [t.respinfo show];
            [self dismissWaitDialog];
        }];

    }
}

@end
