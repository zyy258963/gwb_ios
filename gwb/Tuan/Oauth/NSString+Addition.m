//
//  NSString+Addition.m
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+Addition.h"
#import "EOHttpParameters.h"

@implementation NSString(PercentEscapes)
//-(NSString *) URLEncodePercentEscapes{
//	return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//	
//}
//-(NSString *) URLDecodePercentEscapes{
//	return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}

- (NSString *)URLEncodePercentEscapes 
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes
	(kCFAllocatorDefault,(CFStringRef)self,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),
		kCFStringEncodingUTF8);
    [result autorelease];
	return result;
}

- (NSString*)URLDecodePercentEscapes
{
	NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding
	(kCFAllocatorDefault,(CFStringRef)self,CFSTR(""),kCFStringEncodingUTF8);
    [result autorelease];
	return result;	
}
@end
@implementation NSString(EOHttpParameters) 
-(EOHttpParameters *) toHttpParameters{
	if ([self length] == 0) {
		return nil;
	}
	NSArray *kvs = [self componentsSeparatedByString:@"&"];
	EOHttpParameters *params = [[[EOHttpParameters alloc] init] autorelease];
	for (NSString *pairs in kvs) {
		NSRange range = [pairs rangeOfString:@"="];
		NSString *key = nil;
		NSString *value = nil;
		if (range.location == NSNotFound) {
			key = pairs;
			value = @"";
		}else {
			key = [pairs substringToIndex:range.location];
			value = [pairs substringFromIndex:range.location+range.length];
		}
		key = [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		[params setObject:[value URLDecodePercentEscapes] forKey:[key URLDecodePercentEscapes]];
	}
	return params;
}
@end
