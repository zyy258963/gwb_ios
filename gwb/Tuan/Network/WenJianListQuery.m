//
//  GetAddvQuery.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "WenJianListQuery.h"
#import "XMLParser.h"
#import "StringUtil.h"
#import "JSON.h"

@implementation WenJianListQuery

@synthesize listItemArray = _listItemArray;
@synthesize mytarget = _mytarget;
@synthesize cId = _cId;
@synthesize keyWord = _keyWord;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _listItemArray = [[NSMutableArray alloc] initWithCapacity:4];
    }
    
    return self;
}

- (void)dealloc
{
    [_listItemArray dealloc];
    [super dealloc];
}

//获取文件一览
- (void)getWenJianList
{
    [self cancelRequest];
    NSString *baseUrl = [NSString stringWithFormat:@"%@", NETWORK_LIST_BOOK];
    NSString *uuid =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:@"DAKA" error:nil];

    NSMutableArray *keys = [NSMutableArray arrayWithObjects:@"categoryid",
                                                            @"tele",
                                                            @"mac",
                                                            @"keyWord",
                                                            nil];
    NSMutableArray *values = [NSMutableArray arrayWithObjects:self.cId,
                                                                [UserManager sharedManager].userID,
                                                                uuid,
                                                                self.keyWord,
                                                                nil];
    NSLog(@" this is a url :%s",baseUrl);
    self.sender= [RequestSender requestSenderWithURL:baseUrl
                                             usePost:1
                                                keys:keys
                                              values:values
                                            delegate:self
                                    completeSelector:@selector(getWenJianListComplete:obj:)
                                       errorSelector:@selector(getWenJianListErrorWithObj:)
                                    selectorArgument:@"网络连接失败"];
    [self.sender send];
    
}

- (void)getWenJianListComplete:(NSData *)data obj:(NSObject *)obj
{
    [self resetSender];
    
    NSString *stringData =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *content = (NSDictionary *)[stringData JSONValue];
    NSDictionary *head = [content objectForKey:@"header"];
    int code = [[head objectForKey:@"code"] intValue];
    NSString *message = [head objectForKey:@"msg"];
    
    if (code == 1)
    {
        [self.listItemArray removeAllObjects];
        
        NSArray *content2 = [content objectForKey:@"content"];
        
        for (int q = 0; q < content2.count; q ++) {
            DocumentListItem *item2 = [[DocumentListItem alloc] init];
            item2.bookId = [[content2 objectAtIndex:q] objectForKey:@"id"];
            item2.bookName = [[content2 objectAtIndex:q] objectForKey:@"name"];
            [_listItemArray addObject:item2];
            [item2 release];
        }
        
        if (_mytarget && [_mytarget respondsToSelector:@selector(getWenJianListComplete:)]) {
            [_mytarget performSelector:@selector(getWenJianListComplete:) withObject:nil];
        }
    }else if (code == 2){
        [UserManager sharedManager].userInfo = NO;
        [UserManager sharedManager].userID = @"";
        [UserManager sharedManager].userName = @"";
        
        
        TuanAppDelegate *temp = (TuanAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [temp.window bringSubviewToFront:temp.loginNavController.view];
        temp.loginNavController.view.frame = CGRectMake(0,
                                                        0,
                                                        temp.loginNavController.view.frame.size.width,
                                                        temp.loginNavController.view.frame.size.height);
        
        [UIView commitAnimations];
        
    }else{
        if (_mytarget && [_mytarget respondsToSelector:@selector(getWenJianListQueryError:)]) {
            [_mytarget performSelector:@selector(getWenJianListQueryError:) withObject:message];
        }
    }
    
    
}

- (void)getWenJianListErrorWithObj:(NSObject *)obj
{
    [self resetSender];
    
    if (_mytarget && [_mytarget respondsToSelector:@selector(getWenJianListQueryError:)]) {
        [_mytarget performSelector:@selector(getWenJianListQueryError:) withObject:@"网络连接失败"];
    }
}



//获取文件一览
- (void)getChapterList
{
    [self cancelRequest];
    NSString *baseUrl = [NSString stringWithFormat:@"%@", NETWORK_LIST_BOOK];
    NSString *uuid =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:@"DAKA" error:nil];
    
    NSMutableArray *keys = [NSMutableArray arrayWithObjects:@"categoryid",
                            @"tele",
                            @"mac",
                            @"keyWord",
                            nil];
    NSMutableArray *values = [NSMutableArray arrayWithObjects:self.cId,
                              [UserManager sharedManager].userID,
                              uuid,
                              self.keyWord,
                              nil];
    NSLog(@" this is a url :%s",baseUrl);
    self.sender= [RequestSender requestSenderWithURL:baseUrl
                                             usePost:1
                                                keys:keys
                                              values:values
                                            delegate:self
                                    completeSelector:@selector(getWenJianListComplete:obj:)
                                       errorSelector:@selector(getWenJianListErrorWithObj:)
                                    selectorArgument:@"网络连接失败"];
    [self.sender send];
    
}

- (void)getChapterListComplete:(NSData *)data obj:(NSObject *)obj
{
    [self resetSender];
    
    NSString *stringData =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *content = (NSDictionary *)[stringData JSONValue];
    NSDictionary *head = [content objectForKey:@"header"];
    int code = [[head objectForKey:@"code"] intValue];
    NSString *message = [head objectForKey:@"msg"];
    
    if (code == 1)
    {
        [self.listItemArray removeAllObjects];
        
        NSArray *content2 = [content objectForKey:@"content"];
        
        for (int q = 0; q < content2.count; q ++) {
            DocumentListItem *item2 = [[DocumentListItem alloc] init];
            item2.bookId = [[content2 objectAtIndex:q] objectForKey:@"id"];
            item2.bookName = [[content2 objectAtIndex:q] objectForKey:@"name"];
//            item2.bookUrl = [[content2 objectAtIndex:q] objectForKey:@"bookUrl"];
            [_listItemArray addObject:item2];
            [item2 release];
        }
        
        if (_mytarget && [_mytarget respondsToSelector:@selector(getWenJianListComplete:)]) {
            [_mytarget performSelector:@selector(getWenJianListComplete:) withObject:nil];
        }
    }else if (code == 2){
        [UserManager sharedManager].userInfo = NO;
        [UserManager sharedManager].userID = @"";
        [UserManager sharedManager].userName = @"";
        
        
        TuanAppDelegate *temp = (TuanAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [temp.window bringSubviewToFront:temp.loginNavController.view];
        temp.loginNavController.view.frame = CGRectMake(0,
                                                        0,
                                                        temp.loginNavController.view.frame.size.width,
                                                        temp.loginNavController.view.frame.size.height);
        
        [UIView commitAnimations];
        
    }else{
        if (_mytarget && [_mytarget respondsToSelector:@selector(getWenJianListQueryError:)]) {
            [_mytarget performSelector:@selector(getWenJianListQueryError:) withObject:message];
        }
    }
    
    
}

- (void)getChapterListErrorWithObj:(NSObject *)obj
{
    [self resetSender];
    
    if (_mytarget && [_mytarget respondsToSelector:@selector(getWenJianListQueryError:)]) {
        [_mytarget performSelector:@selector(getWenJianListQueryError:) withObject:@"网络连接失败"];
    }
}


@end
