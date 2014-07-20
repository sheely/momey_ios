//
//  SHCharUserDetailViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-10.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHCharUserDetailViewController.h"
#import "SHChatPersonalExperienceViewCell.h"
#import "SHChatUserInfoViewCell.h"
#import "SHChatUserBaseInfoViewCell.h"

@interface SHCharUserDetailViewController ()

@end

@implementation SHCharUserDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 120;
            break;
        case 1:
            return 225;
            
        case 2:
        {
            NSArray *a = [dic valueForKey:@"techonologyTitle"];
            
            NSMutableString * s = [[NSMutableString alloc]init];
            for (int i = 0; i<a.count; i++) {
                [s appendFormat:@"%@\n",[[a objectAtIndex:i] valueForKey:@"techonologyName"]];
            }

            CGSize size = [s sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(280, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
            return  44 - 18 + size.height;
        }
        case 3:
        {
            NSArray *a = [dic valueForKey:@"personalExperience"];
            
            NSMutableString * s = [[NSMutableString alloc]init];
            for (int i = 0; i<a.count; i++) {
                [s appendFormat:@"%@\n",[[a objectAtIndex:i] valueForKey:@"experienceName"]];
            }
            
            CGSize size = [s sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(280, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
            return  44 - 18 + size.height;
        }
            
            break;
        case 4:
        {
            NSArray *a = [dic valueForKey:@"personalClients"];
            
            NSMutableString * s = [[NSMutableString alloc]init];
            for (int i = 0; i<a.count; i++) {
                [s appendFormat:@"%@\n",[[a objectAtIndex:i] valueForKey:@"clientName"]];
            }
            
            CGSize size = [s sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(280, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
            return  44 - 18 + size.height;
        }
        
            break;
      

    };
    return 44;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0;
    }else{
        return 30;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * lab =  [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 30)];
    lab.userstyle = @"labminlight";
    lab.backgroundColor = self.view.backgroundColor;
    switch (section) {
        case 0:
            
            break;
        case 1:
            lab.text = @"  基本资料";
            break;
        case 2:
            lab.text = @"  职称和职业资格";
            break;
        case 3:
            lab.text = @"  任职经历";
            break;

        case 4:
            lab.text = @"  服务客户";
            
            break;
        case 5:
            lab.text = @"  个人技能";
            break;

        case 6:
            lab.text = @"  成功案例";
            
            break;
        case 7:
            lab.text = @"  日历";
            
            break;
            
        default:
            break;
    }
    return lab;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"基本资料";
    [self dismissWaitDialog];

    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryFriendDetail.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"friendId"] forKey:@"friendId"];
    
    [post start:^(SHTask * t) {
        dic = t.result;
        [self.tableView reloadData];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
        [self dismissWaitDialog];

    }];
    // Do any additional setup after loading the view from its nib.
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:{
            return 1;
             break;
        }case 3:{
            return 1;
             break;
        }case 4:{
            return 1;
            break;
        }case 5:{
            NSArray *a = [dic valueForKey:@"personalSkills"];
            return a.count;
            break;
        }case 6:{
            NSArray *a = [dic valueForKey:@"successfulCases"];
            return a.count;
            break;
        }case 7:{
            NSArray *a = [dic valueForKey:@"myTasks"];
            return a.count;
            break;
        }
            break;
        default:
            return 0;
            break;
    }

}

