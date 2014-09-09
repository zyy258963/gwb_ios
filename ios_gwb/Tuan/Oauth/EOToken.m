//
//  EOToken.m
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EOToken.h"

@implementation EOToken
@synthesize key = key_;
@synthesize secret = secret_;
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

-(id) copyWithZone: (NSZone *) zone {

	EOToken *token = [[EOToken allocWithZone: zone] init];
	
	[token initWithKey:key_ withSecret:secret_];
	return token;
}

-(void) dealloc{
	[key_ release];
	[secret_ release];
	[super dealloc];
}

@end
