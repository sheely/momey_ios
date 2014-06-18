//
//  SHTeamDetailViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-19.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTeamDetailViewController.h"

@interface SHTeamDetailViewController ()

@end

@implementation SHTeamDetailViewController

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
    self.title = @"团队详情";
    mList = [@[@"",@"",@""]mutableCopy];
    // Do any additional setup after loading the view from its nib.
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * lab =  [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 30)];
    lab.userstyle = @"labminlight";
    switch (section) {
        case 0:
            
            break;
        case 1:
            lab.text = @"  简介";
            break;
        case 2:
            lab.text = @"  团队成员";
            
            break;
        default:
            break;
    }
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0;
    }else{
        return 30;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return  80;
    }else{
        return 40;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHTableViewGeneralCell * cell;
    if(indexPath.section == 0){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHGroupListViewCell" owner:nil options:nil] objectAtIndex:0];
    }else {
        cell = [tableView dequeueReusableGeneralCell];
        cell.labTitle.text = @"美国人";
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
