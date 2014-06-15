//
//  SHChatDetailViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-10.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatDetailViewController.h"
#import "SHChatUnitViewCell.h"

@interface SHChatDetailViewController ()

@end

@implementation SHChatDetailViewController

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
    mList = [@[@"123456789012345678901234567890123456789012345678901234567890",@"123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",@"123456789012345678901234567890123456789012345678901234567890",@"123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",@"123456789012345678901234567890123456789012345678901234567890"] mutableCopy];
    self.title = @"聊天";
    //[self registerForKeyboardNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
     											 selector:@selector(keyboardWillShown:)
     											 name:UIKeyboardWillShowNotification
     object:nil];
    // Do any additional setup after loading the view from its nib.
}
//- (void)registerForKeyboardNotifications
//{
//	[[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(keyboardDidShown:)
//												 name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(keyboardDidHidden:)
//												 name:UIKeyboardWillHideNotification object:nil];
//}

- (void)keyboardWillShown:(NSNotification*)ns
{
  
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect;
        [[[ns userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&rect];
        self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width,
                                          self.view.frame.size.height - rect.size.height +44-38);
        self.txtBox.frame = CGRectMake(3, self.view.frame.size.height - 30 - rect.size.height + 44 , 250, 30);
        self.btnSender.frame = CGRectMake(261, self.view.frame.size.height - 30 - rect.size.height + 44 , 48, 30);
        isAnimation = YES;
        
    } completion:^(BOOL finished) {
        isAnimation = NO;
    }];
}

- (void)unregisterForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardDidHideNotification
												  object:nil];
}

- (void)keyboardDidHidden:(NSNotification*)ns
{
    isAnimation = YES;

    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width,
                                          self.view.frame.size.height -38);
        self.txtBox.frame = CGRectMake(3, self.view.frame.size.height - 34  , 250, 30);
        self.btnSender.frame = CGRectMake(261, self.view.frame.size.height - 34  , 48, 30);
        
    } completion:^(BOOL finished) {
        isAnimation = NO;
    }];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [[mList objectAtIndex:indexPath.row] sizeWithFont:[NVSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(183, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
    return  60 - 18 + size.height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!isAnimation){
        [self.txtBox resignFirstResponder];
    }
}

- (void)dealloc
{
    [self unregisterForKeyboardNotifications];
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHChatUnitViewCell * cell = nil;
    if(indexPath.row == 3){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUnitMySelfViewCell" owner:nil options:nil] objectAtIndex:0];
        cell.labTxt.text = [mList objectAtIndex:indexPath.row];
    }else{
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUnitViewCell" owner:nil options:nil] objectAtIndex:0];
        cell.labTxt.text = [mList objectAtIndex:indexPath.row];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mList.count;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
