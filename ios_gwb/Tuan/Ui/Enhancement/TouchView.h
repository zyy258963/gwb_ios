//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchView;

@protocol TouchViewDelegate <NSObject>
- (void)touchEnded:(TouchView *)touchView;
@end


@interface TouchView : UIView
{
    id<TouchViewDelegate> delegate;
}


@property (nonatomic, retain) id<TouchViewDelegate> delegate;

@end
