//
//  EOProvider.m
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EOProvider.h"
#import "EOConsumer.h"
#import "EOToken.h"
#import "NSURL+Addition.h"
#import "NSString+Addition.h"
#import "EOAuthConstants.h"
#import "EOHttpParameters.h"
@implementation EOProvider
@synthesize accessTokenURL = accessTokenURL_;
@synthesize authorizationURL = authorizationURL_;
@synthesize requestTokenURL = requestTokenURL_;

-(id) initWithRequestTokenURL:(NSURL *) aRequestTokenURL
			 authorizationURL:(NSURL *) aAuthorizationURL
			   accessTokenURL:(NSURL *) aAccessTokenURL{
	if (aRequestTokenURL == nil || aAuthorizationURL == nil ||
		aAccessTokenURL == nil) {
		return nil;
	}
	if (self = [super init]) {
		requestTokenURL_ = [aRequestTokenURL retain];
		authorizationURL_ = [aAuthorizationURL retain];
		accessTokenURL_ = [aAccessTokenURL retain];
		[self addListener:self forKey:@"base listener for provider"];
	}
	return self;
}

-(id) initWithRequestToken:(NSString *) aRequestTokenURL
			 authorization:(NSString *) aAuthorizationURL
			   accessToken:(NSString *) aAccessTokenURL{
	NSURL *requrl = [NSURL URLWithString:aRequestTokenURL];
	NSURL *auturl = [NSURL URLWithString:aAuthorizationURL];
	NSURL *accurl = [NSURL URLWithString:aAccessTokenURL];
	if (self = [self initWithRequestTokenURL:requrl
							authorizationURL:auturl 
							  accessTokenURL:accurl]) {
	}
	return self;
}

-(void)retrieveTokenForURL:(NSURL *)url consumer:(EOConsumer *)consumer{
	 
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
													   timeoutInterval:20];
	
	[self beforeRequest:request consumer:consumer];
	NSURLRequest *req = [consumer signatureForRequest:request];
	
	connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	
	if (connection) {
		_receivedData = [[NSMutableData data] retain];
		
		_quryUrl = [[[req URL] urlWithOutQuery] retain];
		//自定义时间超时
		_timeOutTimer = [NSTimer scheduledTimerWithTimeInterval:20.0f target: self selector: @selector(handleTimeOut) userInfo:nil repeats:NO];
	} else {
		
		_timeOutTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target: self selector: @selector(handleTimeOut) userInfo:nil repeats:NO];
	}
}

-(NSURL *)retrieveAuthorizeURLWithConsumer:(EOConsumer *) consumer 
							   withCallback:(NSString *)callback{
	consumer.token = nil;
	[consumer.additionalParameters setObject:callback forKey:EOAUTH_CALLBACK];
	[consumer.additionalParameters removeObjectsForKey:EOAUTH_TOKEN];
	[consumer.additionalParameters removeObjectsForKey:EOAUTH_TOKEN_SECRET];
	_consumer = consumer;
	[self retrieveTokenForURL:self.requestTokenURL consumer:consumer];
	
	return  nil;
}

- (void)handleTimeOut {

	_timeOutTimer = nil;
	[self connection:connection didFailWithError:nil];
}

- (NSURL *)getAuthorizeUrl:(EOConsumer *)consumer withCallback:(NSString *)callback{

	NSString *token = [consumer.additionalParameters firstObjectForKey:EOAUTH_TOKEN];
	if (token == nil) {	//使用token判断是否请求成功
		return nil;
	}
	NSString *url = [self.authorizationURL absoluteString];
	NSRange r = [url rangeOfString:@"?"];
	NSMutableString *newurl = [NSMutableString stringWithString:url];
	if (r.location == NSNotFound) {
		[newurl appendString:@"?"];
	}else {
		[newurl appendString:@"&"];
	}
	[newurl appendFormat:@"%@=%@",EOAUTH_TOKEN,token];
	if (callback != nil) {
		[newurl appendFormat:@"&%@=%@",EOAUTH_CALLBACK,callback];
	}
	return [NSURL URLWithString:newurl];
}

-(void) retrieveAccessTokenWithConsumer:(EOConsumer *)consumer 
						   withVerifier:(NSString *)verifier{

	[consumer.additionalParameters setObject:verifier forKey:EOAUTH_VERIFIER];
	[self retrieveTokenForURL:self.accessTokenURL  consumer:consumer];
	//[consumer.additionalParameters removeObjectsForKey:EOAUTH_VERIFIER];
}

