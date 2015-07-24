//
//  BaseItem.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLNode.h"

@interface BaseItem : NSObject <NSCoding>
{
    int _type;
	NSString *_shopId;
    NSString *_itemId;
}

@property(nonatomic, assign)int type;
@property(nonatomic, retain)NSString *shopId;
@property(nonatomic, retain)NSString *itemId;


- (id)initWithXml:(XMLNode *)result;
- (id)initWithJSON:(NSDictionary *)result;

@end
