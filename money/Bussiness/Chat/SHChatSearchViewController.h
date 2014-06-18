//
//  SHChatSearchViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHChatSearchViewController : SHViewController

@property (weak, nonatomic) IBOutlet UIButton *btnType;
@property (weak, nonatomic) IBOutlet UIButton *btnCompany;
- (IBAction)btnSearchOnTouch:(id)sender;
- (IBAction)btnTypeOnTouch:(id)sender;
- (IBAction)btnCompanyOnTouch:(id)sender;
@end
