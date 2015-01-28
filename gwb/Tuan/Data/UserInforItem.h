//
//  UserInforItem.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>

@interface propertyItem : NSObject <NSCoding>
{
    NSString *_propertyName;
    NSString *_propertyAdd;
    NSString *_shopId;
    NSString *_itemId;
}

@property(nonatomic, retain)NSString *propertyName;
@property(nonatomic, retain)NSString *propertyAdd;
@property(nonatomic, retain)NSString *shopId;
@property(nonatomic, retain)NSString *itemId;

- (id)initWithJson:(NSDictionary*)dic;

@end

@interface UserInforItem : NSObject
{
    NSString *_userId;
    NSString *_userName;
    NSString *_avartarUrl;
    
    NSString *_mobile;
    NSString *_email;
    
    NSInteger _favCount;
    NSString *_dizhuCount;
    NSString *_fortune;
    
    //below for property infor
    NSInteger _propertyTotal;
    NSInteger _propertyIndex;
    NSMutableArray *_itemArr;
    
    BOOL      _modified;
}

@property(nonatomic, retain)NSString *userId;
@property(nonatomic, retain)NSString *userName;
@property(nonatomic, retain)NSString *avartarUrl;

@property(nonatomic, retain)NSString *mobile;
@property(nonatomic, retain)NSString *email;

@property NSInteger favCount;
@property(nonatomic, retain)NSString* dizhuCount;
@property(nonatomic, retain)NSString* fortune;

@property NSInteger propertyTotal;
@property NSInteger propertyIndex;
@property(nonatomic, retain)NSMutableArray *itemArr;

@property BOOL modified;

- (id)init;

- (id)initWithJson:(NSDictionary*)dic;

@end
