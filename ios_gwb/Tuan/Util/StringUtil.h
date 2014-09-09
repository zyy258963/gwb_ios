//
// StringUtil.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

+ (NSString *)emptyForNil:(NSString *)str;
+ (NSString *)emptyForNil:(NSString *)str withPrefix:(NSString *)prefix postfix:(NSString *)postfix;

+ (NSString *)md5Encode:(NSString *)str;

+ (NSString *)dateFormat:(NSDate *)date;

+ (int)countWords:(NSString *)message;

@end
