//	http://kaeppler.github.com/signpost/signpost-core-apidocs/oauth/signpost/http/HttpParameters.html
//  EOHttpParameters.h
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EOHttpParameters : NSObject {
	NSMutableDictionary *parameters_;
} 

/*为键设置一组值，相同值会被丢弃(NSSet)*/
-(void) setObjects:(NSArray *) values forKey:(NSString *)key;
/*为键设置添加一个值,注意：无法设置null值，如果需要设置@“”或@“null”*/
-(void) setObject:(NSString *) value forKey:(NSString *) key;
/*添加Parameters里的键值*/
-(void) setParameters:(EOHttpParameters *) parameters;
/*添加dictionary里的键值*/
-(void) setKeyValuePairs:(NSDictionary *) pairs;
/*返回key对应的第一个值*/
-(NSString *) firstObjectForKey:(NSString *) key;
/*返回key对应的一组值*/
-(NSArray *) objectsForKey:(NSString *) key;
/*将本参数集全部组成query*/
-(NSString *) query;
/*将key对应的值组成query*/
-(NSString *) queryForKey:(NSString *) key;
/*将key对应的值排序并组成query*/
-(NSString *) queryForKey:(NSString *) key comparator:(SEL) comparator;
/*将header对应的值组header*/
-(NSString *) headerElementForKey:(NSString *) key;
/*将所有的值组成header*/
-(NSString *) headerElements;
/*将所有的值排序并组成header*/
-(NSString *) headerElementsUsingComparator:(SEL) comparator;
/*是否存在key*/
-(BOOL) containsKey:(NSString *)key;
/*key数*/
-(NSUInteger) keyCount;
/*value数*/
-(NSUInteger) valueConut;
/*是否为空*/
-(BOOL) isEmpty;
/*清空所有对象*/
-(void) removeAllObjects;
/*将移除key对应的所有值*/
-(void) removeObjectsForKey:(NSString *) key;
/*所有key键*/
-(NSArray *) allKeys;

@end
