//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "PhoneNumberFormatter.h"

@implementation PhoneNumberFormatter

@synthesize tempStr;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString *) stringFromPhoneNumber:(NSString *)aNumber 
{
    NSString *localeString = [[NSLocale currentLocale] localeIdentifier];

    if([localeString compare:@"en_US"] == NSOrderedSame) 
    {
        if( [aNumber rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet] ].location==NSNotFound )
        {
            if (aNumber.length > 3) 
            {
                if( ![[aNumber substringToIndex:3] isEqualToString:@"+86"])
                {
                    aNumber = [aNumber stringByReplacingOccurrencesOfString:@" (" withString:@""];
                    aNumber = [aNumber stringByReplacingOccurrencesOfString:@") " withString:@""];
                    self.tempStr = [aNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
                }
                else
                {
                    aNumber = [aNumber stringByReplacingOccurrencesOfString:@"+86 " withString:@""];
                    self.tempStr = [aNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
                }
            }
            
        }
    }
    else
    {
        if( [aNumber rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet] ].location==NSNotFound )
        {
            if (aNumber.length > 3) 
            {
                if( ![[aNumber substringToIndex:3] isEqualToString:@"+86"])
                {
                    self.tempStr = [aNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
                }
                else
                {
                    aNumber = [aNumber stringByReplacingOccurrencesOfString:@"+86 " withString:@""];
                    self.tempStr = [aNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
                }
            }            
            
        }
    }
    
    if ([[self.tempStr substringToIndex:5] isEqualToString:@"17951"]) 
    {
        self.tempStr = [self.tempStr stringByReplacingOccurrencesOfString:@"17951" withString:@""];
    }
    else if ([[self.tempStr substringToIndex:5] isEqualToString:@"17911"])
    {
        self.tempStr = [self.tempStr stringByReplacingOccurrencesOfString:@"17911" withString:@""];
    }
    else if ([[self.tempStr substringToIndex:5] isEqualToString:@"12593"])
    {
        self.tempStr = [self.tempStr stringByReplacingOccurrencesOfString:@"12593" withString:@""];
    }
    else if ([[self.tempStr substringToIndex:5] isEqualToString:@"17909"])
    {
        self.tempStr = [self.tempStr stringByReplacingOccurrencesOfString:@"17909" withString:@""];
    }
    
    return self.tempStr;
}

- (void)dealloc
{
    [tempStr release];
    [super dealloc];
}

@end
