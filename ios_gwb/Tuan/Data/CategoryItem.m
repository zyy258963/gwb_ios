//
//  AddvItem.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryItem.h"
#import "XMLParser.h"

@implementation CategoryItem

@synthesize categoryDesc;
@synthesize categoryId;
@synthesize categoryLevel;
@synthesize categoryName;
@synthesize createTs;
@synthesize isAvailable;
@synthesize superId;

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
        self.categoryDesc = [aDecoder decodeObjectForKey:@"categoryDesc"];
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.categoryLevel = [aDecoder decodeObjectForKey:@"categoryLevel"];
        self.categoryName = [aDecoder decodeObjectForKey:@"categoryName"];
        self.createTs = [aDecoder decodeObjectForKey:@"createTs"];
        self.isAvailable = [aDecoder decodeObjectForKey:@"isAvailable"];
        self.superId = [aDecoder decodeObjectForKey:@"superId"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.categoryDesc forKey:@"categoryDesc"];
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.categoryLevel forKey:@"categoryLevel"];
    [aCoder encodeObject:self.categoryName forKey:@"categoryName"];
    [aCoder encodeObject:self.createTs forKey:@"createTs"];
    [aCoder encodeObject:self.isAvailable forKey:@"isAvailable"];
    [aCoder encodeObject:self.superId forKey:@"superId"];
}

- (void)dealloc
{
    
    [categoryDesc release];
    [categoryId release];
    [categoryLevel release];
    [categoryName release];
    [createTs release];
    [isAvailable release];
    [superId release];

    [super dealloc];
}

@end
