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

@interface LogQuery : BaseQuery
{
    NSObject *_mytarget;
}

@property(nonatomic, assign) NSObject *mytarget;

-(void) takeTongJi;
-(void) takeTongJiDoc:(NSString *) docId;
-(void) takeTongJiSave:(NSString *) docId;
-(void) takeTongJiUnSave:(NSString *) favoutiteId;
-(void)takeTongJiQueryDidFinishUpdate:(NSData *)data obj:(NSObject *)obj;
-(void)takeTongJiQueryError:(id)obj;

@end
