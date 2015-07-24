//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomUITabBarController : UITabBarController

{
	UIButton *btn1;
	UIButton *btn2;
	UIButton *btn3;
	UIButton *btn4;
    UIButton *btn5;
    
    BOOL isNoFirst;
}

- (void)hideExistingTabBar;
-(void) addCustomElements;
-(void) selectTab:(int)tabID;
-(void)hiddenButtons;
-(void)showButtons;
@end
