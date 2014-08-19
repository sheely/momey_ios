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
        listRegion  =[t.result valueForKey:@"address"];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
        [t.respinfo show];
    }];
  _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:_tapGestureRec];
    // Do any additional setup after loading the view from its nib.
}

- (void)closeKeyboard
{
    [self.txtName resignFirstResponder];
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
    NSString * type = [dicType valueForKey:@"key"];
    NSString * company = [dicCompany valueForKey:@"key"];
    NSString * region = [dicRegion valueForKey:@"key"];
    [post.postArgs setValue:type.length > 0 ? type:@"" forKey:@"oppoType"];
    [post.postArgs setValue:company.length > 0 ? company:@"" forKey:@"companyId"];
    [post.postArgs setValue:region.length > 0 ? region:@"" forKey:@"address"];
    [post.postArgs setValue:self.txtName.text.length > 0 ? self.txtName.text:@"" forKey:@"friendname"];
//    [post.postArgs setValue:[dicRegion valueForKey:@"key"] forKey:@"address"];
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
- (void)kxmRegion:(KxMenuItem*)k
{
    dicRegion = [listRegion objectAtIndex:k.tag];
    [self.btnRegion setTitle:k.title forState:UIControlStateNormal];
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
        item.title =[[listRegion objectAtIndex:i] valueForKey:@"value"];
        item.tag = i ;
        item.target = self;
        item.action = @selector(kxmRegion:);
        [array addObject:item];
    }
    [KxMenu showMenuInView:self.view fromRect:[self.view convertRect:self.btnRegion.frame fromView:self.btnRegion] menuItems:array];
}
@end
