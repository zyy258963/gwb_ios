//
//  UserInforItem.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "UserInforItem.h"

@implementation propertyItem

@synthesize propertyName = _propertyName;
@synthesize propertyAdd = _propertyAdd;
@synthesize shopId = _shopId;
@synthesize itemId = _itemId;

- (id)init{

    self = [super init];
    if (self) {

    }

return self;

}

- (id)initWithJson:(NSDictionary*)dic
{
    self = [self init];
    if (self) {
        
        self.propertyName = [dic objectForKey:@"shopname"];
        self.propertyAdd = [dic objectForKey:@"shopaddress"];
        self.shopId = [dic objectForKey:@"shopid"];
        self.itemId = [dic objectForKey:@"id"];
    }

   return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{   
    [coder encodeObject:self.propertyName forKey:@"propertyName"];
    [coder encodeObject:self.propertyAdd forKey:@"propertyAdd"];

    [coder encodeObject:self.shopId forKey:@"shopId"];
    [coder encodeObject:self.itemId forKey:@"itemId"];

}

- (id) initWithCoder: (NSCoder *) coder
{
    [self init];
    self.propertyName = [coder decodeObjectForKey:@"propertyName"]; 
    self.propertyAdd = [coder decodeObjectForKey:@"propertyAdd"];
    self.shopId = [coder decodeObjectForKey:@"shopId"];
    self.itemId = [coder decodeObjectForKey:@"itemId"];
    return self;
}

- (void)dealloc
{
    self.propertyName = nil;
    self.propertyAdd = nil;
    self.shopId = nil;
    self.itemId = nil;
    [super dealloc];
}

@end

///////////////////////////////////////////////////////////////////////

@implementation UserInforItem

@synthesize userId = _userId;
@synthesize userName = _userName;
@synthesize avartarUrl = _avartarUrl;

@synthesize mobile = _mobile;
@synthesize email = _email;

@synthesize favCount = _favCount;
@synthesize dizhuCount = _dizhuCount;
@synthesize fortune = _fortune;
@synthesize propertyTotal = _propertyTotal;
@synthesize propertyIndex = _propertyIndex;
@synthesize itemArr = _itemArr;

@synthesize modified = _modified;

- (id)init{
    
    self = [super init];
    if (self) {
        _itemArr = [[NSMutableArray alloc] initWithCapacity:3];
    }
    
    return self;
    
}

- (id)initWithJson:(NSDictionary*)dic
{
    self = [self init];
    if (self) {
        
        self.dizhuCount = [dic objectForKey:@"toptotal"];
        self.fortune = [dic objectForKey:@"scoretotal"];
        
        self.avartarUrl = [[dic objectForKey:@"customer"] objectForKey:@"profile"];
        self.userName = [[dic objectForKey:@"customer"] objectForKey:@"customername"];
        self.userId = [[dic objectForKey:@"customer"] objectForKey:@"id"];
        self.mobile = [[dic objectForKey:@"customer"] objectForKey:@"mobile"];
        self.email = [[dic objectForKey:@"customer"] objectForKey:@"email"];

        
        NSArray *temp = [dic objectForKey:@"datas"];
        int count = temp.count;

        propertyItem *tempItem = nil;
        for (int i = 0; i < count; i++) {
            tempItem = [[propertyItem alloc] initWithJson:[temp objectAtIndex:i]];
            [_itemArr addObject:tempItem];
            [tempItem release];
            tempItem = nil;
        }
    }
    
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{   
    [coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:self.userName forKey:@"userName"];
    [coder encodeObject:self.avartarUrl forKey:@"avartarUrl"];
    
    [coder encodeObject:self.mobile forKey:@"mobile"];
    [coder encodeObject:self.email forKey:@"email"];
    
    [coder encodeObject:[NSNumber numberWithInt:self.favCount] forKey:@"favCount"];
    [coder encodeObject:self.dizhuCount forKey:@"dizhuCount"];
    [coder encodeObject:self.fortune forKey:@"fortune"];
    
    [coder encodeObject:[NSNumber numberWithInt:self.propertyTotal] forKey:@"propertyTotal"];
    [coder encodeObject:[NSNumber numberWithInt:self.propertyIndex] forKey:@"propertyIndex"];
    
    [coder encodeObject:self.itemArr forKey:@"itemArr"];
}

- (id) initWithCoder: (NSCoder *) coder
{
    [self init];
    self.userId = [coder decodeObjectForKey:@"userId"]; 
    self.userName = [coder decodeObjectForKey:@"userName"];
    self.avartarUrl = [coder decodeObjectForKey:@"avartarUrl"];
    
    self.mobile = [coder decodeObjectForKey:@"mobile"];
    self.email = [coder decodeObjectForKey:@"email"];

    self.favCount = [[coder decodeObjectForKey:@"favCount"] intValue];
    self.dizhuCount = [coder decodeObjectForKey:@"dizhuCount"];
    self.fortune = [coder decodeObjectForKey:@"fortune"];
    
    self.propertyTotal = [[coder decodeObjectForKey:@"propertyTotal"] intValue];
    self.propertyIndex = [[coder decodeObjectForKey:@"propertyIndex"] intValue];
    self.itemArr = [coder decodeObjectForKey:@"itemArr"];
    
    return self;
}

- (void)dealloc
{
    self.userId = nil;
    self.userName = nil;
    self.avartarUrl = nil;
    self.itemArr = nil;
    
    self.mobile = nil;
    self.email =nil;
    
    self.dizhuCount = nil;
    self.fortune = nil;
    
    [super dealloc];
}

@end
