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
        [[SHMsgManager instance]connect:@"192.168.1.109" port:1984];
        SHMsgM * msg = [[SHMsgM alloc]init];
        msg.target  = @"login";
        [msg.args setValue:@"xxx" forKey:@"user"];
        [msg start:nil taskWillTry:nil taskDidFailed:nil];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"财圈";
    mList = [@[@"",@"",@"",@"",@""] mutableCopy];
    // Do any additional setup after loading the view from its nib.
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHGroupListViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHGroupListViewCell" owner:nil options:nil] objectAtIndex:0];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHIntent * intent = [[SHIntent alloc]init:@"companydetail" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];
}

@end
