//
//  SHExecuteViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-16.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHExecuteViewController.h"

@interface SHExecuteViewController ()
{
    UITapGestureRecognizer* _tapGestureRec;
}
@end

@implementation SHExecuteViewController

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
    self.title = @"执行信息";
    if([[self.intent.args valueForKey:@"type"] length ] > 0 &&  [[self.intent.args valueForKey:@"type"] caseInsensitiveCompare:@"self"] == NSOrderedSame){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" target:self action:@selector(btnSubmit:)];
        btnStart.enabled = YES;
        btnEnd.enabled = YES;
        txtBudge.enabled = YES;
        txtMark.enabled = YES;
        txtPlace.enabled = YES;
    }
    if([UIApplication sharedApplication].keyWindow.bounds.size.height < 546){
        self.keybordView = self.view;
        self.keybordheight = 80;
    }
     _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:_tapGestureRec];
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    post.URL = URL_FOR(@"queryexecuteinfodetail.do");
    [post start:^(SHTask *t) {
        dic = t.result;
        labExecuter.text = [dic valueForKey:@"oppoPublisher"];
        txtPlace.text = [dic valueForKey:@"executePlace"];
        txtMark.text = [dic valueForKey:@"remark"];
        [btnStart setTitle:[dic valueForKey:@"startTime"] forState:UIControlStateNormal];
        [btnEnd setTitle:[dic valueForKey:@"endTime"] forState:UIControlStateNormal];
        
        [btnStart setTitle:[dic valueForKey:@"startTime"] forState:UIControlStateDisabled];
        [btnEnd setTitle:[dic valueForKey:@"endTime"] forState:UIControlStateDisabled];
        
        txtBudge.text = [dic valueForKey:@"budget"];

        
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
    }];
    calendarcontroller = [[SHCalendarViewController alloc]init];
    calendarcontroller.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)closeKeyboard
{
    [txtPlace resignFirstResponder];
    [txtMark resignFirstResponder];
    [txtBudge resignFirstResponder];

}

- (void)btnSubmit:(NSObject*)sender
{
    if(btnStart.titleLabel.text.length == 0){
        [self showAlertDialog:@"开始时间不能为空"];
        return;
    }
    if(btnEnd.titleLabel.text.length == 0){
        [self showAlertDialog:@"结束时间不能为空"];
        return;
    }
    if(txtPlace.text.length == 0){
        [self showAlertDialog:@"地点不能为空"];
        return;
    }
    if(txtBudge.text.length == 0 || [txtBudge.text intValue] < 0 ){
        [self showAlertDialog:@"预算值非法"];
        return;
    }
    [self showWaitDialogForNetWork];

    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    [post.postArgs setValue:@"executeInfo" forKey:@"requestType"];
    [post.postArgs setValue:btnStart.titleLabel.text forKey:@"startTime"];
    [post.postArgs setValue:btnEnd.titleLabel.text forKey:@"endTime"];
    [post.postArgs setValue:txtPlace.text forKey:@"executePlace"];
    [post.postArgs setValue:txtBudge.text forKey:@"budget"];
    [post.postArgs setValue:txtMark.text forKey:@"remark"];
    [post.postArgs setValue: [NSNumber numberWithInt:1]forKey:@"isPublic"];
    post.URL = URL_FOR(@"miExecuteInfo.do");
    [post start:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSeeOnTouch:(id)sender
{
    if([[dic valueForKey:@"oppoPublisherId"] length ] == 0){
        [self showAlertDialog:@"尚未确定执行人"];
    }else{
        SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
        [intent.args setValue:[dic valueForKey:@"oppoPublisherId"] forKey:@"friendId"];
        [[UIApplication sharedApplication]open:intent];
    }
  }

- (IBAction)btnCalendarOnTouch:(id)sender {
    mButton = sender;
    [calendarcontroller show];
    [txtPlace resignFirstResponder];
    [txtMark resignFirstResponder];
    [txtBudge resignFirstResponder];
}

-(void)calendarViewController:(SHCalendarViewController *)controller dateSelected:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    [mButton setTitle:destDateString forState:UIControlStateNormal];
    [controller close];
}


@end
