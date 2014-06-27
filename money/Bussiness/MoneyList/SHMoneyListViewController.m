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
   // mList = [@[@"",@"",@"",@"",@""] mutableCopy];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[NVSkin.instance image:@"navi_search_nest"] target:self action:@selector(btnSearch:)];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadNext
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryOppoList.do");
    [post.postArgs setValue:[NSNumber numberWithInt:type] forKey:@"statusWithMe"];
    [post.postArgs setValue:@"" forKey:@"oppoType"];
    
    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [t.result valueForKey:@"opportunies"];
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
    }];
}

- (void)btnSearch:(UIButton*)sender
{
    SHIntent * indent = [[SHIntent alloc]init:@"searchcondition" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:indent];
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHMoneyListViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHMoneyListViewCell" owner:nil options:nil] objectAtIndex:0];
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    cell.labTitle.text = [dic valueForKey:@"oppoTitle"];
    cell.labBottom.text = [dic valueForKey:@"publishTime"];
    cell.labContent.text = [dic valueForKey:@"oppoType"];
    cell.labState.text = [dic valueForKey:@"oppoStatus"];
    cell.btnState.tag = indexPath.row;
    cell.btnEmployee.tag = indexPath.row;
    [cell.btnState addTarget:self action:@selector(btnState:) forControlEvents:(UIControlEventTouchUpInside)];
    if(type == 3){
        [cell.btnEmployee setTitle:@"执行人" forState:UIControlStateNormal];
    }else{
        [cell.btnEmployee setTitle:@"执行信息" forState:UIControlStateNormal];

    }
    //cell.a.titleLabel.text = @"s";
    if([[dic valueForKey:@"oppoStatus"] caseInsensitiveCompare:@"已关闭"]==NSOrderedSame ){
        [cell.btnState setTitle:@"打开财信" forState:UIControlStateNormal];
        cell.btnState.titleLabel.text = @"打开财信";
        cell.btnState.userstyle = @"btnopenmoney";
        }else{
            [cell.btnState setTitle:@"关闭财信" forState:UIControlStateNormal];
        cell.btnState.userstyle = @"btnclosemoney";
    }
    if (type == 0 || type == 1) {
        cell.btnEmployee.hidden = YES;
        cell.btnState.hidden = YES;
        cell.btnMark.hidden = YES;
    }else if (type == 2){
        cell.btnEmployee.hidden = NO;
        cell.btnState.hidden = YES;
        cell.btnMark.hidden = NO;
    }else {
        cell.btnEmployee.hidden = NO;
        cell.btnState.hidden = NO;
        cell.btnMark.hidden = NO;
    }
    [cell.btnEmployee addTarget:self action:@selector(btnEmployee:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)btnEmployee:(UIButton*)btn
{
    if(type == 3){
        NSDictionary * dic = [mList objectAtIndex:btn.tag];
        SHIntent * intent = [[SHIntent alloc]init:@"searchexecuter" delegate:nil containner:self.navigationController];
        [intent.args setValue:[dic valueForKey:@"oppoId"] forKey:@"oppoId"];
        [[UIApplication sharedApplication]open:intent];
    }else{
        NSDictionary * dic = [mList objectAtIndex:btn.tag];
        SHIntent * intent = [[SHIntent alloc]init:@"executeinfo" delegate:nil containner:self.navigationController];
        [intent.args setValue:@"self" forKey:@"type"];
        [intent.args setValue:[dic valueForKey:@"oppoId"] forKey:@"oppoId"];
        [[UIApplication sharedApplication]open:intent];
    }

}

- (void)btnState:(UIButton*)btn
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miOpenOppo.do");
    NSDictionary * dic = [mList objectAtIndex:btn.tag];
    [post.postArgs setValue:[dic valueForKey:@"oppoId"] forKey:@"oppoId"];
    int target = 0;
    NSString * state;
    if([[dic valueForKey:@"oppoStatus"] caseInsensitiveCompare:@"已关闭"]==NSOrderedSame ){
        target = 1;
        state = @"已打开";
    }else{
        target = 0;
        state = @"已关闭";
    }
    [post.postArgs setValue: [NSNumber numberWithInt:target] forKey:@"targetStatus"];
    [post start:^(SHTask * t) {
        [dic setValue: state forKey:@"oppoStatus"];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:btn.tag inSection:0 ]] withRowAnimation:UITableViewRowAnimationLeft];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
    }];
}

- (CGFloat) tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  110;
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
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    [intent.args setValue:[dic valueForKey:@"oppoId"] forKey:@"oppoId"];
    [[UIApplication sharedApplication]open:intent];
}
- (void)reSet
{
    mIsEnd = NO;
    [mList removeAllObjects];
    [self.tableView reloadData];
}
- (IBAction)btnAllOnTouch:(id)sender
{
    type = 0;
    [self reSet];
    self.btnAll.selected = YES;
    self.btnBidding.selected = NO;
    self.btnParticipate.selected = NO;
    self.btnStart.selected = NO;
}
- (IBAction)btnParticipateOnTouch:(id)sender
{
    type = 1;
    [self reSet];
    self.btnAll.selected = NO;
    self.btnBidding.selected = NO;
    self.btnParticipate.selected = YES;
    self.btnStart.selected = NO;
}
- (IBAction)btnBiddingOnTouch:(id)sender
{
    type = 2;
    [self reSet];
    self.btnAll.selected = NO;
    self.btnBidding.selected = YES;
    self.btnParticipate.selected = NO;
    self.btnStart.selected = NO;
}

- (IBAction)btnStartOnTouch:(id)sender
{
    type = 3;
    [self reSet];
    self.btnAll.selected = NO;
    self.btnBidding.selected = NO;
    self.btnParticipate.selected = NO;
    self.btnStart.selected = YES;
}
@end
