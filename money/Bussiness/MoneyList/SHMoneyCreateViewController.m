//
//  SHMoneyCreateViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-28.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHMoneyCreateViewController.h"

@interface SHMoneyCreateViewController ()

@end

@implementation SHMoneyCreateViewController

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
    self.title = @"新建财信";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" target:self action:@selector(btnSubmit:)];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miAddNewOppoGuide.do");
      [post start:^(SHTask * t) {
        [self dismissWaitDialog];
          array = [t.result valueForKey:@"oppoTypes"];
      } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
        [t.respinfo show];
    }];
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:_tapGestureRec];

}
- (void)closeKeyboard
{
    [txtContent resignFirstResponder];
}
    // Do any additional setup after loading the view from its nib.


- (void)btnSubmit:(NSObject*)sender
{
    if(mdic == nil){
        [self showAlertDialog:@"请选择财信分类"];
        return;
    }
    if(txtTitle.text.length  == 0){
        [self showAlertDialog:@"请输入标题"];
        return;
    }
    if(mdic == nil){
        [self showAlertDialog:@"请输入内容"];
        return;
    }
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miOppoAdd.do");
    [post.postArgs setValue:txtTitle.text forKey:@"oppotitle"];
    [post.postArgs setValue:[mdic valueForKey:@"key"] forKey:@"oppotype"];
    [post.postArgs setValue:txtContent.text forKey:@"oppocontent"];
    [post start:^(SHTask * t) {
        [self dismissWaitDialog];
        [t.respinfo show];
        if(self.delegate && [self.delegate respondsToSelector:@selector(moneyCreateViewControllerDidSubmit)]){
            [self.delegate moneyCreateViewControllerDidSubmit];

        }
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

- (IBAction)btnOnTouch:(id)sender {
    NSMutableArray * array2 = [[NSMutableArray alloc]init];
    for (int i =0 ; i< array.count; i++) {
        KxMenuItem* item = [KxMenuItem menuItem: [[array objectAtIndex:i] valueForKey:@"value"] image:nil target:self action:@selector(btnKxMenuOnTouch:)];
        item.tag = i;
        [array2 addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:self.btnType.frame  menuItems:array2];

}

- (void)btnKxMenuOnTouch:(KxMenuItem *)sender
{
    mdic = [array objectAtIndex:sender.tag];
    [self.btnType setTitle:[mdic valueForKey:@"value"] forState:UIControlStateNormal];
}
@end
