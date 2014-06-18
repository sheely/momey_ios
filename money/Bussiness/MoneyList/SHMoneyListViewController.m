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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[NVSkin.instance image:@"navi_search_nest"] target:self action:@selector(btnSearch:)];
    // Do any additional setup after loading the view from its nib.
}

- (void)btnSearch:(UIButton*)sender
{
    SHIntent * indent = [[SHIntent alloc]init:@"searchcondition" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:indent];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void) moneysearchviewcontrollerDidSubmit:(NSObject*)obj
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHIntent * intent = [[SHIntent alloc]init:@"moneydetail" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnAllOnTouch:(id)sender
{
    self.btnAll.selected = YES;
    self.btnBidding.selected = NO;
    self.btnParticipate.selected = NO;
    self.btnStart.selected = NO;
}
- (IBAction)btnParticipateOnTouch:(id)sender
{
    self.btnAll.selected = NO;
    self.btnBidding.selected = NO;
    self.btnParticipate.selected = YES;
    self.btnStart.selected = NO;
}
- (IBAction)btnBiddingOnTouch:(id)sender
{
    self.btnAll.selected = NO;
    self.btnBidding.selected = YES;
    self.btnParticipate.selected = NO;
    self.btnStart.selected = NO;
}

- (IBAction)btnStartOnTouch:(id)sender
{
    self.btnAll.selected = NO;
    self.btnBidding.selected = NO;
    self.btnParticipate.selected = NO;
    self.btnStart.selected = YES;
}
@end
