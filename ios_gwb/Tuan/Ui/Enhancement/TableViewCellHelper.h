//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseItem.h"
#import "UIImageViewActive.h"
#import "UILabel+VerticalAlign.h"
#import "DocumentListItem.h"
#import "MuLuItem.h"

@interface TableViewCellHelper : NSObject
{
    NSString *operator;
}

+ (UITableViewCell *)createDocumentListCell:(id)ower view:(UITableView *)view appWithItem:(DocumentListItem *)app;
+ (UITableViewCell *)createMLCell:(id)ower view:(UITableView *)view appWithMLItem:(MuLuItem *)app;
+ (UITableViewCell *)createFirstListCell:(id)ower view:(UITableView *)view appWithTitle:(NSString *)app appWithLine:(int)line;


@end
