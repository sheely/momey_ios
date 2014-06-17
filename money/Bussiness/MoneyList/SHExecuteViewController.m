//
//  SHExecuteViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-16.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHExecuteViewController.h"

@interface SHExecuteViewController ()

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
    calendarcontroller = [[SHCalendarViewController alloc]init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSeeOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnCalendarOnTouch:(id)sender {
    [calendarcontroller show];
}
@end
