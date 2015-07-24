//
//  AddvItem.h
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLNode.h"
#import "XMLParser.h"

@interface ChapterListItem : NSObject
{

    NSString *chapterId;
    NSString *chapterNum;
    NSString *chapterDesc;
    NSString *bookId;
//    NSString *bookName;
    NSString *chapterUrl;
    NSString *chapterName;
    
}

@property(nonatomic, retain)NSString *chapterId;
@property(nonatomic, retain)NSString *chapterNum;
@property(nonatomic, retain)NSString *chapterDesc;
@property(nonatomic, retain)NSString *bookId;
//@property(nonatomic, retain)NSString *bookName;
@property(nonatomic, retain)NSString *chapterUrl;
@property(nonatomic, retain)NSString *chapterName;

@end
