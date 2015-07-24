//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchScrollView;

@protocol TouchScrollViewDelegate <NSObject>

- (void)touchEndedOnScrollView:(TouchScrollView *)touchScrollView;

@end


@interface TouchScrollView : UIScrollView
{
    id<TouchScrollViewDelegate> mydelegate;
}

@property (nonatomic, retain) id<TouchScrollViewDelegate> mydelegate;

@end
