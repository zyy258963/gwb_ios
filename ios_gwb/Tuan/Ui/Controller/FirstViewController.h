//
//  LoginViewController.h
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WenJianBtnListQuery.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface FirstViewController : BaseViewController
{
    IBOutlet UITextField *nameText;
    IBOutlet UITableView *myTableView;
    
    NSString *myId;
    NSString *myTitle;
    
    WenJianBtnListQuery *query;
    
    
    NSMutableArray *items;
}
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) IBOutlet UITextField *nameText;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;

- (void)setLoadingUI:(BOOL)isLoading;


@end
