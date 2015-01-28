//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "UnderlineUILabel.h"
#import<QuartzCore/QuartzCore.h>

@implementation UnderlineUILabel

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
    }
    return self;
}

-(void)drawRect:(CGRect)rect 
{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGSize fontSize = [self.text sizeWithFont:self.font 
                                    forWidth:self.bounds.size.width
                               lineBreakMode:UILineBreakModeTailTruncation];
    
    // Get the fonts color. 
//    const float * colors = CGColorGetComponents([UIColor blackColor].CGColor);
    // Sets the color to draw the line
//    CGContextSetRGBStrokeColor(ctx, colors[0], colors[1], colors[2], 1.0f); // Format : RGBA
    
    CGContextSetRGBStrokeColor(ctx, 0.59, 0.59, 0.59, 1.0);
    
    // Line Width : make thinner or bigger if you want
    CGContextSetAllowsAntialiasing(ctx, NO);
    CGContextSetLineWidth(ctx, 1.0f);
    
    // Calculate the starting point (left) and target (right)
    CGPoint l = CGPointZero;
    CGPoint r = CGPointZero;
    
    int lines = self.numberOfLines;
    if (lines == 1) {
       
        if (self.textAlignment == UITextAlignmentLeft) {
            
            l = CGPointMake(0.0f, self.frame.size.height/2.0 +fontSize.height/2.0);
            r = CGPointMake(fontSize.width, self.frame.size.height/2.0 + fontSize.height/2.0);
        } else if (self.textAlignment == UITextAlignmentCenter)
        {
            
            l = CGPointMake(self.frame.size.width/2.0 - fontSize.width/2.0, 
                            self.frame.size.height/2.0 + fontSize.height/2.0);
            r = CGPointMake(self.frame.size.width/2.0 + fontSize.width/2.0, 
                            self.frame.size.height/2.0 + fontSize.height/2.0);
        } else
        {
            l = CGPointMake(self.frame.size.width - fontSize.width, 
                            self.frame.size.height/2.0 +fontSize.height/2.0);
            r = CGPointMake(self.frame.size.width, 
                            self.frame.size.height/2.0 + fontSize.height/2.0);
        }
        // Add Move Command to point the draw cursor to the starting point
        CGContextMoveToPoint(ctx, l.x, l.y);
        // Add Command to draw a Line
        CGContextAddLineToPoint(ctx, r.x, r.y);
        // Actually draw the line.
        CGContextStrokePath(ctx);
        
    } else
    {
        for (int i = 1; i <= lines; i++) {
           
            l = CGPointMake(0, fontSize.height * i);
            if (i == lines) {
                
                r = CGPointMake( [self.text sizeWithFont:self.font].width - (i - 1) * fontSize.width, fontSize.height * i);
                
            } else
            {
               r = CGPointMake(fontSize.width, fontSize.height * i);
            }
            
            // Add Move Command to point the draw cursor to the starting point
            CGContextMoveToPoint(ctx, l.x, l.y);
            // Add Command to draw a Line
            CGContextAddLineToPoint(ctx, r.x, r.y);
            
        }
        // Actually draw the line.
        CGContextStrokePath(ctx);
    }
}

@end
