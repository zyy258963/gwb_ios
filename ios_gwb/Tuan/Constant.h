//
//  Constant.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

// AppID in itunes connect
#define APP_ID								@"477400616"

//for umeng
#define K_UMENG_KEY     @"5359b5bf56240b7fa308f74e"

//当前版本号
#define K_NOW_VERSION                       @"1.0"

#define K_CLIENT_TYPE                       @"1"

#define K_CHANEL_NAME                       @"appstore"
#define K_CHANEL_NUMBER                     @"1"

#define K_CURRENT_VERSION                   90

#define REGEX_EMAIL							@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"

#define TIMEOUT_URLCONNECTION               20.0f

#define WIDTH_FULL							320

#define HEIGHT_FULL							480

#define NOTIFY_CONFIRMBTNPRESSED			@"confirmBtn_pressed"

#define NETWORK                             @"http://117.79.84.185:8080/GwbProject/IosAction"



#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)



//end of file
