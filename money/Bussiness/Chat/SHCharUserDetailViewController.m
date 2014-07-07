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
                [s appendFormat:@"%@\n",[a objectAtIndex:i]];
            }

            CGSize size = [s sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(280, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
            return  44 - 18 + size.height;
        }
        case 3:
        {
            NSArray *a = [dic valueForKey:@"personalExperience"];
            
            NSMutableString * s = [[NSMutableString alloc]init];
            for (int i = 0; i<a.count; i++) {
                [s appendFormat:@"%@\n",[a objectAtIndex:i]];
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
                [s appendFormat:@"%@\n",[a objectAtIndex:i]];
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
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miQueryFriendDetail.do");
    [post.postArgs setValue:@"zhangsan" forKey:@"friendId"];
    
    [post start:^(SHTask * t) {
        dic = t.result;
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
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

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            SHChatUserInfoViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUserInfoViewCell" owner:nil options:nil] objectAtIndex:0];
            cell.labUser.text = [dic valueForKey:@"friendName"];
            [cell.imgView setUrl:[dic valueForKey:@"friendHeadIcon"]];
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
                [s appendFormat:@"%@\n",[a objectAtIndex:i]];
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
                [s appendFormat:@"%@\n",[a objectAtIndex:i]];
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
                [s appendFormat:@"%@\n",[a objectAtIndex:i]];
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
