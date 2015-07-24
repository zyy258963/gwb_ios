//
//  NSURLRequest+Addition.m
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSURLRequest+Addition.h"
#import "EOAuthConstants.h"
#import "EOHttpParameters.h"
#import "NSURL+Addition.h"
#import "NSString+Addition.h"
@implementation NSURLRequest(EOHttpParameters)
-(EOHttpParameters *) oauthHeaderParameters{
	
	NSString *header = [self valueForHTTPHeaderField:EOAUTH_HTTP_HEADER];
	if (header == nil) {
		return nil;
	}
	NSRange range = [header rangeOfString:@"OAuth "];
	if (range.location == NSNotFound) {
		return nil;
	}
	NSString *substring = [header substringFromIndex:range.location + range.length];
	EOHttpParameters *httpParams = [[[EOHttpParameters alloc] init] autorelease];
	NSArray *params = [substring componentsSeparatedByString:@","];
	for (NSString *pairs in params) {
		NSArray *kv = [pairs componentsSeparatedByString:@"="];
		NSString *key = [[kv objectAtIndex:0] 
						 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		NSString *value = [[kv objectAtIndex:1] 
						 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		value = [value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		[httpParams setObject:value forKey:key];
	}
	return httpParams;
}
-(EOHttpParameters *) queryParameters{
	return [[self URL] queryParameters];
}
-(EOHttpParameters *) bodyParameters{
	NSData * data = [self HTTPBody];
	NSString *dataString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	return [dataString toHttpParameters];
}
@end
