//
//  LoginViewController.m
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "TuanAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "TableViewCellHelper.h"
#import "WToast.h"
#import "LoginQuery.h"

@implementation SecondViewController

@synthesize nameText;
@synthesize bgScrView;
@synthesize titleLab;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withWJId:(NSString* )itemId withWJName:(NSString* )itemName{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        myId = itemId;
        myTitle = itemName;
        [myId retain];
        [myTitle retain];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
	[self addBgBackgroundColor];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    if (!items) {
        items = [[NSMutableArray alloc] initWithCapacity:6];
    }
    
    self.titleLab.text = myTitle;
    
    query = [[FenLeiBtnListQuery alloc] init];
    query.cId = myId;
    query.mytarget = self;
    [query getFenLeiBtnList];
    [self setLoadingUI:YES];

}

- (IBAction)leftBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getFenLeiBtnListComplete:(NSNumber *)result
{
    [self setLoadingUI:NO];
    
    [items removeAllObjects];
    
    for (int w = 0; w < query.listItemArray.count; w ++) {
        [items addObject:[query.listItemArray objectAtIndex:w]];
    }
    
    [self loadFenLeiBtn];
    
    [self setLoadingUI:NO];
    
}

- (void)loadFenLeiBtn {

    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.frame = CGRectMake(3, 105, 314, 90);
    [bgBtn addTarget:self action:@selector(bgBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgBtn];
    
    for (int w = 0; w < items.count; w ++) {
        SubCategoryItem *item2 = (SubCategoryItem* )[items objectAtIndex:w];
        
        int yuCount = w % 2;
        int row = w / 2;
        
        if (yuCount == 0) {
            UIButton *gotoMain1 = [UIButton buttonWithType:UIButtonTypeCustom];
            gotoMain1.frame = CGRectMake(3, 3 + 50 * row, 155, 48);
            gotoMain1.titleLabel.font = [UIFont boldSystemFontOfSize: 25.0];
            [gotoMain1 setTitle:item2.className forState:UIControlStateNormal];
            [gotoMain1 setTitle:item2.className forState:UIControlStateSelected];
            [gotoMain1.layer setCornerRadius:10.0];
            [gotoMain1 setBackgroundImage:[UIImage imageNamed:@"btnSmall.png"] forState:UIControlStateNormal];
            [gotoMain1 setBackgroundImage:[UIImage imageNamed:@"btnSmallSel.png"] forState:UIControlStateHighlighted];
            gotoMain1.tag = w;
            [self.bgScrView addSubview:gotoMain1];
            [gotoMain1 addTarget:self action:@selector(gotoPush:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            UIButton *gotoMain1 = [UIButton buttonWithType:UIButtonTypeCustom];
            gotoMain1.frame = CGRectMake(162, 3 + 50 * row, 155, 48);
            gotoMain1.titleLabel.font = [UIFont boldSystemFontOfSize: 25.0];
            [gotoMain1.layer setCornerRadius:10.0];
            [gotoMain1 setTitle:item2.className forState:UIControlStateNormal];
            [gotoMain1 setTitle:item2.className forState:UIControlStateSelected];
            [gotoMain1 setBackgroundImage:[UIImage imageNamed:@"btnSmall.png"] forState:UIControlStateNormal];
            [gotoMain1 setBackgroundImage:[UIImage imageNamed:@"btnSmallSel.png"] forState:UIControlStateHighlighted];
            gotoMain1.tag = w;
            [self.bgScrView addSubview:gotoMain1];
            [gotoMain1 addTarget:self action:@selector(gotoPush:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    self.bgScrView.contentSize = CGSizeMake(320, 30 + 25 * items.count);

    
}

//进入第四页
- (IBAction)gotoPush:(id)sender {

    UIButton *btn = (UIButton* )sender;
    int tagBtn = btn.tag;
    
    SubCategoryItem *item2 = (SubCategoryItem* )[items objectAtIndex:tagBtn];
    NSArray *listItems = [myTitle componentsSeparatedByString:@"-"];
    
    NSString *temp = @"";
    if (listItems.count > 1) {
        temp = [NSString stringWithFormat:@"%@-%@",[listItems objectAtIndex:1],item2.className];
    }else{
        temp = item2.className;
    }
    
    //进入second
    ThirdViewController *contentView = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil withDocId:[NSString stringWithFormat:@"%d",[item2.classId intValue]] withDocName:temp withKeyWord:@""];
    [contentView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:contentView animated:YES];
    [contentView release];
    
    
}

- (void)getFenLeiBtnListQueryError:(id)obj
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

@end
