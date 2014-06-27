//
//  SHWebViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-26.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHWebViewController.h"

@interface SHWebViewController ()

@end

@implementation SHWebViewController

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
    if([[self.intent.args valueForKey:@"url"] length] > 0 ){
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.intent.args valueForKey:@"url"]]]];
        self.title = [self.intent.args valueForKey:@"title"];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showWaitDialogForNetWork];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self dismissWaitDialog];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self dismissWaitDialog];

}
@end
