//
//  SHMoneySearchViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-17.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHMoneySearchViewController.h"

@interface SHMoneySearchViewController ()

@end

@implementation SHMoneySearchViewController

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
    self.title = @"查找条件";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnTypeOnTouch:(id)sender {
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i =0 ; i< 5; i++) {
        KxMenuItem* item = [[KxMenuItem alloc] init];
        item.title = @"分类";
        [array addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:[self.view convertRect:self.btnType.frame fromView:self.btnType] menuItems:array];
}
- (IBAction)btnSearchOnTouch:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(moneysearchviewcontrollerDidSubmit:)]){
        [self.delegate moneysearchviewcontrollerDidSubmit:self];
    }
}
@end
