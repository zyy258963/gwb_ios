//
//  BaseItem.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "BaseItem.h"

@implementation BaseItem

@synthesize type = _type;
@synthesize shopId = _shopId;
@synthesize itemId = _itemId;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _type = 1;
		_shopId = [[NSString alloc] initWithString:@""];
        _itemId = [[NSString alloc] initWithString:@""];
    }
    
    return self;
}

- (id)initWithXml:(XMLNode *)result
{
    self = [self init];
    if (self) {
    
    }
    return self;
}

- (id)initWithJSON:(NSDictionary *)result
{
    self = [self init];
    if (self) {
        
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.type = [[aDecoder decodeObjectForKey:@"itemType"] intValue];
	self.shopId = [aDecoder decodeObjectForKey:@"shopId"];
    self.itemId = [aDecoder decodeObjectForKey:@"itemId"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInt:_type] forKey:@"itemType"];
	[aCoder encodeObject:_shopId forKey:@"shopId"];
    [aCoder encodeObject:_itemId forKey:@"itemId"];
}

- (void)dealloc
{
	[_shopId release];
    [_itemId release];
    [super dealloc];
}

@end
