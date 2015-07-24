//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhoneNumberFormatter : NSFormatter
{
    NSString *tempStr;
}

@property (nonatomic, retain) NSString *tempStr;

- (NSString *) stringFromPhoneNumber:(NSString *)aNumber;

@end
