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

@interface WenJianListQuery : BaseQuery
{
    NSString *_cId;
    NSString *_keyWord;
    
    NSMutableArray *_listItemArray;
    NSObject *_mytarget;
}
@property(nonatomic, retain)NSString *cId;
@property(nonatomic, retain)NSString *keyWord;

@property(nonatomic, readonly)NSMutableArray *listItemArray;
@property(nonatomic, retain,__unsafe_unretained)NSObject *mytarget;


- (void)getWenJianList;
- (void)getWenJianListComplete:(NSData *)data obj:(NSObject *)obj;
- (void)getWenJianListErrorWithObj:(NSObject *)obj;

@end
