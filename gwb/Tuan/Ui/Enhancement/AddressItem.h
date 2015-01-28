//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressItem : NSObject <NSCoding>
{

    NSString *name;
    NSString *phoneNumber;
    BOOL isShow;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *phoneNumber;
@property BOOL isShow;

- (NSComparisonResult)localizedCaseInsensitiveCompare:(AddressItem *)otherObject;

- (NSComparisonResult)localizedCompare:(AddressItem *)otherObject;

- (NSComparisonResult)compare:(AddressItem *)otherObject;

- (NSComparisonResult) compareTheAddressBookWay:(AddressItem *)otherObject;



@end

