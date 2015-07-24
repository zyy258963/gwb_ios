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
    
    NSString *baseUrl = [NSString stringWithFormat:@"%@", @"http://www.weebo.com.cn/gwb1/ios/logInfo"];
    
    NSArray *keys = [NSArray arrayWithObjects:@"tele",nil];
    NSArray *values = [NSArray arrayWithObjects:[UserManager sharedManager].userID,nil];
    
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

- (void)takeTongJiDoc:(NSString *) docName
{
    [self cancelRequest];
    
    NSString *baseUrl = [NSString stringWithFormat:@"%@", @"http://www.weebo.com.cn/gwb1/ios/logOpenInfo"];
    
    NSArray *keys = [NSArray arrayWithObjects:@"tele",@"keywords",nil];
    NSArray *values = [NSArray arrayWithObjects:[UserManager sharedManager].userID,docName,nil];
    
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

- (void)takeTongJiSave:(NSString *) docId
{
    [self cancelRequest];
    
    NSString *uuid =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:@"DAKA" error:nil];
    
    if (uuid.length == 0 || uuid == nil) {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, theUUID);
        CFRelease(theUUID);
        NSString *temp = [(NSString *)string autorelease];
        [SFHFKeychainUtils storeUsername:@"UUID" andPassword:temp forServiceName:@"DAKA" updateExisting:1 error:nil];
        
        uuid =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:@"DAKA" error:nil];
    }
    
    
    NSString *baseUrl = [NSString stringWithFormat:@"%@", @"http://www.weebo.com.cn/gwb1/ios/addFavourite"];
    
    NSArray *keys = [NSArray arrayWithObjects:@"tele",@"mac",@"userId",@"bookId",nil];
    NSArray *values = [NSArray arrayWithObjects:[UserManager sharedManager].userID,uuid,[UserManager sharedManager].userID,docId,nil];
    
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


- (void)takeTongJiUnSave:(NSString *) favoutiteId
{
    [self cancelRequest];
    
    NSString *uuid =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:@"DAKA" error:nil];
    
    if (uuid.length == 0 || uuid == nil) {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, theUUID);
        CFRelease(theUUID);
        NSString *temp = [(NSString *)string autorelease];
        [SFHFKeychainUtils storeUsername:@"UUID" andPassword:temp forServiceName:@"DAKA" updateExisting:1 error:nil];
        
        uuid =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:@"DAKA" error:nil];
    }
    
    
    NSString *baseUrl = [NSString stringWithFormat:@"%@", @"http://www.weebo.com.cn/gwb1/ios/addFavourite"];
    
    NSArray *keys = [NSArray arrayWithObjects:@"tele",@"mac",@"bookId",nil];
    NSArray *values = [NSArray arrayWithObjects:[UserManager sharedManager].userID,uuid,favoutiteId,nil];
    
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
