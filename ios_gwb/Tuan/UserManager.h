//
// UserManager.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InviteItem.h"
#import "UserInforItem.h"

#define USER_INFO		@"userinfo"
#define USER_SINA		@"sina"
#define USER_QQ			@"qq"
#define USER_NAME		@"name"
#define USER_PASSWORD	@"password"
#define USER_ID         @"id"
#define USER_TOURIST    @"tourist"
#define USER_LOGIN      @"login"
#define TOURIST_TYPE    @"regin"
#define USER_EMAIL      @"email"
#define LOGIN_UID       @"loginuid"
#define LOGIN_TYPE      @"logintype"
#define USER_SHARE      @"share"
#define VERSION_TYPE    @"version"
#define HAVE_PHONE      @"havephone"

@interface UserManager : NSObject {

	NSUserDefaults *defaults;
	BOOL userInfo;
	NSString *sinaStringKey;
	NSString *qqStringKey;
	NSString *userName;
	NSString *userPassWord;
    
    NSString *userID;
    
    NSString *email;

	BOOL isFirstIntoOrderForm;

	NSString *amount;
	BOOL isFromAddressEdit;
	
	NSString *myOrderId;

    NSString *_loginUID;
    NSString *_loginType;
    
    int isShare;
    
    int versionType;
	
	NSString *myPayId;
	NSString *myTotal;
    
    BOOL isHavePhone;
    
    NSString *writePhoneNumber;

    NSMutableDictionary *dic;
    
    NSString *touchString;
	
	UIViewController *bacToListView;
    
    
    //for new userinfo
    UserInforItem *_userItem;
}

+ (UserManager *)sharedManager;

@property BOOL userInfo;
@property (nonatomic, retain)NSString *sinaStringKey; 
@property (nonatomic, retain)NSString *qqStringKey;
@property (nonatomic, retain)NSString *userName;
@property (nonatomic, retain)NSString *userPassWord;
@property (nonatomic, retain)NSString *userID;
@property (nonatomic, retain)NSString *email;

@property BOOL isFirstIntoOrderForm;
@property (nonatomic, retain)NSString *amount;
@property BOOL isFromAddressEdit;
@property (nonatomic, retain)UIViewController *bacToListView;

@property (nonatomic, retain)NSString *myOrderId;
@property (nonatomic, retain)NSString *myPayId;
@property (nonatomic, retain)NSString *myTotal;
@property (nonatomic, retain)NSString *_loginUID;
@property (nonatomic, retain)NSString *_loginType;

@property int isShare;

@property int versionType;

@property BOOL isHavePhone;
@property (nonatomic, retain)NSString *writePhoneNumber;
@property (nonatomic, retain)NSString *touchString;

//add for new userInfo
@property(nonatomic, retain)UserInforItem *userItem;

- (void)writePhoneForKey:(NSString *)phone keys:(NSString *)key;

- (NSString *)phoneForKey:(NSString *)key;


@end
