//
//  config.h
//  Zambon
//
//  Created by sheely on 13-9-23.
//  Copyright (c) 2013年 zywang. All rights reserved.
//


#import "Core.h"
#import "common.h"
#import "SHAppDelegate.h"


//测试站
#define URL_HEADER @"http://wandejun1012.gicp.net/myStruts1"
// 测试图片地址
 #define URL_BATA @ "http://192.168.1.200/api"

#define URL_DEVELOPER @ "http://zambon-test.mobilitychina.com:8091"
//测试站
#define URL_UPDATE @"http://zambon-update1.mobilitychina.com:8095/get_config"
//正是站
//#define URL_UPDATE @"http://zambon-update1.mobilitychina.com:8091/get_config"


#define URL_FOR(a) [NSString stringWithFormat:@"%@/%@",URL_HEADER,a]

#define DEVICE_TOKEN @"DeviceTokenStringKEY"

#define STORE_USER_INFO @"userinfo"

 

#define RECT_RIGHTSHOW CGRectMake(87, 23, 930, 730)
#define RECT_RIGHTNAVIGATION CGRectMake(0, 0, 930, 44)
#define RECT_RIGHTLIST CGRectMake(0, 44, 240, 678)
#define RECT_RIGHTCONTENT CGRectMake(240, 0, 687  , 730)
#define RECT_RIGHTCONTENT2 CGRectMake(667, 23, 350  , 730)
#define CELL_GENERAL_HEIGHT 110
#define CELL_GENERAL_HEIGHT2 80
#define CELL_GENERAL_HEIGHT3 44
#define CELL_SECTION_HEADER_GENERAL_HEIGHT 38
#define RECT_MAIN_LANDSCAPE_RIGHT CGRectMake(-20, 0, 768, 1004)
#define RECT_MAIN_LANDSCAPE_LEFT CGRectMake(20, 0, 768, 1004)

//notification
#define NOTIFICATION_LOGIN_SUCCESSFUL @"notification_login_successful"
#define NOTIFICATION_LOGINOUT @"notification_loginout"
#define NOTIFICATION_FAVORITE @"notification_favotite"

#define NOTIFICATION_EditRefrence @"notification_edit_refrence"

#define NOTIFY_SinaAuthon_Success     @"SinaAuthonSuccess"

#define CORE_NOTIFICATION_LOGIN_CHANGE @"core_notification_login_change"
//计划创建成功

/* lqh77 add  */
#define ORIGINAL_MAX_WIDTH 640.0f

#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define RETAIN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)


