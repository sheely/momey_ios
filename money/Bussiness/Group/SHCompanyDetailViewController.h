//
//  SHCompanyDetailViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-5.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHCompanyDetailViewController : SHViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * mList;
    NSDictionary * dic ;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
