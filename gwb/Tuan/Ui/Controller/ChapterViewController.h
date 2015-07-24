//
//  LoginViewController.h
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ChapterListItem.h"
#import "ChapterListQuery.h"
#import "Reachability.h"
#import "SearchListQuery.h"
#import "FourthViewController.h"
#import "FMDatabase.h"
#import "LogQuery.h"

@interface ChapterViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    IBOutlet UILabel *titleLab;
    
    IBOutlet UITableView *oneTableView;
    
    ChapterListQuery *query;
    
    NSMutableArray *items;
    
    NSString *myBookId;
    NSString *myBookName;
    
    ChapterListItem *downloadTemp;
    
    SearchListQuery *searchQuery;
    
    LogQuery *_logQuery;
    
}
@property (nonatomic, retain) IBOutlet UILabel *titleLab;

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) IBOutlet UITableView *oneTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withBookId:(NSString* )itemId withBookName:(NSString* )itemName ;
- (void)setLoadingUI:(BOOL)isLoading;

@end
