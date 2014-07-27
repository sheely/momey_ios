//
//  SHReportViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-1.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHReportViewController.h"

@interface SHReportViewController ()

@end

@implementation SHReportViewController

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
    self.title = @"我要评论";
    if ([[self.intent.args valueForKey:@"commenterType"] intValue ]== 1) {
        self.title = @"承接人评论";
    }else {
        self.title = @"执行人评论";
    }
    if([[self.intent.args valueForKey:@"content"] length]>0){
        self.txtView.text = [self.intent.args valueForKey:@"content"];
    }
    [self.txtView becomeFirstResponder];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" target:self action:@selector(btnReport:)];
    // Do any additional setup after loading the view from its nib.
}

- (void)btnReport:(UIButton*)b
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"commentAdd.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
  
    [post.postArgs setValue:[self.intent.args valueForKey:@"commenterType"] forKey:@"commenterType"];
    [post.postArgs setValue:self.txtView.text forKey:@"leaveComment"];
    
    [post start:^(SHTask * t) {
        [self dismissWaitDialog];
        [self.navigationController popViewControllerAnimated:YES];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
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
