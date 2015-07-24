//
//  AddvItem.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryListItem.h"
#import "XMLParser.h"



@implementation CategoryListItem

@synthesize categoryId = _categoryId;
@synthesize categoryName = _categoryName;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{

    [_categoryId release];
    [_categoryName release];
    
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.categoryName = [aDecoder decodeObjectForKey:@"categoryName"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.categoryName forKey:@"categoryName"];
}

@end
