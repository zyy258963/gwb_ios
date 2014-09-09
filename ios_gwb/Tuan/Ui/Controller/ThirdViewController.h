//
//  LoginViewController.h
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DocumentListItem.h"
#import "WenJianListQuery.h"
#import "Reachability.h"
#import "SearchListQuery.h"
#import "FourthViewController.h"
#import "FMDatabase.h"

@interface ThirdViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    IBOutlet UILabel *titleLab;

    IBOutlet UITableView *oneTableView;
        
    WenJianListQuery *query;
    
    NSMutableArray *items;
    
    NSString *myClassId;
    NSString *myClassName;
    NSString *myKeyWord;
    
    DocumentListItem *downloadTemp;
    
    SearchListQuery *searchQuery;
        
}
@property (nonatomic, retain) IBOutlet UILabel *titleLab;

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) IBOutlet UITableView *oneTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDocId:(NSString* )itemId withDocName:(NSString* )itemName withKeyWord:(NSString* )itemKey;
- (void)setLoadingUI:(BOOL)isLoading;

@end
