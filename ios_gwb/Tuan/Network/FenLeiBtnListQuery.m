//
//  GetAddvQuery.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FenLeiBtnListQuery.h"
#import "XMLParser.h"
#import "StringUtil.h"
#import "JSON.h"

@implementation FenLeiBtnListQuery

@synthesize listItemArray = _listItemArray;
@synthesize mytarget = _mytarget;
@synthesize cId = _cId;

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

//获取分类按钮一览
- (void)getFenLeiBtnList
{
    [self cancelRequest];
    NSString *baseUrl = [NSString stringWithFormat:@"%@", NETWORK];
    NSString *uuid =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:@"DAKA" error:nil];

    NSMutableArray *keys = [NSMutableArray arrayWithObjects:@"type",
                                                            @"categoryId",
                                                            @"telephone",
                                                            @"macAddress",
                                                            nil];
    NSMutableArray *values = [NSMutableArray arrayWithObjects:@"listClass",
                                                                self.cId,
                                                                [UserManager sharedManager].userID,
                                                                uuid,
                                                                nil];
    
    self.sender= [RequestSender requestSenderWithURL:baseUrl
                                             usePost:1
                                                keys:keys
                                              values:values
                                            delegate:self
                                    completeSelector:@selector(getFenLeiBtnListComplete:obj:)
                                       errorSelector:@selector(getFenLeiBtnListErrorWithObj:)
                                    selectorArgument:@"网络连接失败"];
    [self.sender send];
    
}

- (void)getFenLeiBtnListComplete:(NSData *)data obj:(NSObject *)obj
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
            SubCategoryItem *item2 = [[SubCategoryItem alloc] init];
            item2.classId = [[content2 objectAtIndex:q] objectForKey:@"classId"];
            item2.categoryId = [[content2 objectAtIndex:q] objectForKey:@"categoryId"];
            item2.className = [[content2 objectAtIndex:q] objectForKey:@"className"];
            [_listItemArray addObject:item2];
            [item2 release];
        }
        
        if (_mytarget && [_mytarget respondsToSelector:@selector(getFenLeiBtnListComplete:)]) {
            [_mytarget performSelector:@selector(getFenLeiBtnListComplete:) withObject:nil];
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
        if (_mytarget && [_mytarget respondsToSelector:@selector(getFenLeiBtnListQueryError:)]) {
            [_mytarget performSelector:@selector(getFenLeiBtnListQueryError:) withObject:message];
        }
    }
    
}

- (void)getFenLeiBtnListErrorWithObj:(NSObject *)obj
{
    [self resetSender];
    
    if (_mytarget && [_mytarget respondsToSelector:@selector(getFenLeiBtnListQueryError:)]) {
        [_mytarget performSelector:@selector(getFenLeiBtnListQueryError:) withObject:@"网络连接失败"];
    }
}

@end
