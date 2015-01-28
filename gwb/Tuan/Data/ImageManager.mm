//
//  ImageManager.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "ImageManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "ImageView.h"

@interface ImageRequest : NSObject
{
    NSMutableArray* _views;
    NSString* _url;
    NSString* _fileName;
    NSURLConnection * _connection;
    NSMutableData* _receivedData;
    int _statusCode;
}

@property (nonatomic, readonly) NSString* url;
- (id)initWithURL:(NSString*)url fileName:(NSString*)fileName;

+ (ImageRequest *)imageRequestWithURL:(NSString *)theUrl fileName:(NSString *)fileName;

-(void) addImageView :(ImageView*)view;

@end



@interface ImageManager ()
-(void) removeRequest:(ImageRequest*) request;
@end


@implementation ImageRequest
@synthesize url = _url;


-(void) dealloc
{
    [_views release];
    [_url release];
    [_fileName release];    
    [_receivedData release];
    [_connection release];
    [super dealloc];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(_statusCode < 400)
    {
        //write to file
        [_receivedData writeToFile:_fileName atomically:YES];
        //load image
        UIImage* image = [[UIImage alloc] initWithData:_receivedData];
        if(image)
        {
            //update each view
            for (ImageView* view in _views) 
            {
                if([view.url isEqualToString:_url])
                {
                    view.image = image;
					CGRect rt = CGRectMake(view.center.x - image.size.width / 2, view.center.y - image.size.height / 2, image.size.width, image.size.height);
					if (view.bAdjustFit && rt.size.width / 2 != view.center.x) {
						view.frame = rt;
					}
				}
            }
        }
        
        [image release];
    }
    
    //destroy request
    [[ImageManager sharedManager] removeRequest:self];
    [self release];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* resp = (NSHTTPURLResponse*)response;
    _statusCode = resp.statusCode;
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    // Append the new data to receivedData.
    [_receivedData appendData:data];
    
}


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error

{
    [[ImageManager sharedManager] removeRequest:self];
    [self release];
}


-(id) initWithURL :(NSString*)url fileName:(NSString*)fileName
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    _views = [[NSMutableArray alloc] init];
    _url = [url retain];
    _fileName = [fileName retain];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    _receivedData = [[NSMutableData alloc] init];
    
    [self retain];
    return self;
}


+ (ImageRequest *)imageRequestWithURL:(NSString *)theUrl fileName:(NSString *)fileName
{
    return [[[ImageRequest alloc] initWithURL:theUrl fileName:fileName] autorelease];
}


-(void) addImageView :(ImageView*)view
{
    [_views addObject:view];
}
@end


@implementation ImageManager

static ImageManager* _instance = nil;

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        requests = [[NSMutableDictionary alloc] init];
    }
    return self;
}


+ (ImageManager*) sharedManager
{
    if(!_instance)
    {
        _instance = [[ImageManager alloc] init];
    }
    return _instance;    
}


static NSString* MD5StringOfString(NSString* inputStr)
{
	NSData* inputData = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char outputData[CC_MD5_DIGEST_LENGTH];
	CC_MD5([inputData bytes], [inputData length], outputData);
    
	NSMutableString* hashStr = [NSMutableString string];
	int i = 0;
	for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
		[hashStr appendFormat:@"%02x", outputData[i]];
    
	return hashStr;
}


-(void) removeRequest:(ImageRequest*) request
{
    [requests removeObjectForKey:request.url];
}


- (void) loadImage:(NSString*)url :(ImageView*)imageView
{
    NSString* key = MD5StringOfString(url);
    NSString* fileName = [[NSString alloc] initWithFormat:@"%@/image-%@", NSTemporaryDirectory(), key];
    if([[NSFileManager defaultManager] fileExistsAtPath:fileName])
    {
        UIImage* image = [[UIImage alloc] initWithContentsOfFile:fileName];
        imageView.image = image;
		CGRect rt = CGRectMake(imageView.center.x - image.size.width / 2, imageView.center.y - image.size.height / 2, image.size.width, image.size.height);
		if (imageView.bAdjustFit && rt.size.width / 2 != imageView.center.x) {
			imageView.frame = rt;
		}
		
        [image release];
        return;
    }
    //create image request
    ImageRequest * request = [requests objectForKey:url];
    if(!request)
    {
        request = [ImageRequest imageRequestWithURL:url fileName:fileName];
        [requests setObject:request forKey:url];
    }
	[fileName release];
    [request addImageView:imageView];
}

@end
