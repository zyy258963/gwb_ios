//
//  GetAddvQuery.h
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseQuery.h"
#import "FMDatabase.h"
#import <CommonCrypto/CommonDigest.h>

@interface LoginQuery : BaseQuery
{

    NSString *_loginName;
    //NSString *_loginPwd;
    NSObject *_mytarget;
    
    NSString * _showTel;
}

@property(nonatomic, retain)NSString *loginName;
//@property(nonatomic, retain)NSString *loginPwd;
@property(nonatomic, assign) NSObject *mytarget;
@property(nonatomic, assign) NSString *_showTel;

-(void)loginSystem;
-(void)loginQueryDidFinishUpdate:(id)obj;
-(void)loginQueryError:(id)obj;


-(void)checkTel;


@end
