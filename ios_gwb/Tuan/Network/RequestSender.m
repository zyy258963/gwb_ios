//
//  RequestSender.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "RequestSender.h"

static const float TIME_OUT_INTERVAL = 30.0f;
static NSString *UPLOADPIC_FORM_BOUNDARY = @"0194784892923";

@implementation RequestSender

@synthesize url;
@synthesize usePost;
@synthesize keys;
@synthesize values;
@synthesize delegate;
@synthesize completeSelector;
@synthesize errorSelector;
@synthesize selectorArgument;
@synthesize useGZip;


+ (id)requestSenderWithURL:(NSString *)theUrl
                   usePost:(int)isPost
                      keys:(NSArray *)theKeys 
                    values:(NSArray *)theValues 
                  delegate:(id)theDelegate 
          completeSelector:(SEL)theCompleteSelector 
             errorSelector:(SEL)theErrorSelector
          selectorArgument:(id)theSelectorArgument
{
    RequestSender *requestSender = [[[RequestSender alloc] init] autorelease];
    requestSender.url = theUrl;
    requestSender.usePost = isPost;
    requestSender.keys = theKeys;
    requestSender.values = theValues;
    requestSender.delegate = theDelegate;
    requestSender.completeSelector = theCompleteSelector;
    requestSender.errorSelector = theErrorSelector;
    requestSender.selectorArgument = theSelectorArgument;
    
    return requestSender;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.url = nil;
        self.usePost = 1;
        self.useGZip = YES;
        self.keys = nil;
        self.values = nil;
        self.delegate = nil;
        self.completeSelector = nil;
        self.errorSelector = nil;
        self.selectorArgument = nil;
        
        _data = [[NSMutableData alloc] initWithLength:0];
    }
    
    return self;
}


- (void)dealloc
{
    [_data release];
    [values release];
    [keys release];
    [selectorArgument release];
    [url release];
    
    [super dealloc];
}


- (void)send
{
    
    NSMutableString *completeUrl = [[NSMutableString alloc] initWithString:self.url];
    
//    BOOL firstValue = YES;
    int parameterNum = [keys count] < [values count] ? [keys count] : [values count];
    NSMutableString *queryStr = [[NSMutableString alloc] init];
    
    if (usePost == 3)
    {
        [queryStr appendString:@"{\""];
    }
    
    for (int i = 0; i < parameterNum; ++i)
    {
        
        if (self.usePost == 1 || self.usePost == 4)
        {
            if (i == 0) {
                [queryStr appendString:@"?"];
            }else {
                [queryStr appendString:@"&"];
            }
            
        }
        else if (self.usePost == 3)
        {
            if (i != 0) {
                [queryStr appendString:@"\",\""];
            }
        }
        else if (self.usePost == 2)
        {
            if (i != 0) {
                [queryStr appendString:@"&"];
            }
        }
        
        NSString *key = [keys objectAtIndex:i];
        NSString *value = [values objectAtIndex:i];

        NSString *encodedValue = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                     (CFStringRef)value, 
                                                                                     NULL,
                                                                                     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                     kCFStringEncodingUTF8);
        NSLog(encodedValue);
        
        if (usePost == 2 || usePost == 3) {
            //[queryStr appendFormat:@"%@\":\"%@", key, encodedValue];
            [queryStr appendFormat:@"%@=%@", key, encodedValue];
        }else {
            [queryStr appendFormat:@"%@=%@", key, encodedValue];
        }
        [encodedValue release];
    }
    
    if (usePost == 1 || usePost == 4)
    {
        [completeUrl appendString:queryStr];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:completeUrl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:TIME_OUT_INTERVAL];

    
    if (usePost == 2)
    {
        [request setHTTPMethod:@"POST"];
//        [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
//        [request setValue:@"application/json" forHTTPHeaderField: @"Accept"];
        //[request setValue:@"application-json" forHTTPHeaderField: @"Accept"];
        NSData *data = [queryStr dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    
    if (usePost == 3)
    {
        [request setHTTPMethod:@"PUT"];
        [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField: @"Accept"];
        //[request setValue:@"application-json" forHTTPHeaderField: @"Accept"];
        
        NSData *data = [queryStr dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        
    }
    
//    if (useGZip)
//    {
//        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//    }

    if (usePost == 1)
    {
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField: @"Accept"];
        //[request setValue:@"application-json" forHTTPHeaderField: @"Accept"];
    }
    
    if (usePost == 4)
    {
        [request setHTTPMethod:@"DELETE"];
        [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField: @"Accept"];
        //[request setValue:@"application-json" forHTTPHeaderField: @"Accept"];
    }
    
    NSLog(@"BODY JSON: %@", queryStr);
    NSLog(@"Request URL: %@", completeUrl);
    
    [queryStr release];
    [completeUrl release];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (!_connection)
    {
        [self connection:nil didFailWithError:nil];
    }
}

- (void)sendFormData:(NSDictionary*)params icon:(UIImage *)icon iconName:(NSString*)iconName requrl:(NSURL*)requrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];                                    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", UPLOADPIC_FORM_BOUNDARY];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
//    NSString *name = [params objectForKey:@"fileName"];
//    [request setValue:name forHTTPHeaderField: @"X-FileName"];
    
    // post body
    NSMutableData *body = [NSMutableData data];

    // add image data
    NSData *contentData = UIImageJPEGRepresentation(icon, 1.0);
    // add image data
    if (contentData) {
        [body appendData:contentData];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", UPLOADPIC_FORM_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set URL
    [request setURL:requrl];
    
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (!_connection)
    {
        [self connection:nil didFailWithError:nil];
    }
    
    [request release];
}

