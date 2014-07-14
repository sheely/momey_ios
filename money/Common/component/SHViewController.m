//
//  SHViewController.m
//  Core
//
//  Created by zywang on 13-9-3.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHViewController.h"

#import "MMProgressHUD.h"



typedef NS_ENUM(NSInteger, RMoveDirection) {
    RMoveDirectionLeft = 0,
    RMoveDirectionRight
};


@interface SHViewController ()<UIAlertViewDelegate>
{
    BOOL mIsShowKeyboard;
    UIAlertView * alert;
    
    
    float  _LeftSContentOffset;
    float _RightSContentOffset;
    float _LeftSContentScale;
    float _RightSContentScale;
    float _LeftSJudgeOffset;
    float _RightSJudgeOffset;
    float _LeftSOpenDuration;
    float _RightSOpenDuration;
    float _LeftSCloseDuration;
    float _RightSCloseDuration;
    UITapGestureRecognizer* _tapGestureRec ;
    UIPanGestureRecognizer* _panGestureRec;
}
@end

@implementation SHViewController

@synthesize keybordView = _keybordView;

@synthesize keybordheight;

@synthesize delegate;

@synthesize intent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)checkIntent:(NSString*)error

{
    if(self.intent){
        return YES;
    }else{
        return NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"NaviBack"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
//   // [self.navigationItem.backBarButtonItem setBackButtonBackgroundImage:nil forState:(UIControlState)UIControlStateNormal barMetrics:(UIBarMetrics)UIBarMetricsDefault];
	//initWithImage:[UIImage imageNamed:@"NaviBack"] target:self action:@selector(btnBack:)// Do any additional setup after loading the view.
    if(self.navigationController.viewControllers.count > 1){
        UIBarButtonItem * barbutton = [[UIBarButtonItem alloc]initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = barbutton;
    }
    [self loadSkin];
    
    _LeftSContentOffset=240;
    _RightSContentOffset=160;
    _LeftSContentScale=0.85;
    _RightSContentScale=0.85;
    _LeftSJudgeOffset=100;
    _RightSJudgeOffset=100;
    _LeftSOpenDuration=0.4;
    _RightSOpenDuration=0.4;
    _LeftSCloseDuration=0.3;
    _RightSCloseDuration=0.3;
    if(self.contentView){
        [self.view addSubview:self.contentView];
        _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
        _tapGestureRec.delegate = self;
        [self.contentView addGestureRecognizer:_tapGestureRec];
        _tapGestureRec.enabled = NO;
        
        _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
        [self.view addGestureRecognizer:_panGestureRec];
        
    }
    //NVSkin * skin = [[NVSkin alloc]init];
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    static CGFloat currentTranslateX;
    if (panGes.state == UIGestureRecognizerStateBegan){
        currentTranslateX = self.contentView.transform.tx;
    }
    if (panGes.state == UIGestureRecognizerStateChanged){
        CGFloat transX = [panGes translationInView:self.contentView].x;
        transX = transX + currentTranslateX;
        CGFloat sca;
        if (transX > 0){
            [self.view sendSubviewToBack:self.rightView];
            [self configureViewShadowWithDirection:RMoveDirectionRight];
            
            if (self.contentView.frame.origin.x < _LeftSContentOffset){
                sca = 1 - (self.contentView.frame.origin.x/_LeftSContentOffset) * (1-_LeftSContentScale);
            }
            else{
                sca = _LeftSContentScale;
            }
        }else {   //transX < 0
            [self.view sendSubviewToBack:self.leftView];
            [self configureViewShadowWithDirection:RMoveDirectionLeft];
            
            if (self.contentView.frame.origin.x > -_RightSContentOffset){
                sca = 1 - (-self.contentView.frame.origin.x/_RightSContentOffset) * (1-_RightSContentScale);
            }
            else{
                sca = _RightSContentScale;
            }
        }
        CGAffineTransform transS = CGAffineTransformMakeScale(1.0, sca);
        CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
        
        CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
        
        self.contentView.transform = conT;
    }else if (panGes.state == UIGestureRecognizerStateEnded){
        CGFloat panX = [panGes translationInView:self.contentView].x;
        CGFloat finalX = currentTranslateX + panX;
        if (finalX > _LeftSJudgeOffset){
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
            [UIView beginAnimations:nil context:nil];
            self.contentView.transform = conT;
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = YES;
            return;
        }
        if (finalX < -_RightSJudgeOffset){
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
            [UIView beginAnimations:nil context:nil];
            self.contentView.transform = conT;
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = YES;
            return;
        }else{
            CGAffineTransform oriT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            self.contentView.transform = oriT;
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = NO;
        }
    }
}

- (void)rightItemClick
{
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
    
    [self.view insertSubview:self.rightView belowSubview:self.contentView];
    [self configureViewShadowWithDirection:RMoveDirectionLeft];
    
    [UIView animateWithDuration:_RightSOpenDuration
                     animations:^{
                         self.contentView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                     }];
}
- (void)leftItemClick{
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
    
    
    [self configureViewShadowWithDirection:RMoveDirectionRight];
    [self.view insertSubview:self.leftView belowSubview:self.contentView];
    [UIView animateWithDuration:_LeftSOpenDuration
                     animations:^{
                         self.contentView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                            _tapGestureRec.enabled = YES;
                     }];
}

- (CGAffineTransform)transformWithDirection:(RMoveDirection)direction
{
    CGFloat translateX = 0;
    CGFloat transcale = 0;
    switch (direction) {
        case RMoveDirectionLeft:
            translateX = -_RightSContentOffset;
            transcale = _RightSContentScale;
            break;
        case RMoveDirectionRight:
            translateX = _LeftSContentOffset;
            transcale = _LeftSContentScale;
            break;
        default:
            break;
    }
    
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0, transcale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}

- (void)configureViewShadowWithDirection:(RMoveDirection)direction
{
    CGFloat shadowW;
    switch (direction)
    {
        case RMoveDirectionLeft:
            shadowW = 2.0f;
            break;
        case RMoveDirectionRight:
            shadowW = -2.0f;
            break;
        default:
            break;
    }
    
    self.contentView.layer.shadowOffset = CGSizeMake(shadowW, 1.0);
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowOpacity = 0.8f;
}

- (void)closeSideBar
{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    [UIView animateWithDuration:self.view.transform.tx==_LeftSContentOffset?_LeftSCloseDuration:_RightSCloseDuration
                     animations:^{
                         self.contentView.transform = oriT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = NO;
                     }];
}


- (void)btnBack:(NSObject*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setKeybordView:(UIView* )view
{
    _keybordView = view;
    mRectkeybordview = _keybordView.frame;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSkin
{
    self.view.backgroundColor = [NVSkin.instance colorOfStyle:@"ColorBaseBackGround"];
}

- (void)showAlertDialog:(NSString*)content
{
    alert = [[UIAlertView alloc]initWithTitle:@"提示" message:content delegate: self cancelButtonTitle:(NSString *) @"确认"  otherButtonTitles: nil];
    alert.delegate = self;
    [alert show];
}

- (void)dealloc
{
    alert.delegate = nil;
}

- (void)showAlertDialogForCancel:(NSString*)content
{
     [self showAlertDialog:content button:@"确定" otherButton:@"取消"];
}

- (void)showAlertDialog:(NSString*)content otherButton:(NSString*)button
{
    [self showAlertDialog:content button:@"确定" otherButton:button];
}

- (void)showAlertDialog:(NSString*)content button:(NSString*)button otherButton:(NSString*)otherbutton
{
    [self showAlertDialog:content button:button otherButton:otherbutton tag:0];
}


- (void)showAlertDialog:(NSString*)content button:(NSString*)button otherButton:(NSString*)otherbutton tag:(int)tag
{
    UIAlertView * alert2 = [[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:self cancelButtonTitle: otherbutton otherButtonTitles :button, nil];
    alert2.delegate = self;
    alert2.tag = tag;
    [alert2 show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [self alertViewCancelOnClick];
    }else if (buttonIndex == 1){
        [self alertViewEnSureOnClick];
    }
}

- (void)alertViewCancelOnClick
{
}

- (void)alertViewEnSureOnClick
{
    
}

-(void)showWaitDialog:(NSString*)title state:(NSString*)state
{
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleNone];
    [MMProgressHUD showWithTitle:title status:state];
}
-(void)showWaitDialogForNetWork
{
//    dispatch_async(dispatch_get_main_queue(), ^{
        [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleNone];
        [MMProgressHUD showWithTitle:@"请求数据..." status:@"请稍候..."];

//    });
   
    //[self performSelector:@selector(showWaitDialogForWait) withObject:nil afterDelay:0.001];
}
//- (void)showWaitDialogForWait
//{
//    
//    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
//    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleNone];
//    [MMProgressHUD showWithTitle:@"请求数据..." status:@"请稍候..."];
//
//}
-(void)showWaitDialogForNetWorkDismissBySelf
{
    [self showWaitDialogForNetWork];
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissWaitDialog];
    });

}

-(void)dismissWaitDialog:(NSString*)msg
{
    [MMProgressHUD dismissWithSuccess:msg];

}

-(void)dismissWaitDialog
{

    [MMProgressHUD dismiss];

}
-(void)dismissWaitDialogSuccess
{
    [MMProgressHUD dismissWithSuccess:@"完成"];
    
}

-(void)dismissWaitDialogSuccess:(NSString*) title
{
    [MMProgressHUD dismissWithSuccess:title];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
    
}

//- (void) __subview :(UIView*) view
//{
//    if( view.subviews.count > 0){
//        for (UIView * v  in view.subviews) {
//            [self __subview:v];
//        }
//    }else if ([view isKindOfClass:[UITextView class]] && [view respondsToSelector:@selector(resignFirstResponder)]){
//        //NSLog(@"%@",[[view class] description]);
//        [view resignFirstResponder];
//    }
//}

- (void)resignKeyBoardInView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        if ([v.subviews count] > 0) {
            [self resignKeyBoardInView:v];
        }
        
        if ([v isKindOfClass:[UITextView class]] || [v isKindOfClass:[UITextField class]]) {
            [v resignFirstResponder];
        }
    }
}


