//
//  GetAddvQuery.h
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DocumentListItem.h"
#import "BaseQuery.h"

@interface SearchListQuery : BaseQuery
{
    NSString *_cId;
    NSString *_keyWord;
    
    NSMutableArray *_listItemArray;
    NSObject *_mytarget;
}
@property(nonatomic, retain)NSString *cId;
@property(nonatomic, retain)NSString *keyWord;

@property(nonatomic, readonly)NSMutableArray *listItemArray;
@property(nonatomic, assign)NSObject *mytarget;


- (void)getSearchList;
- (void)getSearchListComplete:(NSData *)data obj:(NSObject *)obj;
- (void)getSearchListErrorWithObj:(NSObject *)obj;

@end
