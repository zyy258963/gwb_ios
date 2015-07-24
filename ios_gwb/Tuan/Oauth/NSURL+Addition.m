//
//  NSURL+Addition.m
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSURL+Addition.h"
#import "EOHttpParameters.h"
#import "NSString+Addition.h"
@implementation NSURL(HttpParameters)

-(EOHttpParameters *) queryParameters{
	
	NSString *query = [self query];
 
	if (query == nil || [query length] == 0) {
		return nil;
	} 
	return [query toHttpParameters];
}
-(NSString *) urlWithOutQuery{
	NSString *urlString = [self absoluteString];
	NSRange range = [urlString rangeOfString:@"?"];
	if (range.location == NSNotFound) {
		return urlString;
	}
	return [urlString substringToIndex:range.location];
}
@end
