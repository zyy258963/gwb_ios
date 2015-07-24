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

@interface DocumentListItem : NSObject
{

    NSString *bookChapterNum;
    NSString *bookDesc;
    NSString *bookId;
    NSString *bookName;
    NSString *categoryId;
    NSString *classId;
    NSString *createTs;
    NSString *isAvailable;
    
}

@property(nonatomic, retain)NSString *bookChapterNum;
@property(nonatomic, retain)NSString *bookDesc;
@property(nonatomic, retain)NSString *bookId;
@property(nonatomic, retain)NSString *bookName;
@property(nonatomic, retain)NSString *categoryId;
@property(nonatomic, retain)NSString *classId;
@property(nonatomic, retain)NSString *createTs;
@property(nonatomic, retain)NSString *isAvailable;

@end