- (NSData *)syncSendRequest:(NSError *)err respone:(NSURLResponse *)respone
{
    NSMutableString *completeUrl = [[NSMutableString alloc] initWithString:self.url];
    
    BOOL firstValue = YES;
    int parameterNum = [keys count] < [values count] ? [keys count] : [values count];
    NSMutableString *queryStr = [[NSMutableString alloc] init];
    for (int i = 0; i < parameterNum; ++i)
    {
        if (firstValue && (self.usePost == 1 || self.usePost == 4))
        {
            [queryStr appendString:@"?"];
            firstValue = NO;
        }
        else
        {
            [queryStr appendString:@"&"];
        }
        
        NSString *key = [keys objectAtIndex:i];
        NSString *value = [values objectAtIndex:i];
        NSString *encodedValue = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                     (CFStringRef)value, 
                                                                                     NULL,
                                                                                     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                     kCFStringEncodingUTF8);
        [queryStr appendFormat:@"%@=%@", key, encodedValue];
        [encodedValue release];
    }
    
    if (self.usePost == 1 || self.usePost == 4)
    {
        [completeUrl appendString:queryStr];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:completeUrl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:TIME_OUT_INTERVAL];
    if (usePost == 2)
    {
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[queryStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (usePost == 3)
    {
        [request setHTTPMethod:@"PUT"];
        [request setHTTPBody:[queryStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (useGZip)
    {
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    }
    
    [queryStr release];
    [completeUrl release];
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&respone error:&err];
}


- (void)resetConnection {
	
	if (_connection) {
		[_connection cancel];
		[_connection release];
		_connection = nil;
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode / 100 == 4 || httpResponse.statusCode / 100 == 5)  // http error
        {
            [connection cancel];
            [self connection:connection didFailWithError:nil];   // treat as error
        }
    }
    [_data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{    
    if (self.selectorArgument == nil)
    {
        [self.delegate performSelector:self.errorSelector];
    }
    else 
    {
        [self.delegate performSelector:self.errorSelector withObject:self.selectorArgument];
    }

    [_data setLength:0];
    [self resetConnection];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (self.selectorArgument == nil)
    {
        [self.delegate performSelector:self.completeSelector withObject:_data];
    }
    else 
    {
        [self.delegate performSelector:self.completeSelector withObject:_data withObject:self.selectorArgument];
    }

    [_data setLength:0];
    
    [self resetConnection];

}


@end
