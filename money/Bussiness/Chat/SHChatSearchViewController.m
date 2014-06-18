//
//  SHChatSearchViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatSearchViewController.h"

@interface SHChatSearchViewController ()

@end

@implementation SHChatSearchViewController

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
    self.title = @"财友搜索";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSearchOnTouch:(id)sender
{
    SHIntent * indent = [[SHIntent alloc]init:@"usersearchlist" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:indent];
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

- (IBAction)btnCompanyOnTouch:(id)sender
{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i =0 ; i< 5; i++) {
        KxMenuItem* item = [[KxMenuItem alloc] init];
        item.title = @"大众点评";
        [array addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:[self.view convertRect:self.btnCompany.frame fromView:self.btnCompany] menuItems:array];

}
@end
