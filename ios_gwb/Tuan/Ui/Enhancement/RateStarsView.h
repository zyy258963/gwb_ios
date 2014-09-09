//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RateStarsView : UIView {

	int	_rateCount;
	
	UIViewController *_target;
	
	SEL _didRateStar;
}

@property int rateCount;

@property(nonatomic, assign) UIViewController *target;

@property(nonatomic, assign) SEL didRateStar;

- (void)setFromNib:(int)count;


@end
