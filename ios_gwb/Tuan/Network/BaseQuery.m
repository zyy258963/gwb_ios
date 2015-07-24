//
//  BaseQuery.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "BaseQuery.h"

#define CC_LOGIN_MD5_LENGTH 16

@implementation BaseQuery

@synthesize sender = _sender;
@synthesize isObserveLocationManager = _isObserveLocationManager;

@synthesize curCity = _curCity;
@synthesize curLpi = _curLpi;
@synthesize curLci = _curLci;

- (id)init
{
    self = [super init];
    
    if (self) {
        // Initialization code here.
        _sender = nil;
    }
    
    return self;
}

- (void)cancelRequest
{
    if (self.sender)
    {
        [self.sender resetConnection];
        self.sender = nil;
    }
}

- (void)resetSender
{
    self.sender = nil;
}

- (NSString *)md5Encode:(NSString *)str
{
    const char *cstr = [str UTF8String];
    unsigned char r[CC_LOGIN_MD5_LENGTH];
    CC_MD5(cstr, strlen(cstr), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
}

- (void)dealloc
{
    [self cancelRequest];
    
    [_curCity release];
    [_curLci release];
    [_curLpi release];
    
    [super dealloc];
}

@end
