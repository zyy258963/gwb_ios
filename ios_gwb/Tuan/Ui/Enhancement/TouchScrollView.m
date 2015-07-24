//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "TouchScrollView.h"

@implementation TouchScrollView

@synthesize mydelegate;

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}


- (void)dealloc
{
    [mydelegate release];
    
    [super dealloc];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mydelegate touchEndedOnScrollView:self];
}

@end
