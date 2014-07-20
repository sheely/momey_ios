//
//  SHTeamSearchViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTeamSearchViewController.h"

@interface SHTeamSearchViewController ()

@end

@implementation SHTeamSearchViewController

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
    self.title = @"团队查找";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSubmit:(id)sender {
    if(self.delegate){
        [self.delegate teamSearchViewController:self createName:self.btnCreate.titleLabel.text teamName:self.txtTeam.text username:self.btnTeamMember.titleLabel.text];
    }
}

- (IBAction)btnCreateOnTouch:(id)sender {

    mBtnTemp  = sender;
    SHIntent * indent = [[SHIntent alloc]init:@"usersearchcondition" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:indent];
}

- (void) chatsearchviewcontrollerDidSubmit:(SHChatSearchViewController *)controller list:(NSArray *)list
{
    NSMutableArray * array = [self.navigationController.viewControllers mutableCopy];
    [array removeLastObject];
    self.navigationController.viewControllers = array;
    SHIntent * indent = [[SHIntent alloc]init:@"teamsearchuserlist" delegate:self containner:self.navigationController];
    [indent.args setValue:list forKey:@"list"];
    [[UIApplication sharedApplication]open:indent];

}
- (void) teamSearchUserViewController:(SHTeamSearchUserViewController *)controller selectd:(NSDictionary *)dic
{
    [mBtnTemp setTitle:[dic valueForKey:@"friendName"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
