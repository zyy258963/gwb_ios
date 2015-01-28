//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InviteItem : NSObject <NSCoding>
{
    NSString *registered;
    NSString *userId;
    NSString *mobile;
}

@property (nonatomic, retain) NSString *registered;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *mobile;

@end
