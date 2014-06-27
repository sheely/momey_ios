//
//  SHAttachmentViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-15.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHAttachmentViewController.h"

@interface SHAttachmentViewController ()

@end

@implementation SHAttachmentViewController

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
    self.title = @"财信附件";

    // Do any additional setup after loading the view from its nib.
}

- (void)loadNext
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"queryAttachment.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    [post.postArgs setValue:@"queryAttachment" forKey:@"attachments"];
    [post.postArgs setValue:[NSNumber numberWithInt:2] forKey:@"attachmentType"];
    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [t.result valueForKey:@"opportunies"];
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
    }];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}


- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * url = [[mList objectAtIndex:indexPath.row] valueForKey:@"attachmentUrl"];
    NSArray * array = [url componentsSeparatedByString:@"/"];
    SHTableViewGeneralCell * cell = [tableView dequeueReusableGeneralCell];
    cell.labTitle.text = [array objectAtIndex:array.count-1];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHIntent * intent = [[SHIntent alloc]init:@"webbrowser" delegate:nil containner:self.navigationController];
    NSString * url = [[mList objectAtIndex:indexPath.row] valueForKey:@"attachmentUrl"];
      NSArray * array = [url componentsSeparatedByString:@"/"];
    [intent.args setValue:url forKey:@"url"];
    [intent.args setValue:[array objectAtIndex:array.count -1] forKey:@"title"];

    [[UIApplication sharedApplication]open:intent];
}

@end
