//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "ImageView.h"
#import "ImageManager.h"

@implementation ImageView
@synthesize image = _image;
@synthesize url = _url;
@synthesize bAdjustFit;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
		bAdjustFit = NO;
    }
    return self;
}


-(void) setImage:(UIImage *)theImage
{
    CGSize size = theImage.size;
    if (_image != theImage && size.width > 10.0f && size.height > 10.0f)
    {
        [_image release];
        _image = [theImage retain];
    }

    [self setNeedsDisplay];
}


-(void) loadFromURL:(NSString*)theUrl
{
    self.image = [UIImage imageNamed:@"CouponDetailZwf.png"];
    self.url = theUrl;
    [[ImageManager sharedManager] loadImage:_url :self];
}

- (void)drawRect:(CGRect)rect
{
	rect.size = _image.size;
    [_image drawInRect:rect];
}

- (void)dealloc
{
    [_image release];
    [_url release];
    
    [super dealloc];
}


@end
