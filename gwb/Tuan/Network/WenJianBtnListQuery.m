//
//  GetAddvQuery.m
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "WenJianBtnListQuery.h"
#import "XMLParser.h"
#import "StringUtil.h"
#import "JSON.h"

@implementation WenJianBtnListQuery

@synthesize listItemArray = _listItemArray;
@synthesize mytarget = _mytarget;

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

//获取文件夹按钮一览
- (void)getWenJianBtnList
{
    [self cancelRequest];
    NSString *baseUrl = [NSString stringWithFormat:@"%@", NETWORK_LIST_CATEGORY];
    
    NSString *uuid =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:@"DAKA" error:nil];

    NSMutableArray *keys = [NSMutableArray arrayWithObjects:@"tele",
                                                            @"mac",
                                                            nil];
    
    
    NSMutableArray *values = [NSMutableArray arrayWithObjects:[UserManager sharedManager].userID,
                                                                uuid,
                                                                nil];
    
    self.sender= [RequestSender requestSenderWithURL:baseUrl
                                             usePost:1
                                                keys:keys
                                              values:values
                                            delegate:self
                                    completeSelector:@selector(getWenJianBtnListComplete:obj:)
                                       errorSelector:@selector(getWenJianBtnListErrorWithObj:)
                                    selectorArgument:@"网络连接失败"];
    [self.sender send];
    
}

- (void)getWenJianBtnListComplete:(NSData *)data obj:(NSObject *)obj
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
            CategoryItem *item2 = [[CategoryItem alloc] init];
            item2.categoryId = [[content2 objectAtIndex:q] objectForKey:@"id"];
            item2.categoryName = [[content2 objectAtIndex:q] objectForKey:@"name"];
            [_listItemArray addObject:item2];
            [item2 release];
        }
        
        CategoryItem *item2 = [[CategoryItem alloc] init];
        item2.categoryId = @"0";
        item2.categoryName = @"我的常用文档";
        [_listItemArray addObject:item2];
        [item2 release];
        
        
        if (_mytarget && [_mytarget respondsToSelector:@selector(getWenJianBtnListComplete:)]) {
            [_mytarget performSelector:@selector(getWenJianBtnListComplete:) withObject:nil];
        }
    }else{

        [UserManager sharedManager].userInfo = NO;
        [UserManager sharedManager].userID = @"";
        [UserManager sharedManager].userName = @"";
        
        
        TuanAppDelegate *temp = (TuanAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [temp.window bringSubviewToFront:temp.loginNavController.view];
        temp.loginNavController.view.frame = CGRectMake(0,0,temp.loginNavController.view.frame.size.width,
                                                               temp.loginNavController.view.frame.size.height);
        
        [UIView commitAnimations];
        
    }

//    }else if (code == 2){
//        [UserManager sharedManager].userInfo = NO;
//        [UserManager sharedManager].userID = @"";
//        [UserManager sharedManager].userName = @"";
//        
//        
//        TuanAppDelegate *temp = (TuanAppDelegate *)[[UIApplication sharedApplication] delegate];
//        
//        [UIView beginAnimations:@"ToggleViews" context:nil];
//        [UIView setAnimationDuration:0.3f];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [temp.window bringSubviewToFront:temp.loginNavController.view];
//        temp.loginNavController.view.frame = CGRectMake(0,0,temp.loginNavController.view.frame.size.width,
//                                                        temp.loginNavController.view.frame.size.height);
//        
//        [UIView commitAnimations];
//        
//    }else{
//        if (_mytarget && [_mytarget respondsToSelector:@selector(getWenJianBtnListQueryError:)]) {
//            [_mytarget performSelector:@selector(getWenJianBtnListQueryError:) withObject:message];
//        }
//    }

}

- (void)getWenJianBtnListErrorWithObj:(NSObject *)obj
{
    [self resetSender];
    
    if (_mytarget && [_mytarget respondsToSelector:@selector(getWenJianBtnListQueryError:)]) {
        [_mytarget performSelector:@selector(getWenJianBtnListQueryError:) withObject:@"网络连接失败"];
    }
}

@end
