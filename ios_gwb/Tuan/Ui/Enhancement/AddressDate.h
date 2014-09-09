//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AddressItem.h"

@interface AddressDate : NSObject
{
    NSMutableArray *addressArray;
}

- (void)collectContacts;

- (NSMutableArray *)address;

@end
