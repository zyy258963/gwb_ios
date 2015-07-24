//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "BaseViewController.h"
#import "ConfigManager.h"
#import "UserManager.h"
#import "CustomUITabBarController.h"


@implementation BaseViewController

@synthesize categoryTypeActionSheet = _categoryTypeActionSheet;
@synthesize categoryTypePickerView = _categoryTypePickerView;

@synthesize subcategoryActionSheet = _subcategoryActionSheet;
@synthesize subcategoryPickerView = _subcategoryPickerView;

@synthesize regionPickerView = _regionPickerView;
@synthesize regionActionSheet = _regionActionSheet;
@synthesize feedBackBtn = _feedBackBtn;

@synthesize pullHeaderView = _pullHeaderView;
@synthesize showMoreIndicator = _showMoreIndicator;

@synthesize myLocalLabel = _myLocalLabel;

@synthesize categoryList = _categoryList;

@synthesize curCity = _curCity;
@synthesize smsViewController2;

@synthesize showFavCompleteAlert = _showFavCompleteAlert;
@synthesize isShowDia;

@synthesize sortActionSheet;
@synthesize sortPickerView;

@synthesize sortType;
@synthesize weiboType;
@synthesize photos = _photos;

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //蓝色
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(21.0 / 255)
//                                                                        green:(95.0 / 255)
//                                                                         blue:(176.0 / 255)
//                                                                        alpha:1.0];
    
//    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if (version >= 5.0) 
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"CustomNavController.png"] forBarMetrics:UIBarMetricsDefault];
//    }

}

- (void)addBgBackgroundColor
{
    self.view.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
}

- (void)showProgress:(BOOL)animated {
	
	if(!progressView) {
		
		progressView = [[MBProgressHUD alloc] initWithView:self.view];
		progressView.labelText = @"加载中...";
		
		[self.view addSubview:progressView];
		
		[progressView release];
        
	}
	
	[self.view bringSubviewToFront:progressView];
	[progressView show:animated];
}

- (void)hideProgress:(BOOL)animated {
	
	if (progressView) {
		
		[progressView hide:animated];
	}
}

- (void)showProgressWithText:(BOOL)animated showText:(NSString *)text
{
	
	if(!progressView) {
		
		progressView = [[MBProgressHUD alloc] initWithView:self.view];
		progressView.labelText = text;
		
		[self.view addSubview:progressView];
		
		[progressView release];
        
	}
	
	[self.view bringSubviewToFront:progressView];
	[progressView show:animated];
}

- (void)addCustomBarItem:(int)postion normalImg:(NSString *)normalImg highlighted:(NSString *)Highlighted sel:(SEL)sel btnWithText:(NSString *)myText {
    
    UIImage *nomalImage = [UIImage imageNamed:normalImg];
	CGRect btnFrame= CGRectMake(0, 0, nomalImage.size.width/2, nomalImage.size.height/2);
	UIButton *btn = [[UIButton alloc] initWithFrame:btnFrame];
	[btn setBackgroundImage:nomalImage forState:UIControlStateNormal];
	[btn setBackgroundImage:[UIImage imageNamed:Highlighted] forState:UIControlStateHighlighted];
    [btn setTitle:myText forState:UIControlStateNormal];
    [btn setTitle:myText forState:UIControlStateHighlighted];
    [btn setTitle:myText forState:UIControlStateSelected];
    btn.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize: 14.0];
	[btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
	
	//定制自己的风格的  UIBarButtonItem
	UIBarButtonItem *someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btn];
	if (postion == 0) {
		[self.navigationItem setLeftBarButtonItem:someBarButtonItem];
	} else {
		[self.navigationItem setRightBarButtonItem:someBarButtonItem];
	}
    
	[someBarButtonItem release];
	[btn release];
}

