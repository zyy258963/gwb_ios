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

@interface SubCategoryItem : NSObject
{
    NSString *categoryId;
    NSString *classDesc;
    NSString *classId;
    NSString *className;
    NSString *createTs;
    NSString *isAvailable;
}

@property(nonatomic, retain)NSString *categoryId;
@property(nonatomic, retain)NSString *classDesc;
@property(nonatomic, retain)NSString *classId;
@property(nonatomic, retain)NSString *className;
@property(nonatomic, retain)NSString *createTs;
@property(nonatomic, retain)NSString *isAvailable;

@end
