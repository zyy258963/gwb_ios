//
//  GetAddvQuery.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoginQuery.h"
#import "JSON.h"
#import "SFHFKeychainUtils.h"

@implementation LoginQuery

@synthesize loginName = _loginName;
//@synthesize loginPwd = _loginPwd;
@synthesize mytarget =_mytarget;
- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)loginSystem
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
    
    NSString *baseUrl = [NSString stringWithFormat:@"%@", @"http://117.79.84.185:8080/GwbProject/IosLoginAction"];
    
    NSArray *keys = [NSArray arrayWithObjects:@"type",@"telephone",@"macAddress",nil];
    NSArray *values = [NSArray arrayWithObjects:@"appLogin",self.loginName,uuid,nil];
    
    self.sender= [RequestSender requestSenderWithURL:baseUrl
                                             usePost:2
                                                keys:keys
                                              values:values
                                            delegate:self
                                    completeSelector:@selector(loginSystemComplete:obj:)
                                       errorSelector:@selector(loginSystemErrorWithObj:)
                                    selectorArgument:@"网络连接失败"];
    [self.sender send];
    
}

- (void)loginSystemComplete:(NSData *)data obj:(NSObject *)obj
{
    [self resetSender];
    
    NSString *stringData =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary *content = (NSDictionary *)[stringData JSONValue];
    NSDictionary *head = [content objectForKey:@"header"];
    int code = [[head objectForKey:@"code"] intValue];
    NSString *message = [head objectForKey:@"msg"];
    
    //NSDictionary *content1 = [content objectForKey:@"content"];
    
    if (code == 1) 
    {
        [UserManager sharedManager].userInfo = YES;
        [UserManager sharedManager].userID = self.loginName;
        [UserManager sharedManager].userName = self.loginName;
        
        if (_mytarget && [_mytarget respondsToSelector:@selector(loginQueryDidFinishUpdate:)]) {
            [_mytarget performSelector:@selector(loginQueryDidFinishUpdate:) withObject:nil];
        }
        
    }else {
        if (_mytarget && [_mytarget respondsToSelector:@selector(loginQueryError:)]) {
            [_mytarget performSelector:@selector(loginQueryError:) withObject:message];
        }
    }
    
}

- (void)loginSystemErrorWithObj:(NSObject *)obj
{
    [self resetSender];
    
    if (_mytarget && [_mytarget respondsToSelector:@selector(loginQueryError:)]) {
		[_mytarget performSelector:@selector(loginQueryError:) withObject:obj];
	}
    
}

- (void)logoutSystemComplete:(NSData *)data obj:(NSObject *)obj
{
    [self resetSender];
    
    NSString *stringData =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary *content = (NSDictionary *)[stringData JSONValue];
    
    int code = [[content objectForKey:@"status"] intValue];
    NSString *message = [content objectForKey:@"content"];
    
    if (code == 1)
    {
        [UserManager sharedManager].userInfo = NO;
        [UserManager sharedManager].userID = @"";
        [UserManager sharedManager].userName = @"";
        [UserManager sharedManager].userPassWord = @"";
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"0" forKey:@"LOGINMESSAGE_VERSION"];
        [userDefaults setObject:@"0" forKey:@"ZBCHANNEL_VERSION"];
        [userDefaults setObject:@"0" forKey:@"ZBPPT_VERSION"];
        [userDefaults setObject:@"0" forKey:@"JWHCHANNEL_VERSION"];
        [userDefaults setObject:@"0" forKey:@"JWHNOTICE_VERSION"];
        [userDefaults setObject:@"0" forKey:@"WYCHANNEL_VERSION"];
        [userDefaults setObject:@"0" forKey:@"WYNOTICE_VERSION"];
        [userDefaults setObject:@"0" forKey:@"NEWDONGTAI_VERSION"];
        
        [userDefaults synchronize];
        
        if (_mytarget && [_mytarget respondsToSelector:@selector(logoutQueryDidFinishUpdate:)]) {
            [_mytarget performSelector:@selector(logoutQueryDidFinishUpdate:) withObject:message];
        }
        
    }else {
        if (_mytarget && [_mytarget respondsToSelector:@selector(logoutQueryError:)]) {
            [_mytarget performSelector:@selector(logoutQueryError:) withObject:message];
        }
    }
    
}

- (void)logoutSystemErrorWithObj:(NSObject *)obj
{
    [self resetSender];
    
    if (_mytarget && [_mytarget respondsToSelector:@selector(logoutQueryError:)]) {
		[_mytarget performSelector:@selector(logoutQueryError:) withObject:obj];
	}
    
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

@end
