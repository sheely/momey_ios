//
//  SHChatDetailViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-10.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHChatDetailViewController : SHTableViewController
{
    BOOL isAnimation;
}
@property (weak, nonatomic) IBOutlet UITextField *txtBox;
@property (weak, nonatomic) IBOutlet UIButton *btnSender;

@end
