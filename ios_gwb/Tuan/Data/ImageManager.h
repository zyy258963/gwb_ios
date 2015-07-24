//
//  ImageManager.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>


@class ImageView;
@interface ImageManager : NSObject
{
    NSMutableDictionary* requests;
}

- (void) loadImage:(NSString*)url :(ImageView*)imageView;

+ (ImageManager*) sharedManager;

@end
