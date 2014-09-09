//
//  BaseQuery.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestSender.h"
#import "ConfigManager.h"

@interface BaseQuery : NSObject
{

    RequestSender *_sender;  //weak ref;
    
    BOOL       _isObserveLocationManager;
    
    NSString *_curCity;
    NSString *_curLpi;
    NSString *_curLci;
}

@property(nonatomic, assign)RequestSender *sender;

@property (nonatomic, assign) BOOL isObserveLocationManager;

@property (nonatomic, copy) NSString *curCity;
@property (nonatomic, retain) NSString *curLpi;
@property (nonatomic, retain) NSString *curLci;

- (id)init;

- (void)cancelRequest;

- (void)resetSender;

- (NSString *)md5Encode:(NSString *)str;

@end
