//
//  SHCompanyDetailViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-5.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHCompanyDetailViewController.h"
#import "SHGroupListViewCell.h"

@interface SHCompanyDetailViewController ()

@end

@implementation SHCompanyDetailViewController

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
    self.title = @"公司详情";
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryCompanyDetail.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"companyId"] forKey:@"companyId"];
 
    [post start:^(SHTask * t) {
        [self dismissWaitDialog];
        dic = (NSDictionary*)t.result;
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
        [t.respinfo show];
    }];
 
    mList = [@[@"",@"",@"",@""]mutableCopy];
    // Do any additional setup after loading the view from its nib.
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * lab =  [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 30)];
    lab.userstyle = @"labminlight";
    switch (section) {
        case 0:
            
            break;
        case 1:
            lab.text = @"  简介";
            break;
        case 2:
            lab.text = @"  服务产品";

            break;
        case 3:
            lab.text = @"  主要客户";

            break;
            
        default:
            break;
    }
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0;
    }else{
        return 30;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return  80;
    }else if (indexPath.section == 1){
        NSString* msg = [dic valueForKey:@"introduction"];
        if(msg.length > 0){
            CGSize size = [msg sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(310, 99999) lineBreakMode:NSLineBreakByTruncatingTail];;
            return  44 - 18 + size.height;
        }else{
            return 0;
        }
    }else if (indexPath.section == 2){
        
        NSArray* com = [dic valueForKey:@"companyProducts"];
        if(com.count > 0 ){
            NSMutableString * msg = [[NSMutableString alloc]init];
            for (int i = 0;i < com.count; i++) {
                [msg appendFormat:@"%@,",[[com objectAtIndex:i] valueForKey:@"productName"]];
            }
            CGSize size = [msg sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(310, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
            return  44 - 18 + size.height;
        }else{
            return 0;
        }
        
    }else if (indexPath.section == 3){
        
        NSString* msg = [dic valueForKey:@"mainClients"];
        if(msg.length > 0){
            CGSize size = [msg sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(310, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
            return  44 - 18 + size.height;
        }else{
            return 0;
        }
        
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHGroupListViewCell * cell;
    if(indexPath.section == 0){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHGroupListViewCell" owner:nil options:nil] objectAtIndex:0];
        cell.labTitle.text = [dic valueForKey:@"companyName"];
        [cell.imgView setUrl:[dic valueForKey:@"companyHeadIcon"]];
        cell.labContent.text = [dic valueForKey:@"companyType"];
        
        
    }else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableGeneralCell];
        cell.labTitle.text =  [dic valueForKey:@"introduction"];
    }else if (indexPath.section == 2){
        NSArray* com = [dic valueForKey:@"companyProducts"];
        NSMutableString * msg = [[NSMutableString alloc]init];
        for (int i = 0;i < com.count; i++) {
            [msg appendFormat:@"%@,",[[com objectAtIndex:i] valueForKey:@"productName"]];
        }
        
        cell = [tableView dequeueReusableGeneralCell];
        cell.labTitle.text =  msg;
        
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableGeneralCell];
        cell.labTitle.text =  [dic valueForKey:@"mainClients"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
