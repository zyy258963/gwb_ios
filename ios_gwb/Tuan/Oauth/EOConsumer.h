//
//  EOConsumer.h
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EOSignatureDelegate.h"
#import "EOSignatureStrategy.h"
@class EOToken;
@class EOHttpParameters;

@interface EOConsumer : NSObject {
	id<EOSingatureDelegate, NSObject> delegate_;
	id<EOSignatureStrategy, NSObject> strategy_;
	EOToken *token_;
	
	NSString *key_;
	NSString *secret_; 
	
	EOHttpParameters *additionalParameters_;
}
@property (nonatomic, retain) id<EOSingatureDelegate, NSObject> delegate;//签名方法委托
@property (nonatomic, retain) id<EOSignatureStrategy, NSObject> strategy;//签名策略
@property (nonatomic, retain) EOToken *token;	//access token
@property (nonatomic, readonly) NSString *key;	//app key
@property (nonatomic, readonly) NSString *secret; //app secret
//OAuth中的参数自定义值，不该在此设置非OAuth的参数
//在已获得授权后，不该在此添加oauth_token和oauth_token_secret，口令在self.token
@property (nonatomic, readonly) EOHttpParameters *additionalParameters;

//根据已有的访问口令初始化
-(id) initWithKey:(NSString *) aKey withSecret:(NSString *) aSecret withToken:(EOToken *) aToken;
//根据app key／secret 初始化，但要使用provider获取token
-(id) initWithKey:(NSString *) aKey withSecret:(NSString *) aSecret;
//为request签名
-(NSMutableURLRequest *) signatureForRequest:(NSMutableURLRequest *) req;
//为url签名
-(NSMutableURLRequest *) signatureForURL:(NSURL *) url;

- (void)AddVerifierToParameters:(NSString *)verifier;

@end
