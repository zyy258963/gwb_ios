//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "AddressItem.h"

@implementation AddressItem

@synthesize name;
@synthesize phoneNumber;
@synthesize isShow;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        isShow = NO;
    }
    
    return self;
}



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.phoneNumber = [aDecoder decodeObjectForKey:@"phoneNumber"];
    self.isShow = [aDecoder decodeBoolForKey:@"isShow"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:phoneNumber forKey:@"phoneNumber"];
    [aCoder encodeBool:isShow forKey:@"isShow"];
}

- (void)dealloc
{
	[name release];
    [phoneNumber release];
    [super dealloc];
}

- (NSComparisonResult)compare:(AddressItem *)otherObject
{
    return [self.name compare:otherObject.name];
}

- (NSComparisonResult)localizedCompare:(AddressItem *)otherObject
{
    return [self.name localizedCompare:otherObject.name];
}

- (NSComparisonResult)localizedCaseInsensitiveCompare:(AddressItem *)otherObject
{
    return [self.name localizedCaseInsensitiveCompare:otherObject.name];
}

- (NSComparisonResult) compareTheAddressBookWay:(AddressItem *)otherObject
{
    return [self.name compare:otherObject.name 
                      options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch
                        range:NSRangeFromString(self.name)];
}



@end
