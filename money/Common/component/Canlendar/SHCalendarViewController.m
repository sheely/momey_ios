//
//  SHCalendarViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-16.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHCalendarViewController.h"

@interface SHCalendarViewController ()

@end

@implementation SHCalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadSkin
{
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
- (void)show
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.view];
}

- (void)close
{
    [self.view removeFromSuperview];
}

- (IBAction)btnOnTouch:(id)sender
{
    [self close];
}
@end
