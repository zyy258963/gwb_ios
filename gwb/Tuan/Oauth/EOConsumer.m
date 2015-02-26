//
//  EOConsumer.m
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EOConsumer.h"
#import "EOToken.h"
#import "EOHttpParameters.h"
#import "NSURLRequest+Addition.h"
#import "EOAuthConstants.h"
 
@implementation EOConsumer
@synthesize delegate = delegate_;
@synthesize strategy = strategy_;
@synthesize token = token_;
@synthesize key = key_;
@synthesize secret = secret_;
@synthesize additionalParameters  = additionalParameters_;

-(id) initWithKey:(NSString *) aKey withSecret:(NSString *) aSecret withToken:(EOToken *) aToken{
	if (aKey == nil || aSecret == nil) {
		return nil;
	}
	if (aToken == nil || aToken.key == nil || aToken.secret == nil) {
		return [self initWithKey:aKey withSecret:aSecret];
	}
	if (self = [super init]) {
		key_ = [aKey copy];
		secret_ = [aSecret copy];
		self.token = aToken;
	}
	return self;
}

-(id) initWithKey:(NSString *) aKey withSecret:(NSString *) aSecret{
	if (aKey == nil || aSecret == nil) {
		return nil;
	}
	if (self = [super init]) {
		key_ = [aKey copy];
		secret_ = [aSecret copy];
	}
	return self;
}
-(NSString *) generateTimestamp{
	return [NSString stringWithFormat:@"%ld",time(NULL)];
}
-(NSString *) generateNonce{
	return [NSString stringWithFormat:@"%d",arc4random()%1000000+1000000];
}
-(void) completeOAuthParameters:(EOHttpParameters *) params{
	

	if (![params containsKey:EOAUTH_CONSUMER_KEY]) {
		[params setObject:self.key forKey:EOAUTH_CONSUMER_KEY];
	}

	if (![params containsKey:EOAUTH_SIGNATURE_METHOD]) {
		[params setObject:[self.delegate singatureMethod] forKey:EOAUTH_SIGNATURE_METHOD];
	}
	if (![params containsKey:EOAUTH_TIMESTAMP]) {
		[params setObject:[self generateTimestamp] forKey:EOAUTH_TIMESTAMP];
	}
	if (![params containsKey:EOAUTH_NONCE]) {
		[params setObject:[self generateNonce] forKey:EOAUTH_NONCE];
	}
	if (![params containsKey:EOAUTH_VERSION]) {
		[params setObject:@"1.0" forKey:EOAUTH_VERSION];
	}
	if (![params containsKey:EOAUTH_TOKEN] && self.token != nil && self.token.key != nil) {
		[params setObject:self.token.key forKey:EOAUTH_TOKEN];
	}
	// 这里将限制不能出现eoauth_token_secret 参数
	if (![params containsKey:EOAUTH_TOKEN_SECRET] && self.token != nil && self.token.secret != nil) {
		[params setObject:self.token.secret forKey:EOAUTH_TOKEN_SECRET];
	}
	 
	if ([params containsKey:EOAUTH_SIGNATURE]) {
		[params removeObjectsForKey:EOAUTH_SIGNATURE];//remove
	}
}
-(NSMutableURLRequest *) signatureForRequest:(NSMutableURLRequest *) req{
	if (self.key == nil || self.secret == nil || self.delegate == nil || self.strategy == nil) {
		return req;
	}
	EOHttpParameters *params = [[[EOHttpParameters alloc] init] autorelease];
 
	[params setParameters:self.additionalParameters];
 
	EOHttpParameters *headerParams = [req oauthHeaderParameters];
	[params setParameters:headerParams];
	EOHttpParameters *queryParams = [req queryParameters];
	[params setParameters:queryParams];
	EOHttpParameters *bodyParams = [req bodyParameters];
	[params setParameters:bodyParams];
	
	// oauth
	[self completeOAuthParameters:params];
	 

	NSString *signature = [self.delegate sinatureForRequest:req 
											 withParameters:params 
											   withConsumer:self];
	
	[self.strategy strategyWithRequest:req withSignature:signature
						withParameters:params withConsumer:self];
	return req;
}
-(NSMutableURLRequest *) signatureForURL:(NSURL *) url{
	
	return [self signatureForRequest:[NSMutableURLRequest requestWithURL:url]];
}

-(id <EOSingatureDelegate>) delegate{
	if (delegate_ == nil) {
		delegate_ = [[EOHmacSha1SignatureDelegate alloc] init];
	}
	return delegate_;
}
-(id <EOSignatureStrategy> ) strategy{
	if (strategy_ == nil) {
		strategy_ = [[EOAuthorizationHeaderSignatureStrategy alloc] init];
	}
	return strategy_;
}

- (void)AddVerifierToParameters:(NSString *)verifier {
//	
//	if (![params containsKey:EOAUTH_VERIFIER]) {
//		[params setObject:verifier forKey:EOAUTH_VERIFIER];
//	}
}

-(EOHttpParameters *) additionalParameters{
	if (additionalParameters_ == nil) {
		additionalParameters_ = [[EOHttpParameters alloc] init];
	}
	return additionalParameters_;
}

- (void) dealloc{
	[delegate_ release];
	[strategy_ release];
	[token_ release];
	[key_ release];
	[secret_ release];
	[additionalParameters_ release];
	[super dealloc];
}

@end