- (void)btnAddFavorate:(NSObject*)sender
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miFollowerAdd.do");
    NSNumber * value = [[dic valueForKey:@"isFollowed"] intValue] == 0 ? [NSNumber numberWithInt:1]:[NSNumber numberWithInt:0];
    [post.postArgs setValue:Entironment.instance.loginName forKey:@"myUserName"];
    [post.postArgs setValue:[dic valueForKey:@"friendId"] forKey:@"followerUserName"];
    [post.postArgs setValue:value forKey:@"addOrDelete"];
    [post start:^(SHTask *t) {
        [dic setValue:value forKey:@"isFollowed"];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [t.respinfo show];

        [self dismissWaitDialog];
        
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
    }];
    

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            SHChatUserInfoViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUserInfoViewCell" owner:nil options:nil] objectAtIndex:0];
            cell.labUser.text = [dic valueForKey:@"friendName"];
            [cell.imgView setUrl:[dic valueForKey:@"friendHeadIcon"]];
            [cell.btnAddFavorate addTarget:self action:@selector(btnAddFavorate:) forControlEvents:UIControlEventTouchUpInside];
            if([[dic valueForKey:@"isFollowed"]integerValue] == 1){
                [cell.btnAddFavorate setTitle:@"取消关注" forState:UIControlStateNormal];
                cell.btnAddFavorate.userstyle = @"btnclosemoney";
            }else {
                [cell.btnAddFavorate setTitle:@"添加关注" forState:UIControlStateNormal];
                cell.btnAddFavorate.userstyle = @"btnsubmit";
            }
            cell.btnAddFavorate.titleLabel.font = [NVSkin.instance fontOfStyle:@"FontScaleSmall"];

            return  cell;
        }
            break;
        case 1:
        {
            SHChatUserBaseInfoViewCell * cell =  [[[NSBundle mainBundle]loadNibNamed:@"SHChatUserBaseInfoViewCell" owner:nil options:nil] objectAtIndex:0];
            cell.labCompany.text = [dic valueForKey:@"companyName"];
            cell.labMail.text = [dic valueForKey:@"friendMail"];
            cell.labPosition.text = [dic valueForKey:@"friendTitle"];
            cell.labSchool.text = [dic valueForKey:@"graduatedSchool"];
            cell.labStanddard.text = [dic valueForKey:@"chargeStandard"];
            cell.labPhone.text = [dic valueForKey:@"friendMobile"];
            cell.labStudy.text = [dic valueForKey:@"maxAttainment"];
            return cell;
        }
            break;
        case 2:
            
        {
            //                       SHChatPersonalExperienceViewCell * cell =  [[[NSBundle mainBundle]loadNibNamed:@"SHChatPersonalExperienceViewCell" owner:nil options:nil] objectAtIndex:0];
            //cell.labContent.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
            NSArray *a = [dic valueForKey:@"techonologyTitle"];
            
            NSMutableString * s = [[NSMutableString alloc]init];
            for (int i = 0; i<a.count; i++) {
                [s appendFormat:@"%@\n",[[a objectAtIndex:i] valueForKey:@"techonologyName"]];
            }
            SHTableViewGeneralCell * cell  = [tableView dequeueReusableGeneralCell];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.labTitle.text = s;
            return cell;
        }
            break;
        case 3:
            
        {
            //                       SHChatPersonalExperienceViewCell * cell =  [[[NSBundle mainBundle]loadNibNamed:@"SHChatPersonalExperienceViewCell" owner:nil options:nil] objectAtIndex:0];
            //cell.labContent.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
            NSArray *a = [dic valueForKey:@"personalExperience"];
            
            NSMutableString * s = [[NSMutableString alloc]init];
            for (int i = 0; i<a.count; i++) {
                [s appendFormat:@"%@\n",[[a objectAtIndex:i]valueForKey:@"experienceName" ]];
            }
            SHTableViewGeneralCell * cell  = [tableView dequeueReusableGeneralCell];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.labTitle.text = s;
            return cell;
        }
            
            break;
        case 4:
            
        {
            //                       SHChatPersonalExperienceViewCell * cell =  [[[NSBundle mainBundle]loadNibNamed:@"SHChatPersonalExperienceViewCell" owner:nil options:nil] objectAtIndex:0];
            //cell.labContent.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
            NSArray *a = [dic valueForKey:@"personalClients"];
            
            NSMutableString * s = [[NSMutableString alloc]init];
            for (int i = 0; i<a.count; i++) {
                [s appendFormat:@"%@\n",[[a objectAtIndex:i] valueForKey:@"clientName"]];
            }
            SHTableViewGeneralCell * cell  = [tableView dequeueReusableGeneralCell];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.labTitle.text = s;
            return cell;
        }
            
            break;
        case 5:
            
        {
            //                       SHChatPersonalExperienceViewCell * cell =  [[[NSBundle mainBundle]loadNibNamed:@"SHChatPersonalExperienceViewCell" owner:nil options:nil] objectAtIndex:0];
            //cell.labContent.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
            NSArray *a = [dic valueForKey:@"personalSkills"];

            SHTableViewGeneralCell * cell  = [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = [[a objectAtIndex:indexPath.row] valueForKey:@"skillTitle"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            
            break;
        case 6:
            
        {
            //                       SHChatPersonalExperienceViewCell * cell =  [[[NSBundle mainBundle]loadNibNamed:@"SHChatPersonalExperienceViewCell" owner:nil options:nil] objectAtIndex:0];
            //cell.labContent.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
            NSArray *a = [dic valueForKey:@"successfulCases"];
            
            SHTableViewGeneralCell * cell  = [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = [[a objectAtIndex:indexPath.row] valueForKey:@"caseTitle"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            
            break;
        case 7:
            
        {
            //                       SHChatPersonalExperienceViewCell * cell =  [[[NSBundle mainBundle]loadNibNamed:@"SHChatPersonalExperienceViewCell" owner:nil options:nil] objectAtIndex:0];
            //cell.labContent.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
            NSArray *a = [dic valueForKey:@"myTasks"];
            
            SHTableViewGeneralCell * cell  = [tableView dequeueReusableGeneralCell];
            NSString * s = [[a objectAtIndex:indexPath.row] valueForKey:@"startTime"];
            NSString * e = [[a objectAtIndex:indexPath.row] valueForKey:@"endTime"];
            NSString * u = [[a objectAtIndex:indexPath.row] valueForKey:@"taskStatus"];
            cell.labTitle.text = [[NSString alloc]initWithFormat:@"%@ 至 %@ [%@]",s,e,u];
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }
            
            break;
            
        default:
            break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5) {
        NSString *title = [[[dic valueForKey:@"personalSkills"] objectAtIndex:indexPath.row] valueForKey:@"skillTitle"];
        NSString *skillId =[[[dic valueForKey:@"personalSkills"] objectAtIndex:indexPath.row] valueForKey:@"skillId"];
        
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"miQuerySkillCaseDetail.do");
        [post.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"itemType"];
        [post.postArgs setValue:skillId forKey:@"itemId"];
        
        [post start:^(SHTask *t) {
            SHIntent * intent = [[SHIntent alloc]init:@"webview" delegate:nil containner:self.navigationController];
            [intent.args setValue:title forKey:@"title"];
            [intent.args setValue:[t.result valueForKey:@"itemContent"] forKey:@"html"];
            [[UIApplication sharedApplication]open:intent];
            
        } taskWillTry:nil taskDidFailed:^(SHTask *t) {
            [t.respinfo show];
        }];
        
    }else  if (indexPath.section == 6) {
        NSString *title = [[[dic valueForKey:@"successfulCases"] objectAtIndex:indexPath.row] valueForKey:@"caseTitle"];
        NSString *skillId =[[[dic valueForKey:@"successfulCases"] objectAtIndex:indexPath.row] valueForKey:@"caseId"];
        
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"miQuerySkillCaseDetail.do");
        [post.postArgs setValue:[NSNumber numberWithInt:2] forKey:@"itemType"];
        [post.postArgs setValue:skillId forKey:@"itemId"];
        
        [post start:^(SHTask *t) {
            SHIntent * intent = [[SHIntent alloc]init:@"webview" delegate:nil containner:self.navigationController];
            [intent.args setValue:title forKey:@"title"];
            [intent.args setValue:[t.result valueForKey:@"itemContent"] forKey:@"html"];
            [[UIApplication sharedApplication]open:intent];
            
        } taskWillTry:nil taskDidFailed:^(SHTask *t) {
            [t.respinfo show];
        }];
        
    }

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
