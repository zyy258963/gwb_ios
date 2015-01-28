//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
    }
    return self;
}


- (void)dealloc
{
    [delegate release];
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate touchEnded:self];
}


@end
