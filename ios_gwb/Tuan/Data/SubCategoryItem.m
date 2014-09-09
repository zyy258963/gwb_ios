//
//  AddvItem.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SubCategoryItem.h"
#import "XMLParser.h"

@implementation SubCategoryItem

@synthesize categoryId;
@synthesize classDesc;
@synthesize classId;
@synthesize className;
@synthesize createTs;
@synthesize isAvailable;

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
    if (self)
    {
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.classDesc = [aDecoder decodeObjectForKey:@"classDesc"];
        self.classId = [aDecoder decodeObjectForKey:@"classId"];
        self.className = [aDecoder decodeObjectForKey:@"className"];
        self.createTs = [aDecoder decodeObjectForKey:@"createTs"];
        self.isAvailable = [aDecoder decodeObjectForKey:@"isAvailable"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.classDesc forKey:@"classDesc"];
    [aCoder encodeObject:self.classId forKey:@"classId"];
    [aCoder encodeObject:self.className forKey:@"className"];
    [aCoder encodeObject:self.createTs forKey:@"createTs"];
    [aCoder encodeObject:self.isAvailable forKey:@"isAvailable"];
}

- (void)dealloc
{
    
    [categoryId release];
    [classDesc release];
    [classId release];
    [className release];
    [createTs release];
    [isAvailable release];
    
    [super dealloc];
}

@end
