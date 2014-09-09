//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageView : UIView
{
    UIImage* _image;
    NSString* _url;
	BOOL bAdjustFit;
}

@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, assign) BOOL bAdjustFit;


-(void) loadFromURL:(NSString*)url;

@end
