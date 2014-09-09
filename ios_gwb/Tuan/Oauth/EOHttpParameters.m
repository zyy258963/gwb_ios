//
//  EOHttpParameters.m
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EOHttpParameters.h"
#import "NSString+Addition.h"

@implementation EOHttpParameters
-(id) init{
	if (self = [super init]) {
		parameters_ = [[NSMutableDictionary dictionary] retain];
	}
	return self;
}
-(void) setObjects:(NSArray *) values forKey:(NSString *)key{
	if (key != nil && values != nil && [values count] > 0) {
		NSMutableSet *vs = [parameters_ objectForKey:key];
		if (vs == nil) {
			vs = [NSMutableSet setWithCapacity:[values count]];
		}
		[vs addObjectsFromArray:values];
		[parameters_ setObject:vs forKey:key];
	}
}
-(void) setObject:(NSString *) value forKey:(NSString *) key{
	
	if (value != nil && key != nil) {
		NSArray *values = [NSArray arrayWithObject:value];
		[self setObjects:values forKey:key];
	}
}
-(void) setParameters:(EOHttpParameters *) parameters{
	if (parameters != nil && ![parameters isEmpty]) {
 
		NSArray *keys = [parameters allKeys];
		for (NSString *key in keys) {//copy parameters to self
			NSArray *values = [parameters objectsForKey:key];
			if (values != nil) {
				[self setObjects:values forKey:key];
			}
		}
	}
}
-(void) setKeyValuePairs:(NSDictionary *) pairs{
	if (pairs != nil && [pairs count] > 0) {
		NSArray *keys = [pairs allKeys];
		for (NSString *key in keys) {
			NSString *value = [pairs objectForKey:key];
			if (value != nil) {
				[self setObject:value forKey:key];
			}
		}
	}
}
-(NSString *) firstObjectForKey:(NSString *) key{
	NSArray *objects = [self objectsForKey:key];
	return objects != nil && [objects count] > 0 ? [objects objectAtIndex:0] : nil;
}
-(NSArray *) objectsForKey:(NSString *) key{
	NSSet *values = [parameters_ objectForKey:key];
	return values != nil ? [values allObjects] : nil;
}
-(NSString *) queryForKey:(NSString *) key{
	NSArray *values = [self objectsForKey:key];
	if (values == nil || [values count] == 0) {
		return [key stringByAppendingString:@"="];
	}
	int count = [values count];
	NSMutableString *query = [NSMutableString string];
	for (int i = 0; i < count; i++) {
		NSString *value = [values objectAtIndex:i];
		[query appendString:[key URLEncodePercentEscapes]];
		[query appendString:@"="];
		[query appendString:[value URLEncodePercentEscapes]];
		if (i < count - 1) {
			[query appendString:@"&"];
		}
	}
	return query;
}
-(NSString *) queryForKey:(NSString *) key comparator:(SEL) comparator{
	NSArray *values = [[self objectsForKey:key] sortedArrayUsingSelector:comparator];
	if (values == nil || [values count] == 0) {
		return [key stringByAppendingString:@"="];
	}
	int count = [values count];
	NSMutableString *query = [NSMutableString string];
	for (int i = 0; i < count; i++) {
		NSString *value = [values objectAtIndex:i];
		[query appendString:[key URLEncodePercentEscapes]];
		[query appendString:@"="];
		[query appendString:[value URLEncodePercentEscapes]];
		if (i < count - 1) {
			[query appendString:@"&"];
		}
	}
	return query;
}
-(NSString *) headerElementForKey:(NSString *) key{
	NSString *value = [self firstObjectForKey:key];
	return value != nil ? 
	[NSString stringWithFormat:@"%@=\"%@\"",[key URLEncodePercentEscapes]
		,[value URLEncodePercentEscapes]] : nil;
}
-(NSString *) headerElements{
	NSArray *keys = [self allKeys];
	NSUInteger i, count = [keys count];
	NSMutableString *headers = [NSMutableString string];
	for (i = 0; i < count; i++) {
		NSString *key = [keys objectAtIndex:i];
		[headers appendString:[self headerElementForKey:key]];
		if (i < count - 1) {
			[headers appendString:@" "];
		}
	}
	return headers;
}
-(NSString *) headerElementsUsingComparator:(SEL) comparator{
	NSArray *keys = [[self allKeys] sortedArrayUsingSelector:comparator];
	NSUInteger i, count = [keys count];
	NSMutableString *headers = [NSMutableString string];
	for (i = 0; i < count; i++) {
		NSString *key = [keys objectAtIndex:i];
		[headers appendString:[self headerElementForKey:key]];
		if (i < count - 1) {
			[headers appendString:@" "];
		}
	}
	return headers;
}

-(BOOL) containsKey:(NSString *)key{
	return [parameters_ objectForKey:key] != nil;
}
-(NSUInteger) keyCount{
	return [parameters_ count];
}
-(NSUInteger) valueConut{
	int count = 0;
	NSArray *keys = [self allKeys];
	for (NSString *key in keys) {
		NSArray *values = [self objectsForKey:key];
		count += [values count];
	}
	return count;
}
-(BOOL) isEmpty{
	return [self keyCount] == 0;
}
-(void) removeAllObjects{
	 [parameters_ removeAllObjects];
}
-(void) removeObjectsForKey:(NSString *) key{
	 [parameters_ removeObjectForKey:key];
}
-(NSArray *) allKeys{
	return [parameters_ allKeys];
}

-(void) dealloc{
	[parameters_ release];
	[super dealloc];
}
-(NSString *) query{
	NSArray *keys = [self allKeys];
	NSMutableString *descript = [NSMutableString string];
	NSUInteger i, count = [keys count];
	for (i = 0; i < count; i++) {
		NSString *key = [keys objectAtIndex:i];
		[descript appendString:[self queryForKey:key]];
		if (i < count - 1) {
			[descript appendString:@"&"];
		}
	}
	return descript;
}

@end
