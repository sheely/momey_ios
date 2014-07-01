//
//  SHReportListViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-1.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHReportListViewController.h"

@interface SHReportListViewController ()

@end

@implementation SHReportListViewController

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
    self.title = @"评论";
    if([[self.intent.args valueForKey:@"commenterType"] intValue]== 1 || [[self.intent.args valueForKey:@"commenterType"] intValue] ==2){
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"评论" target:self action:@selector(btnReport:)];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)btnReport:(UIButton*)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"writereport" delegate:nil containner:self.navigationController];
    [intent.args setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
  [intent.args setValue:[self.intent.args valueForKey:@"commenterType"] forKey:@"commenterType"];
    int type = [[self.intent.args valueForKey:@"commenterType"] intValue];
    for (int i = 0; i< mList.count; i++) {
        NSDictionary * dic = [mList objectAtIndex:i];
        if([[dic valueForKey:@"commenterType"]intValue] == type){
            [intent.args setValue:[dic valueForKey:@"commentContent"] forKey:@"content"];
            break;
        }
    }
    
    [[UIApplication sharedApplication]open:intent];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"queryCommentsList.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [t.result valueForKey:@"leaveComments"];
        [self dismissWaitDialog];
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
        [t.respinfo show];
    }];

}
- (int )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mList.count;
}
- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell * ) tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHTableViewTitleContentCell * cell = [tableView dequeueReusableTitleContentCell];
    if([[dic valueForKey:@"commenterType"] intValue] == 1){
        cell.labTitle.text = @"承接人评论:";
    }else{
        cell.labTitle.text = @"执行人评论";
    }
    cell.labContent.text = [dic valueForKey:@"commentContent"];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
