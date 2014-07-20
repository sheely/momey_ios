//
//  SHTeamSearchUserViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTeamSearchUserViewController.h"

@interface SHTeamSearchUserViewController ()

@end

@implementation SHTeamSearchUserViewController

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
    if(self.intent){
        mList = [self.intent.args valueForKey:@"list"];
        mIsEnd = YES;
    }
    self.title = @"人员列表";
    
    // Do any additional setup after loading the view from its nib.
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHTableViewTitleContentCell * cell = [tableView dequeueReusableTitleContentCell];
    cell.labTitle.text = [dic valueForKey:@"friendName"];
    cell.labContent.text = [dic valueForKey:@"companyName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate) {
        [self.delegate teamSearchUserViewController:self selectd:[mList objectAtIndex:indexPath.row]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
