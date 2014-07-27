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
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryFriendInit.do");
    [post start:^(SHTask * t) {
        listType = [t.result valueForKey:@"oppoTypes"];
        listCompany = [t.result valueForKey:@"companys"];
        
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
        [t.respinfo show];
    }];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSearchOnTouch:(id)sender
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryFriend.do");
    [post.postArgs setValue:@"" forKey:@"oppoType"];
    [post.postArgs setValue:@"" forKey:@"companyId"];
    [post.postArgs setValue:@"" forKey:@"address"];
    [post start:^(SHTask * t) {
        [self dismissWaitDialog];
        NSArray * list  = [t.result valueForKey:@"friendList"];
        if(self.delegate){
            [self.delegate chatsearchviewcontrollerDidSubmit:self list:list];
        }
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
        [t.respinfo show];
    }];
//self.view
}

- (IBAction)btnTypeOnTouch:(id)sender {
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i =0 ; i< listType.count ; i++) {
        KxMenuItem* item = [[KxMenuItem alloc] init];
        item.title =[[listType objectAtIndex:i] valueForKey:@"value"];
        item.tag = i ;
        item.target = self;
        item.action = @selector(kxmType:);
        [array addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:[self.view convertRect:self.btnType.frame fromView:self.btnType] menuItems:array];
}

- (void)kxmType:(KxMenuItem*)k
{
    dicType = [listType objectAtIndex:k.tag];
    [self.btnType setTitle:k.title forState:UIControlStateNormal];
}

- (void)kxmCompany:(KxMenuItem*)k
{
    dicCompany = [listCompany objectAtIndex:k.tag];
    [self.btnCompany setTitle:k.title forState:UIControlStateNormal];
}

- (IBAction)btnCompanyOnTouch:(id)sender
{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i =0 ; i< listCompany.count; i++) {
        KxMenuItem* item = [[KxMenuItem alloc] init];
        item.title = [[listCompany objectAtIndex:i] valueForKey:@"value"];
        item.tag = i ;
        item.target = self;
        item.action = @selector(kxmCompany:);
        [array addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:[self.view convertRect:self.btnCompany.frame fromView:self.btnCompany] menuItems:array];

}

- (IBAction)btnRegionOnTouch:(id)sender {
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i =0 ; i< listType.count ; i++) {
        KxMenuItem* item = [[KxMenuItem alloc] init];
        item.title =[[listType objectAtIndex:i] valueForKey:@"value"];
        item.tag = i ;
        item.target = self;
        item.action = @selector(kxmType:);
        [array addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:[self.view convertRect:self.btnType.frame fromView:self.btnType] menuItems:array];
}
@end
