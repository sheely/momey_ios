//
//  SHChatSearchListViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatSearchListViewController.h"
#import "SHChatSimpleUserInfoCell.h"
@interface SHChatSearchListViewController ()

@end

@implementation SHChatSearchListViewController

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
    self.title = @"财友列表";
    mList = [@[@"",@"",@"",@"",@""] mutableCopy];
    // Do any additional setup after loading the view from its nib.
}
- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHChatSimpleUserInfoCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatSimpleUserInfoCell" owner:nil options:nil] objectAtIndex:0];
    cell.tag = indexPath.row;
    [cell.btnChat addTarget:self action:@selector(btnChat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnAdd addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)btnAdd:(NSObject*)sender
{
    [self showWaitDialogForNetWorkDismissBySelf];
}

- (void)btnChat:(NSObject*)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"chatdetail" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  72;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
    SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];

}
@end
