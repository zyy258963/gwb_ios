//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMoreCell : UITableViewCell {
	
	UILabel  *_showMoreText; //weak ref
	UILabel  *_description;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier bgcolor:(UIColor*)bgColor;

- (void)setcontents:(int)number sum:(int)sum;

- (void)showIndicator:(BOOL)show;

- (CGRect)showMoreTextRect:(float)height width:(float)width;

- (CGRect)descriptionTextRect:(float)xOffset yOffset:(float)yOffset;

@end
