//
//  NSString+Addition.h
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EOHttpParameters;

@interface NSString(PercentEscapes) 
//url 编码
-(NSString *) URLEncodePercentEscapes;
//url 解码
-(NSString *) URLDecodePercentEscapes;

@end

@interface NSString(EOHttpParameters) 
//转换成Parameters，参数会被url解码
-(EOHttpParameters *) toHttpParameters;
@end
