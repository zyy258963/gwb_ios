//
//  LoginViewController.h
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LoginQuery.h"
#import "LogQuery.h"

@interface LoginViewController : BaseViewController
{
    IBOutlet UITextField *nameText;
    IBOutlet UIImageView *bgImg;
    
    IBOutlet UILabel *labelTel;
    
    LoginQuery *query;
    LogQuery *_logQuery;
}

@property (nonatomic, retain) IBOutlet UITextField *nameText;
@property (nonatomic, retain) IBOutlet UIImageView *bgImg;
@property (nonatomic, retain) IBOutlet UILabel *labelTel;

- (void)setLoadingUI:(BOOL)isLoading;


@end
