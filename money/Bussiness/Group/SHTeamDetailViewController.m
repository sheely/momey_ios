//
//  SHTeamDetailViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-19.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTeamDetailViewController.h"
#import "SHGroupListViewCell.h"
#import "SHTeamMemberCell.h"

@interface SHTeamDetailViewController ()

@end

@implementation SHTeamDetailViewController

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
    self.title = @"团队详情";
    mList = [@[@"",@"",@""]mutableCopy];
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryTeamDetail.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"teamId"] forKey:@"teamId"];
    
    [post start:^(SHTask * t) {
        [self dismissWaitDialog];
        dic = (NSDictionary*)t.result ;
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [self dismissWaitDialog];
        [t.respinfo show];
    }];

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
            lab.text = @"  团队成员";
            
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
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return  80;
    }else if (indexPath.section == 1){
        NSString* msg = [dic valueForKey:@"teamIntroduction"];
        if(msg.length > 0){
            CGSize size = [msg sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(310, 99999) lineBreakMode:NSLineBreakByTruncatingTail];;
            return  44 - 18 + size.height;
        }else{
            return 0;
        }
    }
    else{
        return 65;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2){
        return [[dic valueForKey:@"teamMembers"] count];
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2){
        NSDictionary * dic_  = [[dic valueForKey:@"teamMembers"] objectAtIndex:indexPath.row];
        SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
        NSDictionary * dic = [mList objectAtIndex:indexPath.row];
        [intent.args setValue: [dic_ valueForKey:@"memberId"]forKey:@"friendId"];
        
        [[UIApplication sharedApplication]open:intent];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHTableViewGeneralCell * cell;
    if(indexPath.section == 0){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHGroupListViewCell" owner:nil options:nil] objectAtIndex:0];
        cell.labTitle.text = [dic valueForKey:@"teamName"];
        ((SHGroupListViewCell*)cell).labContent.text = [dic valueForKey:@"teamType"];
        [((SHGroupListViewCell*)cell).imgView setUrl:[dic valueForKey:@"teamHeadIcon"]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if(indexPath.section == 1){
        cell = [tableView dequeueReusableGeneralCell];
        cell.labTitle.text = [dic valueForKey:@"teamIntroduction"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHTeamMemberCell" owner:nil options:nil] objectAtIndex:0];
        NSDictionary *dicm = [[dic valueForKey:@"teamMembers"] objectAtIndex:indexPath.row];
        ((SHTeamMemberCell*)cell).labTitle.text = [dicm valueForKey:@"memberName"];
        [((SHTeamMemberCell*)cell).imageView setUrl:[dicm valueForKey:@"memberHeadIcon"]];
        if([[dicm valueForKey:@"isOwner"] boolValue]){
            ((SHTeamMemberCell*)cell).labContent.text = @"发起人";
        }else{
            ((SHTeamMemberCell*)cell).labContent.text = @"";
            
        }
    }
   
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
