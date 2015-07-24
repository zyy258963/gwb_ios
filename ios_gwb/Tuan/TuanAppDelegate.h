//
//  TuanAppDelegate.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#import "CustomUITabBarController.h"
#import "Reachability.h"
#import "FMDatabase.h"
#import "LoginViewController.h"
#import "UserManager.h"
#import "LogQuery.h"

@interface TuanAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate,UIAlertViewDelegate,UITabBarControllerDelegate>
{
    IBOutlet UINavigationController *mainNavController;
    IBOutlet UINavigationController *loginNavController;
    
    LogQuery *_logQuery;
}
@property (nonatomic, retain) IBOutlet UINavigationController *mainNavController;
@property (nonatomic, retain) IBOutlet UINavigationController *loginNavController;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
