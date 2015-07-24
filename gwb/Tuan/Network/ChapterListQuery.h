//
//  GetAddvQuery.h
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChapterListItem.h"
#import "BaseQuery.h"

@interface ChapterListQuery : BaseQuery
{
    NSString *_bookId;
    
    NSMutableArray *_listItemArray;
    NSObject *_mytarget;
}
@property(nonatomic, retain)NSString *bookId;

@property(nonatomic, readonly)NSMutableArray *listItemArray;
@property(nonatomic, retain,__unsafe_unretained)NSObject *mytarget;


- (void)getChapterList;
- (void)getChapterListComplete:(NSData *)data obj:(NSObject *)obj;
- (void)getChapterListErrorWithObj:(NSObject *)obj;

@end
