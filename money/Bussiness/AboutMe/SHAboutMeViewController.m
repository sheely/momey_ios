//
//  SHAboutMeViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-1.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHAboutMeViewController.h"

@interface SHAboutMeViewController ()

@end

@implementation SHAboutMeViewController

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
    self.title = @"我";
    
    mList = [@[@"我的日历",@"我的关注",@"我的团队"] mutableCopy];
    // Do any additional setup after loading the view from its nib.
}
- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHTableViewGeneralCell * cell = [self dequeueReusableGeneralCell];
    cell.labTitle.text = [mList objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
