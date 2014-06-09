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
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
