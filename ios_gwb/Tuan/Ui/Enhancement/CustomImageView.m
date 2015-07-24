//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "CustomImageView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "UIImageView+WebCache.h"
#import "StringUtil.h"

@implementation CustomImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

    }
    return self;
}

- (void)setImageWithUrl:(NSString *)url placeHolder:(NSString *)placeHolder
{

    [self setImageWithUrl:url placeHolder:placeHolder paddingX:3.0f paddingY:2.0f];
}

- (void)setImageWithUrl:(NSString *)url 
            placeHolder:(NSString *)placeHolder 
               paddingX:(float)paddingX
               paddingY:(float)paddingY
{
    
    if(!image)
    {
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithRed:197 /255.0f green:197 / 255.0f blue:197 / 255.0f alpha:1.0f].CGColor;
        
        image  = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, paddingX, paddingY)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:image];
        [image release];
        
    }
    
    [image setImageWithURL:[NSURL URLWithString:[StringUtil emptyForNil:url]] placeholderImage:[UIImage imageNamed:placeHolder]];

}

- (void)setImageWithName:(NSString *)name
{
	
    [self setImageWithName:name paddingX:5.0f paddingY:5.0f];
}

- (void)setImageWithName:(NSString *)name 
               paddingX:(float)paddingX
               paddingY:(float)paddingY
{
    
    if(!image)
    {
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithRed:197 /255.0f green:197 / 255.0f blue:197 / 255.0f alpha:1.0f].CGColor;
        
        image  = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, paddingX, paddingY)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:image];
        [image release];
        
    }
    
    image.image = [UIImage imageNamed:name];
	
}

- (CGSize)getImageSize
{
	return image.image.size;
}

- (void)rotationImage
{
	//image.image = [image.image rotate:UIImageOrientationLeft];
	image.transform = CGAffineTransformMakeRotation(M_PI/2);
}

@end
