//
//  EOSignatureStrategy.h
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EOConsumer;
@class EOHttpParameters;

//签名策略，签名策略解决在哪里签名的问题，如url上，header里等等
//签名策略在策略委托之后被调用，所有改变内部参数值不会导致签名失败
//但可能导致服务器端签名和本地签名不一样，需要小心
@protocol EOSignatureStrategy

//将signature签到request中
-(void) strategyWithRequest:(NSMutableURLRequest *) request
			  withSignature:(NSString *) signature
			 withParameters:(EOHttpParameters *) parameters
			   withConsumer:(EOConsumer *) consumer;
@end

//将signature签在header中
@interface EOAuthorizationHeaderSignatureStrategy : NSObject<EOSignatureStrategy>{
	
}

@end
//将signature签在url得query里，如果原有signature，将被丢弃
//也许会导致原有的query键值顺序改变
@interface EOQueryStringSignatureStrategy : NSObject<EOSignatureStrategy>{
	
}

@end