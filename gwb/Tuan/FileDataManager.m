//
//  FileDataManager.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "FileDataManager.h"

@implementation FileDataManager
@synthesize fileArray;
@synthesize onlineArray;
@synthesize total;
@synthesize pageIndex;

static FileDataManager *_sharedManager = nil;

+ (FileDataManager *)sharedManager
{
    if (_sharedManager == nil)
    {
        _sharedManager = [[FileDataManager alloc] init];
		
    }
    
    return _sharedManager;
}


- (id)init
{
    self = [super init];
    if (self)
    {

        fileArray = [[NSMutableArray alloc] init];
        onlineArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)dealloc
{
    [fileArray release];
    [onlineArray release];
    [total release];
    [super dealloc];
}

- (void)clearAllDates
{
    if ([fileArray count] >0 ) 
    {
        [fileArray removeAllObjects];
    }
    if ([onlineArray count] >0 ) 
    {
        [onlineArray removeAllObjects];
    }
    
    total = @"0";
    pageIndex = 0;
}

@end
