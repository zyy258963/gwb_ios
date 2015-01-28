//
//  LoginViewController.h
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FenLeiBtnListQuery.h"
#import "SubCategoryItem.h"
#import "ThirdViewController.h"

@interface SecondViewController : BaseViewController
{
    IBOutlet UITextField *nameText;
    
    IBOutlet UILabel *titleLab;
    
    IBOutlet UIScrollView *bgScrView;
    
    NSString *myId;
    NSString *myTitle;
    
    FenLeiBtnListQuery *query;
    
    NSMutableArray *items;
}
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) IBOutlet UITextField *nameText;

@property (nonatomic, retain) IBOutlet UILabel *titleLab;

@property (nonatomic, retain) IBOutlet UIScrollView *bgScrView;

- (void)setLoadingUI:(BOOL)isLoading;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withWJId:(NSString* )itemId withWJName:(NSString* )itemName;


@end
