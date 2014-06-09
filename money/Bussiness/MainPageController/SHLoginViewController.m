//
//  SHLoginViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-8.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHLoginViewController.h"

@interface SHLoginViewController ()

@end

@implementation SHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
+ (BOOL) __GET_PRE_ACTION_STATE :(NSError *) error
{
    return [Entironment.instance sessionid].length > 0;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginOnTouch:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
}
@end