- (void)addCustomBarItem:(int)postion normalImg:(NSString *)normalImg highlighted:(NSString *)Highlighted sel:(SEL)sel {

    UIImage *nomalImage = [UIImage imageNamed:normalImg];
	CGRect btnFrame= CGRectMake(0, 0, nomalImage.size.width, nomalImage.size.height); 
	UIButton *btn = [[UIButton alloc] initWithFrame:btnFrame]; 
	[btn setBackgroundImage:nomalImage forState:UIControlStateNormal]; 
	[btn setBackgroundImage:[UIImage imageNamed:Highlighted] forState:UIControlStateHighlighted];
	[btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside]; 
	
	//定制自己的风格的  UIBarButtonItem
	UIBarButtonItem *someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btn]; 
	if (postion == 0) {
		
		[self.navigationItem setLeftBarButtonItem:someBarButtonItem];
	} else {
		[self.navigationItem setRightBarButtonItem:someBarButtonItem];
	}

	[someBarButtonItem release]; 
	[btn release];
}

- (void)showErrorNote:(NSString *)title msg:(NSString *)msg;
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)handleSmsMessageEvent
{

}

- (void)showSmsController:(NSString *)content
{

	Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    if (messageClass != nil) 
    {
        if ([MFMessageComposeViewController canSendText])
        {
            
            self.smsViewController2 = [[[MFMessageComposeViewController alloc] init] autorelease];
            smsViewController2.body = content;
            smsViewController2.messageComposeDelegate = self;
            [self presentModalViewController:smsViewController2 animated:YES];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法发送" message:@"您的设备不支持短信功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法发送"
                                                        message:@"iOS版本过低,iOS4.0以上才支持程序内发送短信"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
    }
	
	
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultFailed)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送失败" message:@"短信发送失败，请重新尝试。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        if (result == MessageComposeResultSent)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送成功" message:@"短信已发送。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        
        [smsViewController2 dismissModalViewControllerAnimated:YES];
        self.smsViewController2 = nil;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex { 
	
	if (buttonIndex != actionSheet.cancelButtonIndex) {
        
		if (buttonIndex == 0 || buttonIndex == 1) {

			[self handleWeiboEvent:buttonIndex];
			
		}else if (buttonIndex == 2) {
			[self handleSmsMessageEvent];
		}

	}
}

- (void)addFeedBackBtn
{
	_feedBackBtn = [[UIBarButtonItem alloc] initWithTitle:@"反馈" 
													style:UIBarButtonItemStylePlain
												   target:self
												   action:@selector(didDoneFeedBack:)];
	[self.navigationItem setRightBarButtonItem:_feedBackBtn];
	[_feedBackBtn release];
	
}

- (void)addEGORefreshTableHeaderView:(UITableView *)listView
{
    
    if (!_pullHeaderView) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, -listView.frame.size.height, listView.frame.size.width, listView.frame.size.height)];
        view.delegate = self;
        [listView addSubview:view];
        _pullHeaderView = view;
        _listView = listView;
        [view release];
    }
    
    //  update the last update date
    [_pullHeaderView refreshLastUpdatedDate];
}

- (void)egoRefreshTableHeaderViewRestore:(id)object
{
    if (self.pullHeaderView && _listView && _refreshingData ) {
        
        _refreshingData = NO;
		[self.pullHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_listView];
    }
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    
    _refreshingData = YES;
    if ([self respondsToSelector:@selector(refreshListViewData)]) {
        [self performSelector:@selector(refreshListViewData)];
    }
}

- (void)egoRefreshTableEndDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    
    _refreshingData = YES;
    if ([self respondsToSelector:@selector(getMoreRefreshListViewData)]) {
        [self performSelector:@selector(getMoreRefreshListViewData)];
    }

}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _refreshingData; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}


