//
//  EOSingatureDelegate.m
//  auth
//
//  Created by easy on 11-6-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EOSignatureDelegate.h"
#import "EOConsumer.h"
#import "EOToken.h"
#import "NSString+Addition.h"
#import "EOHttpParameters.h"
#import "NSURL+Addition.h"
#import <CommonCrypto/CommonHMAC.h>
#import "Base64Transcoder.h"
#import "EOAuthConstants.h"

@implementation EOHmacSha1SignatureDelegate
-(NSString *) singatureMethod{
	return @"HMAC-SHA1";
}
-(NSString *) singatureBaseString:(EOHttpParameters *) parameters request:(NSURLRequest *)request{
	NSArray *allkeys = [[parameters allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSMutableArray *keys = [NSMutableArray arrayWithArray:allkeys];
	[keys removeObject:EOAUTH_REALM];
	[keys removeObject:EOAUTH_TOKEN_SECRET];
	int count = [keys count];
	NSMutableString *base = [NSMutableString string];
	for (int i = 0;i < count;i++) {
		NSString *key = [keys objectAtIndex:i];
		NSArray *values = [[parameters objectsForKey:key] 
						   sortedArrayUsingSelector:@selector(compare:)];
		int vcount = [values count];
		for (int j = 0;j < vcount;j++) {
			NSString *value = [values objectAtIndex:j];
			[base appendString:[key URLEncodePercentEscapes]];
			[base appendString:[@"=" URLEncodePercentEscapes]];
			[base appendString:[value URLEncodePercentEscapes]];
			if (i < count - 1 || j < vcount - 1 ) {
				[base appendString:[@"&" URLEncodePercentEscapes]];
			}
		}
	}
	NSString * method = [[request HTTPMethod] URLEncodePercentEscapes];
	NSString * url = [[[request URL] urlWithOutQuery] URLEncodePercentEscapes];
	return [NSString stringWithFormat:@"%@&%@&%@",method,url,base];
}

-(NSString *) sinatureForRequest:(NSMutableURLRequest *) request 
				  withParameters:(EOHttpParameters *) parameters
					withConsumer:(EOConsumer *) consumer{

	NSString *secret = [[consumer.secret URLEncodePercentEscapes] stringByAppendingString:@"&"];
	//if (consumer.token != nil && consumer.token.secret != nil) {
	//		secret = [secret stringByAppendingString:[consumer.token.secret URLEncodePercentEscapes]];
	//	}
	NSString *tokenSecret = [parameters firstObjectForKey:EOAUTH_TOKEN_SECRET];
	if (tokenSecret != nil) {
		secret = [secret stringByAppendingString:[tokenSecret URLEncodePercentEscapes]];
	}
	NSString * base =[self singatureBaseString:parameters request:request];
	
	unsigned char result[20];
	NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
	NSData *baseData = [base dataUsingEncoding:NSUTF8StringEncoding];
	
	CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length],
		   [baseData bytes], [baseData length], result);
	char base64Result[32];
	size_t	resultLength = 32;
	Base64EncodeData(result, 20, base64Result, &resultLength);
	NSData *base64Data = [NSData dataWithBytes:base64Result length:resultLength];
	NSString *rtn = [[[NSString alloc] initWithData:base64Data 
										   encoding:NSUTF8StringEncoding] autorelease];
	
	return rtn;
}

@end
