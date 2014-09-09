//
//  EOSignatureStrategy.m
//  auth
//
//  Created by easy on 11-6-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EOSignatureStrategy.h"
#import "EOAuthConstants.h"
#import "EOHttpParameters.h"
#import "NSString+Addition.h"
#import "NSURL+Addition.h"
@implementation EOAuthorizationHeaderSignatureStrategy 	
-(void) appendString:(NSMutableString *) string
			 withKey:(NSString *) key
	  withParameters:(EOHttpParameters *) parameters split:(BOOL) split{
	if ([parameters containsKey:key]) {
		[string appendString:[parameters headerElementForKey:key]];
		if (split) {
			[string appendString:@", "];
		}
	}
}
-(void) strategyWithRequest:(NSMutableURLRequest *) request
			  withSignature:(NSString *) signature
			 withParameters:(EOHttpParameters *) parameters
			   withConsumer:(EOConsumer *) consumer{
	
	NSMutableString *header = [NSMutableString stringWithString:@"OAuth "];
	[self appendString:header withKey:EOAUTH_REALM withParameters:parameters split:YES];
	
	[self appendString:header withKey:EOAUTH_CALLBACK withParameters:parameters split:YES];
	[self appendString:header withKey:EOAUTH_CONSUMER_KEY withParameters:parameters split:YES];
	[self appendString:header withKey:EOAUTH_NONCE withParameters:parameters split:YES];
	[header appendFormat:@"%@=\"%@\", ",EOAUTH_SIGNATURE,[signature URLEncodePercentEscapes]];
	[self appendString:header withKey:EOAUTH_SIGNATURE_METHOD withParameters:parameters split:YES];
	[self appendString:header withKey:EOAUTH_TIMESTAMP withParameters:parameters split:YES];
	[self appendString:header withKey:EOAUTH_TOKEN withParameters:parameters split:YES];
	[self appendString:header withKey:EOAUTH_VERIFIER withParameters:parameters split:YES];
	[self appendString:header withKey:EOAUTH_VERSION withParameters:parameters split:NO];
	
	[request setValue:header forHTTPHeaderField:EOAUTH_HTTP_HEADER];
}
@end

@implementation EOQueryStringSignatureStrategy 
-(void) appendString:(NSMutableString *) string
			 withKey:(NSString *) key
	  withParameters:(EOHttpParameters *) parameters 
  withQueryParamters:(EOHttpParameters *) querys
			   split:(BOOL) split{
	if ([parameters containsKey:key] && (querys == nil || ![querys containsKey:key])) {
		[string appendString:[parameters queryForKey:key]];
		if (split) {
			[string appendString:@"&"];
		}
	}
}
-(void) strategyWithRequest:(NSMutableURLRequest *) request
			  withSignature:(NSString *) signature
			 withParameters:(EOHttpParameters *) parameters
			   withConsumer:(EOConsumer *) consumer{
	NSURL *url = [request URL];
	EOHttpParameters *queryParams = [url queryParameters];
	if ([queryParams containsKey:EOAUTH_SIGNATURE]) {
		[queryParams removeObjectsForKey:EOAUTH_SIGNATURE];
	}
	
	NSMutableString *query = [NSMutableString string];
	if (queryParams != nil && ![queryParams isEmpty]) {
		[query appendString:[queryParams query]];
		[query appendString:@"&"];
	}
	[self appendString:query withKey:EOAUTH_CALLBACK withParameters:parameters 
	withQueryParamters:queryParams split:YES];
	[self appendString:query withKey:EOAUTH_CONSUMER_KEY withParameters:parameters 
	withQueryParamters:queryParams split:YES];
	[self appendString:query withKey:EOAUTH_NONCE withParameters:parameters 
	withQueryParamters:queryParams split:YES];
	[query appendFormat:@"%@=%@&",EOAUTH_SIGNATURE,[signature URLEncodePercentEscapes]];
	[self appendString:query withKey:EOAUTH_SIGNATURE_METHOD withParameters:parameters 
	withQueryParamters:queryParams split:YES];
	[self appendString:query withKey:EOAUTH_TIMESTAMP withParameters:parameters 
	withQueryParamters:queryParams split:YES];
	[self appendString:query withKey:EOAUTH_TOKEN withParameters:parameters 
	withQueryParamters:queryParams split:YES];
	[self appendString:query withKey:EOAUTH_VERIFIER withParameters:parameters 
	withQueryParamters:queryParams split:YES];
	[self appendString:query withKey:EOAUTH_VERSION withParameters:parameters 
	withQueryParamters:queryParams split:NO];
	NSString *urlString = [NSString stringWithFormat:@"%@?%@",[url urlWithOutQuery],query];
	
	NSURL *newURL = [NSURL URLWithString:urlString];
	[request setURL:newURL];
}
@end
