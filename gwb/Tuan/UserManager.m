//
// UserManager.m
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "UserManager.h"


@implementation UserManager
@synthesize userInfo;
@synthesize sinaStringKey;
@synthesize qqStringKey;
@synthesize userName;
@synthesize userPassWord;
@synthesize userID;
@synthesize email;

@synthesize isFromAddressEdit;

@synthesize isFirstIntoOrderForm;
@synthesize amount;
@synthesize myOrderId;
@synthesize _loginUID;
@synthesize _loginType;
@synthesize isShare;
@synthesize versionType;
@synthesize bacToListView;

@synthesize myPayId;
@synthesize myTotal;
@synthesize isHavePhone;
@synthesize writePhoneNumber;
@synthesize touchString;

@synthesize userItem = _userItem;

static UserManager *_sharedManager = nil;

+ (UserManager *)sharedManager
{
    if (_sharedManager == nil)
    {
        _sharedManager = [[UserManager alloc] init];
    }
    return _sharedManager;
}


- (id)init
{
    self = [super init];
    if (self)
    {
		defaults = [NSUserDefaults standardUserDefaults];
		userInfo = NO;
		sinaStringKey = [[NSString alloc] init];
		qqStringKey = [[NSString alloc] init];
        userID = @"";
        _loginUID = @"";
        _loginType = @"";
        isShare = 1;
        versionType = 0;
        writePhoneNumber = @"";
    
        
        if ([defaults objectForKey:@"bind"]) 
        {
            dic = [defaults objectForKey:@"bind"];
        }
        else
        {
            dic = [[NSMutableDictionary alloc] init];
        }
        
    }
	
    return self;
}

- (void)setUserInfo:(BOOL)info
{
	[defaults setBool:info forKey:USER_INFO];
	[defaults synchronize];
}

- (BOOL)userInfo 
{
	return [defaults boolForKey:USER_INFO];
}

- (void)setSinaStringKey:(NSString *)stringKey
{
	[defaults setObject:stringKey forKey:USER_SINA];
	[defaults synchronize];
}

- (NSString *)sinaStringKey
{
	return [defaults objectForKey:USER_SINA];
}

- (void)setQqStringKey:(NSString *)stringKey
{
	[defaults setObject:stringKey forKey:USER_QQ];
	[defaults synchronize];
}

- (NSString *)qqStringKey
{
	return [defaults objectForKey:USER_QQ];
}

- (void)setUserName:(NSString *)name
{
	[defaults setObject:name forKey:USER_NAME];
	[defaults synchronize];
}

- (NSString *)userName
{
	return [defaults objectForKey:USER_NAME];
}

- (void)setUserPassWord:(NSString *)password
{
	[defaults setObject:password forKey:USER_PASSWORD];
	[defaults synchronize];
}

- (NSString *)userPassWord
{
	return [defaults objectForKey:USER_PASSWORD];
}

- (void)setUserID:(NSString *)userID
{
    [defaults setObject:userID forKey:USER_ID];
    [defaults synchronize];
}

- (NSString *)userID
{
    return [defaults objectForKey:USER_ID];
}

- (void)setEmail:(NSString *)email
{
    [defaults setObject:email forKey:USER_EMAIL];
    [defaults synchronize];
}

- (NSString *)email
{
    return [defaults objectForKey:USER_EMAIL];
}

- (void)set_loginUID:(NSString *)_loginUID
{
    [defaults setObject:_loginUID forKey:LOGIN_UID];
    [defaults synchronize];
}

- (NSString *)_loginUID
{
    return [defaults objectForKey:LOGIN_UID];
}

- (void)set_loginType:(NSString *)_loginType
{
    [defaults setObject:_loginType forKey:LOGIN_TYPE];
    [defaults synchronize];
}

- (NSString *)_loginType
{
    return [defaults objectForKey:LOGIN_TYPE];
}

- (void)setIsShare:(int)isShare
{
    [defaults setInteger:isShare forKey:USER_SHARE];
    [defaults synchronize];
}

- (int)isShare
{
    if ([defaults integerForKey:USER_SHARE] == 0) 
    {
        return 1;
    }
    return [defaults integerForKey:USER_SHARE];
}

- (void)setIsHavePhone:(BOOL)isHavePhone
{
    [defaults setBool:isHavePhone forKey:HAVE_PHONE];
    [defaults synchronize];
}

- (BOOL)isHavePhone
{
    return [defaults boolForKey:HAVE_PHONE];
}

- (void)setWritePhoneNumber:(NSString *)writePhoneNumber
{
    [defaults setObject:writePhoneNumber forKey:@"writePhone"];
    [defaults synchronize];
}

- (NSString *)writePhoneNumber
{
    return [defaults objectForKey:@"writePhone"];
}

- (void)writePhoneForKey:(NSString *)phone keys:(NSString *)key
{
    [dic setObject:phone forKey:key];
    [defaults setObject:dic forKey:@"bind"];
    [defaults synchronize];
    
}

- (NSString *)phoneForKey:(NSString *)key
{
    //dic = [defaults objectForKey:@"bind"];
    return [dic objectForKey:key];
}

- (void)setTouchString:(NSString *)touchString
{
    [defaults setObject:touchString forKey:@"touchString"];
    [defaults synchronize];
}

- (NSString *)touchString
{
    return [defaults objectForKey:@"touchString"];
}

- (void)dealloc
{
	[sinaStringKey release];
	[qqStringKey release];
	[userName release];
	[userPassWord release];
    [_loginUID release];
    [_loginType release];
    [writePhoneNumber release];
    [dic release];
    [touchString release];
    
    self.myPayId = nil;
    
    self.userItem = nil;
    
    [super dealloc];
}


@end
