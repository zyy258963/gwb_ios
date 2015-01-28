//
//  NSURLRequest+Addition.h
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EOHttpParameters;

@interface NSURLRequest(EOHttpParameters)
//request中oauth的参数集
-(EOHttpParameters *) oauthHeaderParameters;
//request中query的参数集
-(EOHttpParameters *) queryParameters;
//request中body的参数集
-(EOHttpParameters *) bodyParameters;
@end
