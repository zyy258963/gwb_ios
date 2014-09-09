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

@interface CategoryListItem : NSObject
{

    //分类ID
    NSString *_categoryId;
    //分类名称
    NSString *_categoryName;

}

@property(nonatomic, retain)NSString *categoryId;
@property(nonatomic, retain)NSString *categoryName;

@end
