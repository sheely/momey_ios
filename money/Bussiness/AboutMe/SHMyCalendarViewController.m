//
//  SHMyCalendarViewController.m
//  money
//
//  Created by zywang on 14-6-14.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHMyCalendarViewController.h"
#import "SHMyCalendarViewCell.h"

@interface SHMyCalendarViewController ()

@end

@implementation SHMyCalendarViewController

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
    self.title = @"我的日历";//http://cjcapp.nat123.net:21414/myStruts1/ miQueryTasks.do
    [self request];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" target:self action:@selector(btnAdd:)];
    // Do any additional setup after loading the view from its nib.
}
- (void)request
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryTasks.do");
    [post.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"isOwnTask"];
    NSString * user = [Entironment.instance loginName];
    
    [post.postArgs setValue:user forKey:@"queryedUserName"];
    
    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [[(NSArray*)t.result valueForKey:@"tasks"] mutableCopy];
        [self.tableView reloadData];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
        [self dismissWaitDialog];
        
    }];

}

- (void)btnAdd:(UIButton*)btn
{
    SHIntent  *intent = [[SHIntent alloc]init:@"editcalendar" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];   
}

- (void)editCalendarViewControllerSubmit
{
    [self.navigationController popViewControllerAnimated:YES];
    [self request];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHMyCalendarViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHMyCalendarViewCell" owner:nil options:nil]objectAtIndex:0];
    cell.labStartTime.text = [NSString stringWithFormat:@"%@ 至 %@",[dic valueForKey:@"startTime" ], [dic valueForKey:@"endTime" ]];
    cell.labEndTime.text = [dic valueForKey:@"taskContent"];
    cell.btnDelete.tag = indexPath.row;
    cell.btnEdit.tag = indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnEdit addTarget:self action:@selector(btnEdit:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)btnDelete:(UIButton*)btn
{
    [self showAlertDialog:@"确定删除这条日历?" button:@"确定" otherButton:@"取消" tag:btn.tag];
  
}

- (void)alertViewEnSureOnClick:(int)tag;
{
    NSDictionary * dic = [mList objectAtIndex:tag];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miTaskMaintainance.do");
    [post.postArgs setValue:[dic valueForKey:@"taskId"] forKey:@"taskId"];
    [post.postArgs setValue:[NSNumber numberWithInt:3] forKey:@"operationType"];
    [post start:^(SHTask * t) {
        [mList removeObjectAtIndex:tag];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
    }];

}

- (void)btnEdit:(UIButton*)btn
{
    SHIntent  *intent = [[SHIntent alloc]init:@"editcalendar" delegate:nil containner:self.navigationController];
    NSDictionary * dic = [mList objectAtIndex:btn.tag];
    [intent.args setValue:dic forKey:@"info"];
    [[UIApplication sharedApplication]open:intent];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
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

@end
