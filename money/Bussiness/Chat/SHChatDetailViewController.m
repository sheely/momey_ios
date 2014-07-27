//
//  SHChatDetailViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-27.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatDetailViewController.h"
#import "SHChatUnitViewCell.h"

@interface SHChatDetailViewController ()

@end

@implementation SHChatDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadNext
{
//    [self showWaitDialogForNetWork];
//    
//    SHPostTaskM * post = [[SHPostTaskM alloc]init];
//    post.URL = URL_FOR(@"queryLmList.do");
//    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
//    
//    [post start:^(SHTask * t) {
        mIsEnd  = YES;
//        mList = [[t.result valueForKey:@"leaveMessages"] mutableCopy];
    if(mList == nil){
        mList = [[NSMutableArray alloc]init];
    }
    
    [self.tableView reloadData];
//        [self dismissWaitDialog];
//    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
//        [t.respinfo show];
//        [self dismissWaitDialog];
//        
//    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"聊天";
    friendId = [self.intent.args valueForKey:@"friendId"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message:) name:NOTIFICATION_MESSAGE object:nil];
    [self loadNext];
    // Do any additional setup after loading the view from its nib.
}
- (void)message:(NSNotification * )n
{
//    friendId
    BOOL b = false;
    for (NSDictionary * dic  in n.object) {
        if([[dic valueForKey:@"senderuserid"]isEqualToString:friendId ] == YES){
            [mList addObject:dic];
            b = YES;
        }
    }
    if(b){
        [self.tableView reloadData];
        [self checkBottom];

    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [[[mList objectAtIndex:indexPath.row] valueForKey:@"chatcontent"] sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(183, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
    return  60 - 18 + size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mList.count > 0) {
        
        SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
        NSDictionary * dic = [mList objectAtIndex:indexPath.row];
        [intent.args setValue:[dic valueForKey:@"senderuserid"] forKey:@"friendId"];
        
        [[UIApplication sharedApplication]open:intent];
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHChatUnitViewCell * cell = nil;
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    if([[dic valueForKey:@"type"] length] > 0 ){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUnitMySelfViewCell" owner:nil options:nil] objectAtIndex:0];
    }else{
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUnitViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.labTxt.text = [dic valueForKey:@"chatcontent"];
    [cell.imgIcon setUrl:[dic valueForKey:@"senderheadicon"]];
    cell.labTimer.text = [[dic valueForKey:@"sendtime"] substringWithRange:NSMakeRange(11,5)];
    return cell;
}

- (IBAction)btnSenderOnTouch:(id)sender
{
    [self showWaitDialogForNetWork];
    NSString * msg = self.txtBox.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[Entironment instance].loginName forKey:@"senderuserid"];
    [dic setValue:@"" forKey:@"senderheadicon"];
    [dic setValue:msg forKey:@"chatcontent"];
    [dic setValue:destDateString forKey:@"sendtime"];
    [dic setValue:@"self" forKey:@"type"];
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:msg forKey:@"chatcontent"];
    [post.postArgs setValue:[Entironment instance].loginName  forKey:@"senderuserid"];
    [post.postArgs setValue:friendId  forKey:@"receiveruserid"];

    post.URL = URL_FOR(@"miSendMessage.do");
    [post start:^(SHTask *t) {
        [self dismissWaitDialog];
        [mList addObject:dic];
        [self.tableView reloadData];
        [self checkBottom];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
        
    }];
    
}
@end