-(void) successForRequest:(NSURLRequest *) req
				 response:(NSURLResponse *) rsp
			 responseData:(NSData *) data
			 withProvider:(EOProvider *) provider
			 withConsumer:(EOConsumer *) consumer{
	if (data == nil) {
		return;
	}
	
	NSString *dataString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	EOHttpParameters *params = [dataString toHttpParameters];
	NSString *token = [params firstObjectForKey:EOAUTH_TOKEN];
	NSString *secret = [params firstObjectForKey:EOAUTH_TOKEN_SECRET];

	//防止url被签，只判断url out query 
	if ([_quryUrl isEqualToString:[self.requestTokenURL urlWithOutQuery]]) {
		// is request token
		if (token != nil && secret != nil) {
			[consumer.additionalParameters setObject:token forKey:EOAUTH_TOKEN];
			[consumer.additionalParameters setObject:secret forKey:EOAUTH_TOKEN_SECRET];
		}
	}
	if ([_quryUrl isEqualToString:[self.accessTokenURL urlWithOutQuery]]) {
		//access success
		if (token != nil && secret != nil) {
			[consumer.additionalParameters removeObjectsForKey:EOAUTH_TOKEN];
			[consumer.additionalParameters removeObjectsForKey:EOAUTH_TOKEN_SECRET];
			[consumer.additionalParameters removeObjectsForKey:EOAUTH_VERIFIER];
			EOToken *t = [[EOToken alloc] initWithKey:token withSecret:secret];
			consumer.token = t;
		}
	}
 
}

- (void)resetTimerAndConnection {
    
	[connection release];
	connection = nil;
	if (_timeOutTimer) {
		[_timeOutTimer invalidate];
		_timeOutTimer = nil;
	}
	
	[_receivedData release];
	_receivedData = nil;
	[_quryUrl release];
	_quryUrl = nil;
}

-(void) dealloc{
	[requestTokenURL_ release];
	[accessTokenURL_ release];
	[authorizationURL_ release];
	[listeners_ release];
	
    [self resetTimerAndConnection];
	[super dealloc];
}

@end


@implementation EOProvider(EOProviderListener)

-(void) addListener:(id<EOProviderListener>) listener forKey:(NSString *)key{
	if (listeners_ == nil) {
		listeners_ = [[NSMutableDictionary dictionary] retain];
	}
	[listeners_ setObject:listener forKey:key];
}
-(void) removeListener:(NSString *) key{
	if (listeners_ != nil) {
		[listeners_ removeObjectForKey:key];
	}
}
-(void) clearListeners{
	if (listeners_ != nil) {
		[listeners_ removeAllObjects];
	}
}

-(void) beforeRequest:(NSURLRequest *) req consumer:(EOConsumer *)consumer{
	if (listeners_ != nil && [listeners_ count] > 0) {
        NSArray *keys = [[listeners_ allKeys] sortedArrayUsingSelector:@selector(compare:)];
        int count = keys.count;
        for (int i = 0; i < count; i++) {
            
            id<EOProviderListener, NSObject> listener = [listeners_ valueForKey:[keys objectAtIndex:i]];
            if ([listener respondsToSelector:@selector(beforeRequest:withProvider:withConsumer:)]) {
				[listener beforeRequest:req withProvider:self withConsumer:consumer];
			} 
        }
	}
}
-(void) successForRequest:(NSURLRequest *) req
				 response:(NSURLResponse *) rsp
			 responseData:(NSData *) data
				 consumer:(EOConsumer *)consumer{
	if (listeners_ != nil && [listeners_ count] > 0) {
        NSArray *keys = [[listeners_ allKeys] sortedArrayUsingSelector:@selector(compare:)];
        int count = keys.count;
        for (int i = 0; i < count; i++) {
            
            id<EOProviderListener, NSObject> listener = [listeners_ valueForKey:[keys objectAtIndex:i]];
			if ([listener respondsToSelector:
					@selector(successForRequest:response:
							  responseData:withProvider:withConsumer:)]) {
				[listener successForRequest:req response:rsp 
							   responseData:data withProvider:self withConsumer:consumer];
			} 
        }
	}
}
-(void) failedForRequest:(NSURLRequest *) req
				response:(NSURLResponse *) rsp
				   error:(NSError *) error
			consumer:(EOConsumer *)consumer{
	if (listeners_ != nil && [listeners_ count] > 0) {
        
        NSArray *keys = [[listeners_ allKeys] sortedArrayUsingSelector:@selector(compare:)];
        int count = keys.count;
        for (int i = 0; i < count; i++) {
            
            id<EOProviderListener, NSObject> listener = [listeners_ valueForKey:[keys objectAtIndex:i]];
			if ([listener respondsToSelector:
				 @selector(failedForRequest:response:error:withProvider:withConsumer:)]) {
				[listener failedForRequest:req response:rsp
									 error:error withProvider:self withConsumer:consumer];
			} 
        }
	}
}

#pragma mark -
#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	
     //do nothing
	return;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
	[_receivedData appendData:data];
	return;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

	
	[self successForRequest:nil response:nil responseData:_receivedData  consumer:_consumer];

	[self resetTimerAndConnection];
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
    [self failedForRequest:nil response:nil error:error consumer:_consumer];

	[self resetTimerAndConnection];
}

@end
