//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	
	CustomCheckButtonTypeRight,
	CustomCheckButtonTypeLeft
}CustomCheckButtonType;

@interface CustomCheckButton : UIButton {

	UILabel     *_textOne;
	UILabel     *_textTwo;
	UIImageView *_tickRect;
	UIImageView *_tickSymbol;
	BOOL        _flag;
	
	CustomCheckButtonType _type;
    
    NSString *_uncheckImage;
    NSString *_checkImage;
}

@property (nonatomic, readonly)BOOL flag;
@property (nonatomic, assign)CustomCheckButtonType type;
@property (nonatomic, retain)NSString *uncheckImage;
@property (nonatomic, retain)NSString *checkImage;

- (void)setTextValue:(NSString*)textOne sum:(int)sum tick:(BOOL)tick;

- (void)setTextValue:(NSString*)textOne textFont:(UIFont*)textFont sum:(int)sum sumFont:(UIFont*)sumFont tick:(BOOL)tick;

- (void)setTickValue:(BOOL)tick;

- (CGRect)caculateLabelFrame:(UILabel*)label xOffset:(float)xOffset yOffset:(float)yOffset;

- (void)cacaulateViewFrame;

@end
