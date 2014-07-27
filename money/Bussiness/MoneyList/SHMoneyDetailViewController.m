//
//  SHMoneyDetailViewController.m
//  money
//
//  Created by zywang on 14-6-14.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHMoneyDetailViewController.h"

@interface SHMoneyDetailViewController ()

@end

@implementation SHMoneyDetailViewController

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
    self.title = @"财信详情";
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryOppoDetail.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    [self showWaitDialogForNetWork];
    [post start:^(SHTask * t) {
        dic = (NSDictionary*)t.result;
        labTitle.text = [dic valueForKey:@"oppoTitle"];
        labContent.text = [dic valueForKey:@"oppoContent"];
        labContent.font = [NVSkin.instance fontOfStyle:@"FontScaleMid"];
        labOrder.text = [dic valueForKey:@"oppoPublisher"];
        labType.text = [dic valueForKey:@"oppoType"];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMegOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"commentdetail" delegate:nil containner:self.navigationController];
    [intent.args setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];

    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnSeeOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
    [intent.args setValue:[dic valueForKey:@"oppoPublisherId"] forKey:@"friendId"];

    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnAttachmentOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"attachment" delegate:nil containner:self.navigationController];
    [intent.args setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    [[UIApplication sharedApplication]open:intent];
  
}

- (IBAction)btnExecuteOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"executeinfo" delegate:nil containner:self.navigationController];
    [intent.args setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];

    [[UIApplication sharedApplication]open:intent];

}

- (IBAction)btnMarkOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"userreport" delegate:nil containner:self.navigationController];
    //NSString* username =  [[NSUserDefaults standardUserDefaults] valueForKey:@"LOGIN_INFO"];
    
    [intent.args setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    [[UIApplication sharedApplication]open:intent];

    
}
@end
