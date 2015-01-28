//
//  GetAddvQuery.h
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryItem.h"
#import "BaseQuery.h"

@interface WenJianBtnListQuery : BaseQuery
{
    NSMutableArray *_listItemArray;
    NSObject *_mytarget;
}

@property(nonatomic, readonly)NSMutableArray *listItemArray;
@property(nonatomic, assign)NSObject *mytarget;


- (void)getWenJianBtnList;
- (void)getWenJianBtnListComplete:(NSData *)data obj:(NSObject *)obj;
- (void)getWenJianBtnListErrorWithObj:(NSObject *)obj;

@end
