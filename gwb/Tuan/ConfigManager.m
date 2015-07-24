//
//  ConfigManager.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "ConfigManager.h"

@implementation ConfigManager
@synthesize muluArray;
@synthesize chooseMulu;
@synthesize cangId;
@synthesize chooseBook;
@synthesize chooseChapter;


static ConfigManager *_sharedManager = nil;

+ (ConfigManager *)sharedManager
{
    if (_sharedManager == nil)
    {
        _sharedManager = [[ConfigManager alloc] init];
		
    }
    
    return _sharedManager;
}


- (id)init
{
    self = [super init];
    if (self)
    {
    
    }
    return self;
}


- (void)dealloc
{

    [muluArray release];
    [chooseMulu release];
    [cangId release];
    [chooseBook release];
    [chooseChapter release];
    
    [super dealloc];
}

@end
