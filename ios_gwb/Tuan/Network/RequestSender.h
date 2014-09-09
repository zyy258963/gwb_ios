//
//  RequestSender.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestSender : NSObject 
{
    NSString *url;
    NSArray *keys;
    NSArray *values;
    id deletage;
    id selectorArgument;
    SEL completeSelector;
    SEL errorSelector;
    int usePost;    //1:get   2:post   3:put    4:delete
    BOOL useGZip;
    
    NSMutableData *_data;
    
    NSURLConnection *_connection;
    NSTimer         *_timeOutTimer;
}

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, retain) NSArray *values;
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) id selectorArgument;
@property (nonatomic) SEL completeSelector;
@property (nonatomic) SEL errorSelector;
@property (nonatomic) int usePost;
@property (nonatomic) BOOL useGZip;


+ (id)requestSenderWithURL:(NSString *)theUrl
                   usePost:(int)isPost
                      keys:(NSArray *)theKeys 
                    values:(NSArray *)theValues 
                  delegate:(id)theDelegate 
          completeSelector:(SEL)theCompleteSelector 
             errorSelector:(SEL)theErrorSelector
          selectorArgument:(id)theSelectorArgument;

- (void)send;

- (void)sendFormData:(NSDictionary*)params icon:(UIImage *)icon iconName:(NSString*)iconName requrl:(NSURL*)requrl;

- (NSData *)syncSendRequest:(NSError *)err respone:(NSURLResponse *)respone;

- (void)resetConnection;

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end
