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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMegOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"chatdetail" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnSeeOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnAttachmentOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"attachment" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];
  
}

- (IBAction)btnExecuteOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"executeinfo" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];

}
@end
