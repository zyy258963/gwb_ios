//
//  UserProfileManager.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserBankCardItem;
@class UserDeliveryAddress;

@interface UserProfileManager : NSObject
{
    NSString *_userId;
    NSMutableArray *_userPayCardArray;
    NSMutableArray *_userDeliveryAddressArray;
}

@property(nonatomic, retain)NSString *userId;

@property(nonatomic, retain)NSMutableArray *userPayCardArray;
@property(nonatomic, retain)NSMutableArray *userDeliveryAddressArray;

+ (UserProfileManager *)sharedManager;

- (void)addNewBankCard:(UserBankCardItem *)item;

- (void)removeBankCard:(int)index;

- (void)addNewDeliveryAddress:(UserDeliveryAddress *)address;

- (void)removeDeliveryAddress:(int)index;

- (void)loadData;

- (void)storeDataToFile;

- (NSString *)filePath;

@end
