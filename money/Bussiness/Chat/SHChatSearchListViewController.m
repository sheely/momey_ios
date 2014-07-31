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
    mList = [self.intent.args valueForKey:@"list"];
    mIsEnd = YES;
    // Do any additional setup after loading the view from its nib.
}
- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHChatSimpleUserInfoCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatSimpleUserInfoCell" owner:nil options:nil] objectAtIndex:0];
    cell.labTitle.text = [dic valueForKey:@"friendName"];
    cell.labContent.text = [dic valueForKey:@"companyName"];
    cell.tag = indexPath.row;
    [cell.btnChat addTarget:self action:@selector(btnChat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnAdd addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnChat.tag = indexPath.row;
    cell.btnAdd.tag = indexPath.row;
    return cell;
}

- (void)btnAdd:(UIButton*)sender
{
    [self showWaitDialogForNetWork];
    NSDictionary * dic = [mList objectAtIndex:sender.tag];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miFollowerAdd.do");
    [post.postArgs setValue:Entironment.instance.loginName forKey:@"myUserName"];
    [post.postArgs setValue:[dic valueForKey:@"friendId"] forKey:@"followerUserName"];
    [post.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"addOrDelete"];
    [post start:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
        
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
    }];
    

}

- (void)btnChat:(UIButton*)sender
{
    NSDictionary * dic = [mList objectAtIndex:sender.tag];
    SHIntent * intent = [[SHIntent alloc]init:@"chatdetail" delegate:nil containner:self.navigationController];
    [intent.args setValue:[dic valueForKey:@"friendId"] forKey:@"friendId"];
    [intent.args setValue:[dic valueForKey:@"friendIcon"] forKey:@"friendIcon"];
    [intent.args setValue:[dic valueForKey:@"friendName"] forKey:@"friendName"];

    [[UIApplication sharedApplication]open:intent];

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  72;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mList.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
    [intent.args setValue:[dic valueForKey:@"friendId"] forKey:@"friendId"];
    [[UIApplication sharedApplication]open:intent];

}
@end
