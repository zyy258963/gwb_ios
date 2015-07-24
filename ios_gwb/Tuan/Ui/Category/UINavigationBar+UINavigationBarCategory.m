//
//  UINavigationBar+UINavigationBarCategory.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "UINavigationBar+UINavigationBarCategory.h"

@implementation UINavigationBar (UINavigationBarCategory)

- (void) drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"CustomNavController.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
