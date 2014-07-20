//
//  SHCompanySearchViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@class SHCompanySearchViewController;

@protocol SHCompanySearchViewControllerDelegate <NSObject>

- (void) companysearchviewcontrollerDidSubmit:(SHCompanySearchViewController*) controller type:(NSDictionary * ) type company:(NSString * ) company;

@end

@interface SHCompanySearchViewController : SHViewController
{
    NSArray * mList;
    __weak IBOutlet UIButton *btnType;
    NSDictionary * dictype;
    __weak IBOutlet UITextField *txtCompany;
    
}

@property (nonatomic,assign) id <SHCompanySearchViewControllerDelegate> delegate;
- (IBAction)btnSearchOnTouch:(id)sender;

@end
