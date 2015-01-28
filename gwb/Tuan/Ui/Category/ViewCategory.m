//
//  ViewCategory.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "ViewCategory.h"

@implementation UIView (ViewCategory)

- (void)keepAjacentVerticallyToView:(UIView *)anotherView
{
    static const CGFloat DefaultPadding = 5.0;
    [self keepAjacentVerticallyToView:anotherView withPadding:DefaultPadding];
}


- (void)keepAjacentVerticallyToView:(UIView *)anotherView withPadding:(CGFloat)padding
{
    CGRect frame = self.frame;
    frame.origin.y = anotherView.frame.origin.y + anotherView.frame.size.height + padding;
    self.frame = frame;
}


- (CGFloat)contentHeight
{
    CGFloat maxHeight = 0.0;
    for (UIView *subView in [self subviews])
    {
        CGFloat targetHeight = subView.frame.origin.y + subView.frame.size.height;
        if (targetHeight > maxHeight)
        {
            maxHeight = targetHeight;
        }
    }
    
    return maxHeight;
}

@end
