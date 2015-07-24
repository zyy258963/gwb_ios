//
//  ViewCategory.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewCategory)

- (void)keepAjacentVerticallyToView:(UIView *)anotherView;
- (void)keepAjacentVerticallyToView:(UIView *)anotherView withPadding:(CGFloat)padding;
- (CGFloat)contentHeight;

@end
