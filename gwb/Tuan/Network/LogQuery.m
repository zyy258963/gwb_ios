//
//  GetAddvQuery.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LogQuery.h"
#import "JSON.h"
#import "SFHFKeychainUtils.h"

@implementation LogQuery

@synthesize mytarget =_mytarget;
- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)takeTongJi
{
    [self cancelRequest];
    
    NSString *baseUrl = [NSString stringWithFormat:@"%@", @"http://weebo.com.cn:8080/GwbProject/IosLoginAction"];
    
    NSArray *keys = [NSArray arrayWithObjects:@"type",@"telephone",nil];
    NSArray *values = [NSArray arrayWithObjects:@"logInfo",[UserManager sharedManager].userID,nil];
    
    self.sender= [RequestSender requestSenderWithURL:baseUrl
                                             usePost:1
                                                keys:keys
                                              values:values
                                            delegate:self
                                    completeSelector:@selector(takeTongJiQueryDidFinishUpdate:obj:)
                                       errorSelector:@selector(takeTongJiQueryError:)
                                    selectorArgument:@"网络连接失败"];
    [self.sender send];
    
}

- (void)takeTongJiQueryDidFinishUpdate:(NSData *)data obj:(NSObject *)obj
{
    [self resetSender];
}

- (void)takeTongJiQueryError:(NSObject *)obj
{
    [self resetSender];
}

@end
