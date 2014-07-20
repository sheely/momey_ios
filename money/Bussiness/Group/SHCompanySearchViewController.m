//
//  SHCompanySearchViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHCompanySearchViewController.h"

@interface SHCompanySearchViewController ()

@end

@implementation SHCompanySearchViewController

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
    self.title = @"公司查找";
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"queryCompanyInit.do");
    post.cachetype = CacheTypeTimes;
    [post start:^(SHTask * t) {
        [self dismissWaitDialog];
        mList = [t.result valueForKey:@"companyCategoryList"];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
    }];

    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnTypeOnTouch:(id)sender {
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i =0 ; i< mList.count; i++) {
        KxMenuItem* item = [KxMenuItem menuItem: [[mList objectAtIndex:i] valueForKey:@"value"] image:nil target:self action:@selector(btnKxMenuOnTouch:)];
        item.tag = i;
        [array addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:[self.view convertRect:btnType.frame fromView:btnType] menuItems:array];
}

- (void)btnKxMenuOnTouch:(KxMenuItem*) item{
    [btnType setTitle:item.title forState:UIControlStateNormal];
    dictype =[mList objectAtIndex:item.tag];
}

- (IBAction)btnSearchOnTouch:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(companysearchviewcontrollerDidSubmit:type:company:)]){
        [self.delegate companysearchviewcontrollerDidSubmit:self type:dictype company:txtCompany.text];
     }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
