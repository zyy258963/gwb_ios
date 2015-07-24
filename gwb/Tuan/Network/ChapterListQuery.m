//
//  GetAddvQuery.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChapterListQuery.h"
#import "XMLParser.h"
#import "StringUtil.h"
#import "JSON.h"

@implementation ChapterListQuery

@synthesize listItemArray = _listItemArray;
@synthesize mytarget = _mytarget;
@synthesize bookId = _bookId;

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
- (void)getChapterList
{
    [self cancelRequest];
    NSString *baseUrl = [NSString stringWithFormat:@"%@", NETWORK_LIST_CHAPTER];
    NSString *uuid =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:@"DAKA" error:nil];
    
    NSMutableArray *keys = [NSMutableArray arrayWithObjects:@"bookid",
                            @"tele",
                            @"mac",
                            nil];
    NSMutableArray *values = [NSMutableArray arrayWithObjects:self.bookId,
                              [UserManager sharedManager].userID,
                              uuid,
                              nil];
    NSLog(@" this is a url :%s",baseUrl);
    self.sender= [RequestSender requestSenderWithURL:baseUrl
                                             usePost:1
                                                keys:keys
                                              values:values
                                            delegate:self
                                    completeSelector:@selector(getChapterListComplete:obj:)
                                       errorSelector:@selector(getChapterListErrorWithObj:)
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
            ChapterListItem *item2 = [[ChapterListItem alloc] init];
            item2.chapterId = [[content2 objectAtIndex:q] objectForKey:@"id"];
            item2.bookId = [[content2 objectAtIndex:q] objectForKey:@"bookId"];
            item2.chapterName = [[content2 objectAtIndex:q] objectForKey:@"name"];
            item2.chapterUrl = [[content2 objectAtIndex:q] objectForKey:@"fpath"];
            item2.chapterNum = [[content2 objectAtIndex:q] objectForKey:@"num"];
            [_listItemArray addObject:item2];
            [item2 release];
        }
        
        if (_mytarget && [_mytarget respondsToSelector:@selector(getChapterListComplete:)]) {
            [_mytarget performSelector:@selector(getChapterListComplete:) withObject:nil];
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
        if (_mytarget && [_mytarget respondsToSelector:@selector(getChapterListQueryError:)]) {
            [_mytarget performSelector:@selector(getChapterListQueryError:) withObject:message];
        }
    }
    
    
}

- (void)getChapterListErrorWithObj:(NSObject *)obj
{
    [self resetSender];
    
    if (_mytarget && [_mytarget respondsToSelector:@selector(getChapterListQueryError:)]) {
        [_mytarget performSelector:@selector(getChapterListQueryError:) withObject:@"网络连接失败"];
    }
}



@end
