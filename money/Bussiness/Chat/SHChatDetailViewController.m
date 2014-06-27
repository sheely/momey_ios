//
//  SHChatDetailViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-10.
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

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.title = @"聊天";
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"queryLmList.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];

    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [[t.result valueForKey:@"leaveMessages"] mutableCopy];
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
    }];
    //[self registerForKeyboardNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
     											 selector:@selector(keyboardWillShown:)
     											 name:UIKeyboardWillShowNotification
     object:nil];
    // Do any additional setup after loading the view from its nib.
}
//- (void)registerForKeyboardNotifications
//{
//	[[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(keyboardDidShown:)
//												 name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(keyboardDidHidden:)
//												 name:UIKeyboardWillHideNotification object:nil];
//}

- (void)keyboardWillShown:(NSNotification*)ns
{
  
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect;
        [[[ns userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&rect];
        self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width,
                                          self.view.frame.size.height - rect.size.height +44-38);
        self.txtBox.frame = CGRectMake(3, self.view.frame.size.height - 30 - rect.size.height + 44 , 250, 30);
        self.btnSender.frame = CGRectMake(261, self.view.frame.size.height - 30 - rect.size.height + 44 , 48, 30);
        isAnimation = YES;
        
    } completion:^(BOOL finished) {
        isAnimation = NO;
    }];
}

- (void)unregisterForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardDidHideNotification
												  object:nil];
}

- (void)keyboardDidHidden:(NSNotification*)ns
{
    isAnimation = YES;

    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width,
                                          self.view.frame.size.height -38);
        self.txtBox.frame = CGRectMake(3, self.view.frame.size.height - 34  , 250, 30);
        self.btnSender.frame = CGRectMake(261, self.view.frame.size.height - 34  , 48, 30);
        
    } completion:^(BOOL finished) {
        isAnimation = NO;
    }];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [[[mList objectAtIndex:indexPath.row] valueForKey:@"lmContent"] sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(183, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
    return  60 - 18 + size.height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!isAnimation){
        [self.txtBox resignFirstResponder];
    }
}

- (void)dealloc
{
    [self unregisterForKeyboardNotifications];
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
    
    
    cell.labTxt.text = [dic valueForKey:@"lmContent"];
    [cell.imgIcon setUrl:[dic valueForKey:@"lmHeadIcon"]];
    cell.labTimer.text = [[dic valueForKey:@"lmTime"] substringWithRange:NSMakeRange(11,5)];
    return cell;
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

- (IBAction)btnSenderOnTouch:(id)sender
{
    NSString * msg = self.txtBox.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"我" forKey:@"leaveMessager"];
    [dic setValue:@"" forKey:@"lmHeadIcon"];
    [dic setValue:msg forKey:@"lmContent"];
    [dic setValue:destDateString forKey:@"lmTime"];
    [dic setValue:@"self" forKey:@"type"];
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    post.URL = URL_FOR(@"lmAdd.do");
    [post start:^(SHTask *t) {
        [self dismissWaitDialog];
          [mList addObject:dic];
         [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];

    }];
   
}


@end
