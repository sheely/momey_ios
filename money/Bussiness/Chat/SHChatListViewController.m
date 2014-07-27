//
//  SHChatViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-1.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatListViewController.h"

@interface SHChatListViewController ()

@end

@implementation SHChatListViewController

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
    self.title = @"财友";
    mList = [@[@"",@"",@"",@"",@""] mutableCopy];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[NVSkin.instance image:@"navi_search_nest"] target:self action:@selector(btnSearch:)];
    // Do any additional setup after loading the view from its nib.
}

- (void)btnSearch:(UIButton*)sender
{
    SHIntent * indent = [[SHIntent alloc]init:@"usersearchcondition" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:indent];
}
- (CGFloat) tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  68;
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHTableViewTitleContentBottomCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatListViewCell" owner:nil options:nil] objectAtIndex:0];
    cell.labTitle.text = @"王志跃";
    cell.labBottom.text = @"Welcome to china";
    return cell;
}

- (void)chatsearchviewcontrollerDidSubmit:(SHChatSearchViewController*)controller list:(NSArray * )list
{
    SHIntent * intent = [[SHIntent alloc ]init:@"usersearchlist" delegate:self containner:self.navigationController];
    [[intent args] setValue:list forKey:@"list"];
    [[UIApplication sharedApplication]open:intent];
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHIntent * intent = [[SHIntent alloc]init:@"commentdetail" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