-(void)viewDidDisappear:(BOOL)animated
{
    [self unregisterForKeyboardNotifications];
    [self resignKeyBoardInView:self.view];
}

- (void)registerForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardDidShown:)
												 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardDidHidden:)
												 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShown:(NSNotification*)ns
{
    if(!_keybordView){
        return;
    }
    if(!mIsShowKeyboard){
        mRectkeybordview = _keybordView.frame;
    }
    mIsShowKeyboard = YES;
    [UIView beginAnimations:nil context:nil];
    //设定动画持续时间
    [UIView setAnimationDuration:0.3];
    //动画的内容
    
    //动画结束
   
    CGRect rect;
    [[[ns userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] getValue:&rect];
    _keybordView.frame = CGRectMake(mRectkeybordview.origin.x,
                                    mRectkeybordview.origin.y - (self.keybordheight != 0? self.keybordheight: rect.size.height),
                                    mRectkeybordview.size.width,
                                    mRectkeybordview.size.height);
     [UIView commitAnimations];
}

- (void)unregisterForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardDidShowNotification
												  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardDidHideNotification
												  object:nil];
}

- (void)keyboardDidHidden:(NSNotification*)ns
{
    if(!_keybordView){
        return;
    }
    mIsShowKeyboard = NO;
    [UIView beginAnimations:nil context:nil];
    //设定动画持续时间
    [UIView setAnimationDuration:0.3];
    _keybordView.frame = mRectkeybordview;
    [UIView commitAnimations];
}

- (void)dismiss
{
    [self.view setHidden:YES];
    [self.view removeFromSuperview];
}




@end
