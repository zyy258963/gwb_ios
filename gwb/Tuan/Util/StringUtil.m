//
// StringUtil.m
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "StringUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation StringUtil

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}


+ (NSString *)emptyForNil:(NSString *)str
{
    return str == nil ? @"" : str;
}


+ (NSString *)emptyForNil:(NSString *)str withPrefix:(NSString *)prefix postfix:(NSString *)postfix
{
    NSString *ret = nil;
    if (str == nil || str.length == 0)
    {
        ret = @"";
    }
    else
    {
        ret = [NSString stringWithFormat:@"%@%@%@", prefix, str, postfix];
    }
    
    return ret;
}

+ (NSString *)md5Encode:(NSString *)str
{
    const char *cstr = [str UTF8String];
    unsigned char r[16];
    CC_MD5(cstr, strlen(cstr), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
}

+ (NSString *)dateFormat:(NSDate *)date
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setAMSymbol:@"上午"];
    [formatter setPMSymbol:@"下午"];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [formatter stringFromDate:date];
}

+ (int)countWords:(NSString *)message
{
	int i, n = message.length,l = 0, a = 0, b = 0;
	
	unichar c;
	
	for(i = 0; i < n; i ++){
		
		c=[message characterAtIndex:i];
		
		if(isblank(c)){
			
			b ++;
			
		} else if(isascii(c)) {
			
			a ++;
			
		} else {
			
			l ++;
		}
	}
	
	if(a == 0 && l == 0) return 0;
	
	return l + (int)ceilf((float)(a + b) / 2.0);

}

@end
