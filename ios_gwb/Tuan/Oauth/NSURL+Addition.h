//
//  NSURL+Addition.h
//  auth
//
//  Created by easy on 11-6-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EOHttpParameters;

@interface NSURL(HttpParameters) 
-(EOHttpParameters *) queryParameters;
-(NSString *) urlWithOutQuery;
@end
