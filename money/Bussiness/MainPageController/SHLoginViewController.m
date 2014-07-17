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
    self.keybordView = self.view;
    self.keybordheight = 70;
    self.txtLogin.text = [[NSUserDefaults standardUserDefaults] stringForKey:LOGIN_INFO];
#ifdef DEBUG
    self.txtLogin.text = @"germmy";
    self.txtPassword.text = @"123456" ;
    //e10adc3949ba59abbe56e057f20f883e
#endif
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.txtLogin){
        [self.txtPassword becomeFirstResponder];
    }else{
        [self btnLoginOnTouch:nil];
    }
    return YES;
}
// called when 'return' key pressed. return NO to ignore.

- (IBAction)btnLoginOnTouch:(id)sender
{
   
    if(self.txtLogin.text.length == 0 || self.txtPassword.text.length == 0){
        [self showAlertDialog:@"用户名或密码不能为空"];
        return;
    }
     [self showWaitDialogForNetWork];
    Entironment.instance.loginName = self.txtLogin.text;
    Entironment.instance.password = [[self.txtPassword.text md5Encrypt]lowercaseString];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:@"" forKey:@"appUuid"];
    post.URL = URL_FOR(@"milogin.do");
    [post start:^(SHTask * t) {
        [self dismissWaitDialog];
        //Entironment.instance.sessionid = [t.result valueForKey:@"sessionId"];
        [[NSUserDefaults standardUserDefaults] setValue:self.txtLogin.text forKey:LOGIN_INFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        
        [self dismissWaitDialog];
//        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];

        [t.respinfo show];
        
    }];

}
@end
