//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSTextView : UITextView {
	
    NSString *_placeholder;
    UIColor *_placeholderColor;
	
    BOOL _shouldDrawPlaceholder;
}

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@end
