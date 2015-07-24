//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "TableViewCellHelper.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "StringHTMLCategory.h"
#import "CustomImageView.h"
#import "UIImageView+WebCache.h"
#import "BaseItem.h"
#import "StringUtil.h"
#import "ConfigManager.h"

@implementation TableViewCellHelper

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

//文件列表
+ (UITableViewCell *)createDocumentListCell:(id)ower view:(UITableView *)view appWithItem:(DocumentListItem *)app
{
	
	static NSString *pListCellIdentifier = @"ThirdListCellIdentifier";
    
    UITableViewCell *cell = [view dequeueReusableCellWithIdentifier:pListCellIdentifier];
    if (cell == nil)
    {
        NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"ThirdListCell" owner:ower options:nil];
        cell = [nibTableCells objectAtIndex:0];
        
        // set selected color
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:(226.0 / 255)
                                                        green:(226.0 / 255)
                                                         blue:(226.0 / 255)
                                                        alpha:1.0]];
        [cell setBackgroundView:bgColorView];
        [bgColorView release];
        
        // set selected color
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
		
    }
	
    //标题
    UILabel *title = (UILabel *)[cell viewWithTag:101];
    title.text = app.bookName;
    
    return cell;
	
}

+ (UITableViewCell *)createMLCell:(id)ower view:(UITableView *)view appWithMLItem:(MuLuItem *)app {

    static NSString *pListCellIdentifier = @"MuLuCellIdentifier";
    
    UITableViewCell *cell = [view dequeueReusableCellWithIdentifier:pListCellIdentifier];
    if (cell == nil)
    {
        NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"MuLuCell" owner:ower options:nil];
        cell = [nibTableCells objectAtIndex:0];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
		
    }
	
    //标题
    UILabel *title = (UILabel *)[cell viewWithTag:101];
    title.text = app.muluName;
    
    return cell;
    
}

+ (UITableViewCell *)createFirstListCell:(id)ower view:(UITableView *)view appWithTitle:(NSString *)app appWithLine:(int)line
{
	
	static NSString *AppListCellIdentifier = @"FirstListCellIdentifier";
    
    UITableViewCell *cell = [view dequeueReusableCellWithIdentifier:AppListCellIdentifier];
    if (cell == nil)
    {
        NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"FirstListCell" owner:ower options:nil];
        cell = [nibTableCells objectAtIndex:0];
        
        // set selected color
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:(246.0 / 255)
                                                        green:(247.0 / 255)
                                                         blue:(241.0 / 255)
                                                        alpha:1.0]];
        [cell setBackgroundView:bgColorView];
        [bgColorView release];
        
        // set selected color
        UIImageView *selectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CouponNearBySelect.png"]];
        [cell setSelectedBackgroundView:selectImageView];
        [selectImageView release];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
		
    }
    
    UIButton *gotoMain1 =  [[UIButton alloc]initWithFrame:CGRectMake(3, 3, 314, 47)];
    gotoMain1.titleLabel.font = [UIFont boldSystemFontOfSize: 25.0];
    [gotoMain1 setTitle:app forState:UIControlStateNormal];
    [gotoMain1 setTitle:app forState:UIControlStateSelected];
    [gotoMain1 setBackgroundImage:[UIImage imageNamed:@"btnBig.png"] forState:UIControlStateNormal];
    [gotoMain1 setBackgroundImage:[UIImage imageNamed:@"btnBigSel.png"] forState:UIControlStateHighlighted];
    [gotoMain1.layer setCornerRadius:10.0];
    gotoMain1.tag = line+110;
    [cell addSubview:gotoMain1];
    [gotoMain1 addTarget:ower action:@selector(gotoPush:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
	
}


@end
