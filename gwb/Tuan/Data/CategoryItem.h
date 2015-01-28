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

@interface CategoryItem : NSObject
{
    NSString *categoryDesc;
    NSString *categoryId;
    NSString *categoryLevel;
    NSString *categoryName;
    NSString *createTs;
    NSString *isAvailable;
    NSString *superId;
}

@property(nonatomic, retain)NSString *categoryDesc;
@property(nonatomic, retain)NSString *categoryId;
@property(nonatomic, retain)NSString *categoryLevel;
@property(nonatomic, retain)NSString *categoryName;
@property(nonatomic, retain)NSString *createTs;
@property(nonatomic, retain)NSString *isAvailable;
@property(nonatomic, retain)NSString *superId;

@end
