//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "InviteItem.h"

@implementation InviteItem

@synthesize registered;
@synthesize userId;
@synthesize mobile;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.registered = [aDecoder decodeObjectForKey:@"registered"];
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
   
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:registered forKey:@"registered"];
    [aCoder encodeObject:userId forKey:@"userId"];
    [aCoder encodeObject:mobile forKey:@"mobile"];
}

- (void)dealloc
{
	[registered release];
    [userId release];
    [mobile release];
    [super dealloc];
}

@end
