//
//  AddvItem.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChapterListItem.h"
#import "XMLParser.h"



@implementation ChapterListItem

@synthesize chapterId;
@synthesize chapterDesc;
@synthesize chapterNum;
@synthesize bookId;
//@synthesize bookName;
@synthesize chapterUrl;
@synthesize chapterName;

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

    [chapterId release];
    [chapterDesc release];
    [chapterNum release];
    [bookId release];
//    [bookName release];
    [chapterUrl release];
    [chapterName release];
    
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.chapterId = [aDecoder decodeObjectForKey:@"chapterId"];
        self.chapterDesc = [aDecoder decodeObjectForKey:@"chapterDesc"];
        self.chapterNum = [aDecoder decodeObjectForKey:@"chapterNum"];
        self.bookId = [aDecoder decodeObjectForKey:@"bookId"];
//        self.bookName = [aDecoder decodeObjectForKey:@"chapterNum"];
        self.chapterUrl = [aDecoder decodeObjectForKey:@"chapterUrl"];
        self.chapterName = [aDecoder decodeObjectForKey:@"chapterName"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.chapterId forKey:@"chapterId"];
    [aCoder encodeObject:self.chapterDesc forKey:@"chapterDesc"];
    [aCoder encodeObject:self.chapterNum forKey:@"chapterNum"];
    [aCoder encodeObject:self.bookId forKey:@"bookId"];
//    [aCoder encodeObject:self.bookName forKey:@"chapterNum"];
    [aCoder encodeObject:self.chapterUrl forKey:@"chapterUrl"];
    [aCoder encodeObject:self.chapterName forKey:@"chapterName"];
}

@end
