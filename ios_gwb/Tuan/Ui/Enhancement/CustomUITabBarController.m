//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "CustomUITabBarController.h"

@interface UITabBarController (private)
- (UITabBar *)tabBar;
@end

@implementation CustomUITabBarController


- (void)viewDidLoad {
    [super viewDidLoad];

    if (!isNoFirst) {
        [self hideExistingTabBar];
        [self addCustomElements];
    }

}

- (void)hideExistingTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

-(void)addCustomElements
{
    isNoFirst = YES;
    
	UIImage *btnImage = [UIImage imageNamed:@"NavBar_01_s.png"];
	UIImage *btnImageSelected = [UIImage imageNamed:@"NavBar_01.png"];
	btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone5) {
        btn1.frame = CGRectMake(0, 520, 80, 49);
    }else{
        btn1.frame = CGRectMake(0, 431, 80, 49);
    }
	[btn1 setBackgroundImage:btnImage forState:UIControlStateNormal];
    [btn1 setBackgroundImage:btnImage forState:UIControlStateHighlighted];
	[btn1 setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
	[btn1 setTag:0];
    [btn1 setSelected:true]; 
    
	btnImage = [UIImage imageNamed:@"NavBar_02_s.png"];
	btnImageSelected = [UIImage imageNamed:@"NavBar_02.png"];
	btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone5) {
        btn2.frame = CGRectMake(80, 520, 80, 49);
    }else{
        btn2.frame = CGRectMake(80, 431, 80, 49);
    }
	[btn2 setBackgroundImage:btnImage forState:UIControlStateNormal];
    [btn2 setBackgroundImage:btnImage forState:UIControlStateHighlighted];
	[btn2 setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
	[btn2 setTag:1];
    
    btnImage = [UIImage imageNamed:@"NavBar_03_s.png"];
	btnImageSelected = [UIImage imageNamed:@"NavBar_03.png"];
	btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone5) {
        btn3.frame = CGRectMake(160, 520, 80, 49);
    }else{
        btn3.frame = CGRectMake(160, 431, 80, 49);
    }
	[btn3 setBackgroundImage:btnImage forState:UIControlStateNormal];
    [btn3 setBackgroundImage:btnImage forState:UIControlStateHighlighted];
	[btn3 setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
	[btn3 setTag:2];
    
    btnImage = [UIImage imageNamed:@"NavBar_04_s.png"];
	btnImageSelected = [UIImage imageNamed:@"NavBar_04.png"];
	btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone5) {
        btn4.frame = CGRectMake(240, 520, 80, 49);
    }else{
        btn4.frame = CGRectMake(240, 431, 80, 49);
    }
	[btn4 setBackgroundImage:btnImage forState:UIControlStateNormal];
    [btn4 setBackgroundImage:btnImage forState:UIControlStateHighlighted];
	[btn4 setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
	[btn4 setTag:3];
    
    // Add my new buttons to the view
	[self.view addSubview:btn1];
	[self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    
    // Setup event handlers so that the buttonClicked method will respond to the touch up inside event.
	[btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[btn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)selectTab:(int)tabID
{
    switch(tabID)
    {
        case 0:
            [btn1 setSelected:true];
            [btn2 setSelected:false];
            [btn3 setSelected:false];
            [btn4 setSelected:false];
            break;
        case 1:
            [btn1 setSelected:false];
            [btn2 setSelected:true];
            [btn3 setSelected:false];
            [btn4 setSelected:false];
            break;
        case 2:
            [btn1 setSelected:false];
            [btn2 setSelected:false];
            [btn3 setSelected:true];
            [btn4 setSelected:false];
            break;
        case 3:
            [btn1 setSelected:false];
            [btn2 setSelected:false];
            [btn3 setSelected:false];
            [btn4 setSelected:true];
            break;
    }
    
    self.selectedIndex = tabID;
    
}

- (void)buttonClicked:(id)sender
{
	int tagNum = [sender tag];
	[self selectTab:tagNum];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)dealloc {
    [super dealloc];
}

- (void)hiddenButtons
{
    btn1.hidden = YES;
    btn2.hidden = YES;
    btn3.hidden = YES;
    btn4.hidden = YES;
}

- (void)showButtons
{
    btn1.hidden = NO;
    btn2.hidden = NO;
    btn3.hidden = NO;
    btn4.hidden = NO;
}

@end