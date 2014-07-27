//
//  SHEditCalendarViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-4.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHEditCalendarViewController.h"

@interface SHEditCalendarViewController ()

@end

@implementation SHEditCalendarViewController

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
    if([self.intent.args valueForKey:@"info"] == nil){
        self.title = @"新增日程";
        NSDate * date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *destDateString = [dateFormatter stringFromDate:date];
        [self.btnStartTime setTitle:destDateString forState:UIControlStateNormal];
        date = [date addDay:7];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        destDateString = [dateFormatter stringFromDate:date];
        [self.btnEndTime setTitle:destDateString forState:UIControlStateNormal];

    }else{
        NSDictionary * dic = [self.intent.args valueForKey:@"info"];
        [self.btnStartTime setTitle:[dic valueForKey:@"startTime"] forState:UIControlStateNormal];
        [self.btnEndTime setTitle:[dic valueForKey:@"endTime"] forState:UIControlStateNormal];
        self.txtView.text = [dic valueForKey:@"taskContent"];
        
        self.title = @"修改日程";
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" target:self action:@selector(btnSubmit:)];
    
    calendarcontroller = [[SHCalendarViewController alloc]init];
    calendarcontroller.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)btnSubmit:(NSObject*)sender
{
    if(self.txtView.text.length == 0){
        [self showAlertDialog:@"内容不能为空."];
        return;
    }
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"miTaskMaintainance.do");
    NSString *taskid = [[self.intent.args valueForKey:@"info"] valueForKey:@"taskId"];
    taskid = (taskid.length == 0 ? @"":taskid);
    [post.postArgs setValue:taskid forKey:@"taskId"];
    [post.postArgs setValue:self.btnStartTime.titleLabel.text forKey:@"startTime"];

    [post.postArgs setValue:self.btnEndTime.titleLabel.text forKey:@"endTime"];

    [post.postArgs setValue:self.txtView.text forKey:@"taskContent"];

    [post.postArgs setValue:[NSNumber numberWithInt:(taskid.length == 0 ? 1:2)] forKey:@"operationType"];
    [post start:^(SHTask * t) {
        [t.respinfo show];
        [self.navigationController popViewControllerAnimated:YES];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
    }];

}

- (void)loadSkin
{
    [super loadSkin];
    self.txtView.layer.cornerRadius = 5;
    self.txtView.layer.masksToBounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnStartTimeOnTouch:(id)sender {
    mButton = sender;
    [calendarcontroller show];

}

- (IBAction)btnEndTimeOnTouch:(id)sender {
    mButton = sender;
    [calendarcontroller show];
}


-(void)calendarViewController:(SHCalendarViewController *)controller dateSelected:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    [mButton setTitle:destDateString forState:UIControlStateNormal];
    [controller close];
}


@end