- (ShowMoreCell *)createShowMoreCell:(UITableView *)listView {
    
	ShowMoreCell *moreCell = (ShowMoreCell *)[listView dequeueReusableCellWithIdentifier:@"TableViewShowMoreCell"];
	
	if (moreCell == nil) {
		
		moreCell = [[[ShowMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewShowMoreCell"] autorelease];
		moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	[moreCell showIndicator:self.showMoreIndicator];
	
	return moreCell;
}

- (void)updateShowMoreCell:(BOOL)indicator path:(NSIndexPath *)path
{
    self.showMoreIndicator = indicator;
    if (_listView) {
        [_listView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];

}

- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
}

- (void)showShadowBar:(NSString *)text withViewRect:(CGRect)viewRect withTextRect:(CGRect)textRect
{
    if (!_shadowBg && !_myLocalLabel) {
        
        CGRect temp = viewRect;
        temp.origin.y += viewRect.size.height;
        temp.size.height = 0;
        _shadowBg = [[UIView alloc] initWithFrame:temp];
        
        _shadowBg.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
        
        _myLocalLabel = [[UILabel alloc] initWithFrame:textRect];
        
        _myLocalLabel.backgroundColor = [UIColor clearColor];
        
        _myLocalLabel.textColor = [UIColor whiteColor];
        
        _myLocalLabel.font = [UIFont systemFontOfSize:13];
        _myLocalLabel.text = text;
        _myLocalLabel.textAlignment = UITextAlignmentCenter;
        _myLocalLabel.frame = CGRectMake(0, 0, viewRect.size.width, viewRect.size.height);
        [_shadowBg addSubview:_myLocalLabel];
        
        [self.view addSubview:_shadowBg];
        
        [_myLocalLabel release];
        [_shadowBg release];  
    }
    
    [self.view bringSubviewToFront:_shadowBg];
    [UIView beginAnimations:@"animateShadowBar" context:nil];
    [UIView setAnimationDuration:0.3];
    [_shadowBg setFrame:viewRect]; //notice this is ON screen!
    [UIView commitAnimations];
}

- (void)hideShadowBar
{
    CGRect temp = _shadowBg.frame;
    temp.size.height = 0;
    temp.origin.y += _shadowBg.frame.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    _shadowBg.frame = temp;
    
    [UIView commitAnimations];
}

- (void)setShadowBarTextChange:(NSString *)localText
{
	self.myLocalLabel.text = localText;
}

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    
    progressView = nil;
    
    _pullHeaderView = nil;
    _feedBackBtn = nil;
    
    _listView = nil;
    
    shadowBarView = nil;
    
    _shadowBg = nil;
    _myLocalLabel = nil;
    
}

- (void)dealloc {
    
    [_regionActionSheet release];
    [_subcategoryActionSheet release];
    [_categoryTypeActionSheet release];
    [sortActionSheet release];
    
    [_categoryList release];
    [_curCity release];
    
    [super dealloc];
}

- (void)cancelAnimate
{
    
    UIWindow *otherWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UIView *view = (UIView *)[otherWindow viewWithTag:2000];
    [view removeFromSuperview];
}

- (void)showFavCompleteIndicator
{
    if (self.showFavCompleteAlert) {
        
        [self showErrorNote:@"收藏" msg:@"已将该项加入收藏列表。"];
    } else
    {
        [self craeteWindowAnimate];
    }

}

- (void)hiddenTabBar:(BOOL)hidd
{
    CustomUITabBarController *customTabBar = (CustomUITabBarController*)self.tabBarController;
    if (hidd) 
    {
        [customTabBar hiddenButtons];
    }
    else
    {
        [customTabBar showButtons];
    }
}

- (void)showSortActionSheet
{
 //   if (!sortActionSheet)
    {
        [self addSortActionSheet];
    }
    
    [sortActionSheet showFromTabBar:self.tabBarController.tabBar];
    [sortActionSheet setBounds:CGRectMake(0, 0, 320, 464)];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;
    
}

- (BOOL)prefersStatusBarHidden

{
    
    return NO;
    
}

@end
