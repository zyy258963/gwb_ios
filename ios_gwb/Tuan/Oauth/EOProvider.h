//
//  EOProvider.h
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EOConsumer;
@class EOProvider;

@protocol EOProviderListener
@optional
//请求前(签名前)的设置，可以在此设置如 http method
-(void) beforeRequest:(NSURLRequest *) req 
		 withProvider:(EOProvider *)provider
		 withConsumer:(EOConsumer *) consumer;
//请求成功的设置（请求成功不代表认证成功）
//判断请求成功可以判断consumer.token或consumer.additionParameters EOAUTH_TOKEN 值
//判断请求的url可以分辨当前是request token 还是 access token
//但在判断时只判断url out query部分，因为query的可能被改变
-(void) successForRequest:(NSURLRequest *) req
				 response:(NSURLResponse *) rsp
			 responseData:(NSData *) data
			 withProvider:(EOProvider *) provider
			 withConsumer:(EOConsumer *) consumer;
//请求失败，可能时连接失败，也可能是服务器端返回错误码
-(void) failedForRequest:(NSURLRequest *) req
				response:(NSURLResponse *) rsp
				   error:(NSError *) error
			withProvider:(EOProvider *)provider
			withConsumer:(EOConsumer *) consumer;
@end

//Provider 为 Consumer 获取认证
//Provider 获取认证时，可能在consumer中设置一些参数，一般获取认证后，
//最好重新使用认证创建新的 consumer
//provider本身也使用listener做请求成功或失败的相关设置
@interface EOProvider : NSObject<EOProviderListener> {
	NSURL *accessTokenURL_;
	NSURL *authorizationURL_;
	NSURL *requestTokenURL_;
	NSMutableDictionary *listeners_;
	
	NSURLConnection *connection;
	NSTimer         *_timeOutTimer;
	NSMutableData   *_receivedData;
	NSString        *_quryUrl;   
	EOConsumer      *_consumer;  // weak ref
}

@property (nonatomic, readonly) NSURL *accessTokenURL;	//访问口令url
@property (nonatomic, readonly) NSURL *authorizationURL;//认证url
@property (nonatomic, readonly) NSURL *requestTokenURL;//请求口令url


-(id) initWithRequestTokenURL:(NSURL *) aRequestTokenURL
			 authorizationURL:(NSURL*) aAuthorizationURL
			   accessTokenURL:(NSURL *) aAccessTokenURL;

-(id) initWithRequestToken:(NSString *) aRequestTokenURL
			 authorization:(NSString *) aAuthorizationURL
			   accessToken:(NSString *) aAccessTokenURL;


//请求认证url，返回前会请求token，如果请求失败，返回nil
-(NSURL *) retrieveAuthorizeURLWithConsumer:(EOConsumer *) consumer 
					   withCallback:(NSString *)callback;
//请求访问口令，如果成功，consumer得token即可用,所以可以用consumer.token判断是否成功
-(void) retrieveAccessTokenWithConsumer:(EOConsumer *)consumer 
						   withVerifier:(NSString *)verifier;

- (NSURL *)getAuthorizeUrl:(EOConsumer *) consumer withCallback:(NSString *)callback;

- (void)resetTimerAndConnection;

@end

@interface EOProvider(EOProviderListener)
//根据key增加listener
-(void) addListener:(id<EOProviderListener>) listener forKey:(NSString *)key;
//根据key移除listener
-(void) removeListener:(NSString *) key;
//清空所有listener(一般用不了，Provider自身就做为lisenter监听，除非希望完全自定义)
-(void) clearListeners;
//在请求前调用，（默认所有的listener）
-(void) beforeRequest:(NSURLRequest *) req consumer:(EOConsumer *) consumer;
//在请求成功调用，（默认所有的listener）
-(void) successForRequest:(NSURLRequest *) req
				 response:(NSURLResponse *) rsp
			 responseData:(NSData *) data
				 consumer:(EOConsumer *) consumer;
//在请求失败调用，（默认所有的listener）
-(void) failedForRequest:(NSURLRequest *) req
				response:(NSURLResponse *) rsp
				   error:(NSError *) error
				consumer:(EOConsumer *) consumer;
@end
