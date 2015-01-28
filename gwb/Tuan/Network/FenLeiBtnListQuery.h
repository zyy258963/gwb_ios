//
//  GetAddvQuery.h
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubCategoryItem.h"
#import "BaseQuery.h"

@interface FenLeiBtnListQuery : BaseQuery
{
    NSString *_cId;
    
    
    NSMutableArray *_listItemArray;
    NSObject *_mytarget;
}
@property(nonatomic, retain)NSString *cId;
@property(nonatomic, readonly)NSMutableArray *listItemArray;
@property(nonatomic, assign)NSObject *mytarget;


- (void)getFenLeiBtnList;
- (void)getFenLeiBtnListComplete:(NSData *)data obj:(NSObject *)obj;
- (void)getFenLeiBtnListErrorWithObj:(NSObject *)obj;

@end
