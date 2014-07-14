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
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryOppoListInit.do");
    post.cachetype = CacheTypeTimes;
    [post start:^(SHTask * t) {
        [self dismissWaitDialog];
        mList = [t.result valueForKey:@"oppoTypes"];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
    }];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnTypeOnTouch:(id)sender {
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i =0 ; i< mList.count; i++) {
        KxMenuItem* item = [KxMenuItem menuItem: [[mList objectAtIndex:i] valueForKey:@"value"] image:nil target:self action:@selector(btnKxMenuOnTouch:)];
        item.tag = i;
        [array addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:[self.view convertRect:self.btnType.frame fromView:self.btnType] menuItems:array];
}

- (void)btnKxMenuOnTouch:(KxMenuItem*) item{
    [self.btnType setTitle:item.title forState:UIControlStateNormal];
    dictype =[mList objectAtIndex:item.tag];
}

- (IBAction)btnSearchOnTouch:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(moneysearchviewcontrollerDidSubmit:type:boss:title:)]){
        [self.delegate moneysearchviewcontrollerDidSubmit:self type:dictype boss:self.txtBoss.text title:self.txtTitle.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
