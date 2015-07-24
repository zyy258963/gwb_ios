//
//  AddvItem.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MuLuItem.h"
#import "XMLParser.h"



@implementation MuLuItem

@synthesize muluName;
@synthesize muluPage;

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
        self.muluName = [aDecoder decodeObjectForKey:@"muluName"];
        self.muluPage = [aDecoder decodeObjectForKey:@"muluPage"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.muluName forKey:@"muluName"];
    [aCoder encodeObject:self.muluPage forKey:@"muluPage"];
}

- (void)dealloc
{
    
    [muluName release];
    [muluPage release];
    
    [super dealloc];
}

@end
