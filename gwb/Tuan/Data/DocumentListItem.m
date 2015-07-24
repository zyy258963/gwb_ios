//
//  AddvItem.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DocumentListItem.h"
#import "XMLParser.h"



@implementation DocumentListItem

@synthesize bookChapterNum;
@synthesize bookDesc;
@synthesize bookId;
@synthesize bookName;
@synthesize categoryId;
@synthesize classId;
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

- (void)dealloc
{

    [bookChapterNum release];
    [bookDesc release];
    [bookId release];
    [bookName release];
    [categoryId release];
    [classId release];
    [createTs release];
    [isAvailable release];
    
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.bookChapterNum = [aDecoder decodeObjectForKey:@"bookChapterNum"];
        self.bookDesc = [aDecoder decodeObjectForKey:@"bookDesc"];
        self.bookId = [aDecoder decodeObjectForKey:@"bookId"];
        self.bookName = [aDecoder decodeObjectForKey:@"bookName"];
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.classId = [aDecoder decodeObjectForKey:@"classId"];
        self.createTs = [aDecoder decodeObjectForKey:@"createTs"];
        self.isAvailable = [aDecoder decodeObjectForKey:@"isAvailable"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.bookChapterNum forKey:@"bookChapterNum"];
    [aCoder encodeObject:self.bookDesc forKey:@"bookDesc"];
    [aCoder encodeObject:self.bookId forKey:@"bookId"];
    [aCoder encodeObject:self.bookName forKey:@"bookName"];
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.classId forKey:@"classId"];
    [aCoder encodeObject:self.createTs forKey:@"createTs"];
    [aCoder encodeObject:self.isAvailable forKey:@"isAvailable"];
}

@end
