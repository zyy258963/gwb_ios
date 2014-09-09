//
//  EOToken.h
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//认证口令
@interface EOToken : NSObject {
	NSString *key_;
	NSString *secret_;
}
//键
@property (nonatomic, readonly) NSString *key;
//密钥
@property (nonatomic, readonly) NSString *secret;

-(id) initWithKey:(NSString *) aKey withSecret:(NSString *) aSecret;
@end
