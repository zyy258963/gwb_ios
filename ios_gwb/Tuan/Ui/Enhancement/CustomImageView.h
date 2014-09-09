//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomImageView : UIView
{
    UIImageView *image;

};

- (void)setImageWithUrl:(NSString *)url placeHolder:(NSString *)placeHolder;


- (CGSize)getImageSize;

- (void)rotationImage;


- (void)setImageWithUrl:(NSString *)url 
            placeHolder:(NSString *)placeHolder 
               paddingX:(float)paddingX
               paddingY:(float)paddingY;

- (void)setImageWithName:(NSString *)imgName;

- (void)setImageWithName:(NSString *)name 
				paddingX:(float)paddingX
				paddingY:(float)paddingY;


@end
