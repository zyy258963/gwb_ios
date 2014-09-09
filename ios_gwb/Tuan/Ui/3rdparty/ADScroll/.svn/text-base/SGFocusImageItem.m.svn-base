//
//  SGFocusImageItem.m
//  SGFocusImageFrame
//
//  Created by Shane Gao on 17/6/12.
//  Copyright (c) 2012 Shane Gao. All rights reserved.
//

#import "SGFocusImageItem.h"

@implementation SGFocusImageItem
@synthesize title =  _title;
@synthesize image =  _image;
@synthesize tag =  _tag;
@synthesize url = _url;
@synthesize button = _button;

- (void)dealloc
{
    [_title release];
    [_image release];
    [_url release];
    [_button release];
    [super dealloc];
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag url:(NSString*)url button:(UIButton*)button
{
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        self.tag = tag;
        self.url = url;
        self.button = button;
    }
    
    return self;
}

@end
