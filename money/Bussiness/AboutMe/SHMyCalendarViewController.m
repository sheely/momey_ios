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
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryTasks.do");
    [post.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"isOwnTask"];
    NSString * user = [[NSUserDefaults standardUserDefaults] valueForKey:LOGIN_INFO];

    [post.postArgs setValue:user forKey:@"queryedUserName"];
    
    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [[(NSArray*)t.result valueForKey:@"tasks"] mutableCopy];
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
    }];

    // Do any additional setup after loading the view from its nib.
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
    NSDictionary * dic = [mList objectAtIndex:btn.tag];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryTasks.do");
    [post.postArgs setValue:[dic valueForKey:@"taskId"] forKey:@"taskId"];
    [post.postArgs setValue:[NSNumber numberWithInt:3] forKey:@"operationType"];
    [post start:^(SHTask * t) {
        [mList removeObjectAtIndex:btn.tag];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
    }];

}

- (void)btnEdit:(UIButton*)btn
{
    
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
