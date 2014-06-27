//
//  SHWebViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-26.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHWebViewController : SHViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
