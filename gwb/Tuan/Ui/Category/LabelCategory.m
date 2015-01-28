//
//  LabelCategory.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "LabelCategory.h"

@implementation UILabel (LabelCategory)

- (void)adjustHeight
{
    CGSize maxSize = CGSizeMake(self.frame.size.width, 9999);
    CGSize expectedSize = [self.text sizeWithFont:self.font 
                                constrainedToSize:maxSize 
                                    lineBreakMode:self.lineBreakMode];
    CGRect frame = self.frame;
    frame.size.height = expectedSize.height;
    self.frame = frame;
}

@end
