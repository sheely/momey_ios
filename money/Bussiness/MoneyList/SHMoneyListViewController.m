//
//  SHMoneyListViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-5-31.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHMoneyListViewController.h"
#import "SHMoneyListViewCell.h"

@interface SHMoneyListViewController ()

@end

@implementation SHMoneyListViewController

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
    self.title = @"财信";
    mList = [@[@"",@"",@"",@"",@""] mutableCopy];
    // Do any additional setup after loading the view from its nib.
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHMoneyListViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHMoneyListViewCell" owner:nil options:nil] objectAtIndex:0];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  110;
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

@end
