//
//  SHSearchExecuteViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-25.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHSearchExecuteViewController.h"
#import "SHExecutorViewSelectCell.h"


@interface SHSearchExecuteViewController ()

@end

@implementation SHSearchExecuteViewController

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
    self.title = @"选择执行人";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[NVSkin.instance image:@"navi_search_nest"] target:self action:@selector(btnSearch:)];
    

      // Do any additional setup after loading the view from its nib.
}
- (void)btnSearch:(UIButton * )btn
{
    SHIntent * indent = [[SHIntent alloc]init:@"usersearchcondition" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:indent];
}
-(UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHExecutorViewSelectCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHExecutorViewSelectCell" owner:nil options:nil] objectAtIndex:0];
    cell.labTitle.text = [dic valueForKey:@"friendName"];
    cell.labContent.text = [dic valueForKey:@"companyName"];
    if([[dic valueForKey:@"isExecuter"] boolValue] == YES){
        cell.imgIcon.hidden = NO;
    }else{
        cell.imgIcon.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)loadNext
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    post.URL = URL_FOR(@"miChooseExecuteGuide.do");
    [post start:^(SHTask * t) {
        mIsEnd = YES;
        mList =[t.result valueForKey:@"friendList"] ;
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        t.respinfo.show ;
    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miChooseExecute.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    [post.postArgs setValue:[dic valueForKey:@"friendId"] forKey:@"userName"];
    [post start:^(SHTask *t) {
        [self dismissWaitDialog];
        [self.navigationController popViewControllerAnimated:YES];
        [t.respinfo show];
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];

        [t.respinfo show];

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
