//
//  LoginViewController.m
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "TuanAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "TableViewCellHelper.h"
#import "WToast.h"
#import "LoginQuery.h"

@implementation FirstViewController

@synthesize nameText;
@synthesize myTableView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setLoadingUI:YES];
    
	[self addBgBackgroundColor];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    if (!items) {
        items = [[NSMutableArray alloc] initWithCapacity:6];
    }
    
    if ([UserManager sharedManager].userInfo) {
        NSLog(@"%@",@"shareManager ---  中用户信息 不为空");
        [self loginNotify:nil];
    }else{
        NSLog(@"%@",@"shareManager ---  中用户信息 ＝＝＝＝＝＝空");
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginNotify:)
                                                     name:@"loginonotify"
                                                   object:nil];
    }

}

- (void)loginNotify:(NSNotification *)notification {
    if ([UserManager sharedManager].userInfo ) {
        
        NSLog(@"=============22222----");
        
        query = [[WenJianBtnListQuery alloc] init];
        query.mytarget = self;
        [query getWenJianBtnList];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];

    }
}

-(void)getWenJianBtnListComplete:(NSNumber *)result
{
    [self setLoadingUI:NO];
    
    [items removeAllObjects];
    
    for (int w = 0; w < query.listItemArray.count; w ++) {
        [items addObject:[query.listItemArray objectAtIndex:w]];
    }
    
    if (iPhone5) {
        self.myTableView.frame = CGRectMake(0, 195, 320, 370);
    }else{
        self.myTableView.frame = CGRectMake(0, 195, 320, 282);
    }
    
    [self.myTableView reloadData];
    
    [self setLoadingUI:NO];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [items count];
    
    return count;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    
    CategoryItem *temp = (CategoryItem *)[items objectAtIndex:row];
    return [TableViewCellHelper createFirstListCell:self view:tableView appWithTitle:temp.categoryName appWithLine:row];
    
}

//进入第三页
- (IBAction)gotoPush:(id)sender {

    UIButton *btn = (UIButton* )sender;
    int tagBtn = btn.tag - 110;
    
    if (items.count - tagBtn <= 1) {
        //进入我的文件夹
        ThirdViewController *contentView = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil withDocId:@"" withDocName:@"" withKeyWord:@""];
        [contentView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:contentView animated:YES];
        [contentView release];
    }else {
        CategoryItem *item2 = (CategoryItem* )[items objectAtIndex:tagBtn];
        //进入second
        NSString *temp = [NSString stringWithFormat:@"%@-%@",@"我的公文包",item2.categoryName];
        
        SecondViewController *contentView = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil withWJId:[NSString stringWithFormat:@"%d",[item2.categoryId intValue]] withWJName:temp];
        [contentView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:contentView animated:YES];
        [contentView release];
    }
}

- (void)getWenJianBtnListQueryError:(id)obj
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:(NSString *)obj delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	[self setLoadingUI:NO];
}

- (IBAction)searchBtn:(id)sender
{
    
    if (self.nameText.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"关键字不能为空！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else {
        ThirdViewController *contentView = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil withDocId:@"" withDocName:@"" withKeyWord:self.nameText.text];
        [contentView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:contentView animated:YES];
        [contentView release];
    }
    
    [self bgBtn:nil];
    
}

- (IBAction)bgBtn:(id)sender {

    if ([self.nameText canResignFirstResponder]) {
		
		[self.nameText resignFirstResponder];
		
	}
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.nameText == textField) {
        
        self.nameText.returnKeyType = UIReturnKeySearch;
        
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.nameText) {
        
        [self searchBtn:nil];
        
        return YES;
        
    }else {
        
        return NO;
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
        
}

- (void)setLoadingUI:(BOOL)isLoading
{
    if (isLoading)
    {
		[self showProgress:YES];
    }
    else
    {
		[self hideProgress:YES];
    }
}

- (void)dealloc {
    [super dealloc];
}

@end
