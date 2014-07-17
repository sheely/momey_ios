//
//  SHUserCalendarViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-14.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHUserCalendarViewController.h"

@interface SHUserCalendarViewController ()

@end

@implementation SHUserCalendarViewController

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
    self.title = @"日历";
    // Do any additional setup after loading the view from its nib.
}

-(void)loadNext
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryTasks.do");
    [post.postArgs setValue:[NSNumber numberWithInt:0] forKey:@"isOwnTask"];
    [post.postArgs setValue:/*[self.intent.args valueForKey:@"username"] */@"germmy"forKey:@"queryedUserName"];
    
    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [[(NSArray*)t.result valueForKey:@"tasks"] mutableCopy];
        [self.tableView reloadData];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
        [self dismissWaitDialog];
        
    }];}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    NSString * msg;
    int value = [[dic valueForKey:@"taskStatus"] intValue];
    msg = value == 0 ? @"未开始" : (value == 1 ? @"完成":@"取消");
    SHTableViewGeneralCell * cell = [tableView dequeueReusableGeneralCell];
    cell.labTitle.text =  [NSString stringWithFormat:@"%@ 至 %@ [%@]",[dic valueForKey:@"startTime"],[dic valueForKey:@"endTime"],msg];
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
