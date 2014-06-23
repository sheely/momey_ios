//
//  SHLoginViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-8.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHLoginViewController : SHViewController <UITextFieldDelegate>

- (IBAction)btnLoginOnTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@end
