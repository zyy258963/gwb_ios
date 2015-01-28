//
//  EOSingatureDelegate.h
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EOConsumer;
@class EOHttpParameters;
//签名委托，签名委托解决如何签名的问题，它提供签名的方法
@protocol EOSingatureDelegate
@required
//签名的方法名,签名时不应该签 EOAUTH_REALM,EOAUTH_TOKEN_SECRET
-(NSString *) singatureMethod;
//签名，签名可能改变各参数内部值
-(NSString *) sinatureForRequest:(NSMutableURLRequest *) request 
				  withParameters:(EOHttpParameters *) parameters
					withConsumer:(EOConsumer *) consumer;

@end

// HmacSha1 签名，默认方式
@interface EOHmacSha1SignatureDelegate : NSObject<EOSingatureDelegate>{
	
}
@end