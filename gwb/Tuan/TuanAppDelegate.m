//
//  TuanAppDelegate.m
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import "TuanAppDelegate.h"
#import <sys/utsname.h>
#import "Reachability.h"
#import "MobClick.h"

@implementation TuanAppDelegate

@synthesize window=_window;

@synthesize loginNavController;
@synthesize mainNavController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if (!_logQuery) {
        _logQuery = [[LogQuery alloc] init];
        _logQuery.mytarget = self;
    }
    
    NSLog(@"-----------loginQuery-----m---YES-1111-");
    if ([UserManager sharedManager].userInfo) {
        [_logQuery takeTongJi];
    }
    
    [MobClick startWithAppkey:@"53a0026956240bc94400021b"];
    
    [MobClick checkUpdate];
    
    self.window.rootViewController = self.mainNavController;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //第一次安装，记录硬件信息
    if (![userDefaults boolForKey:@"FIRST_INSTALL"]) {
        [self activeateApp:nil];
    }
    
    //login view
    LoginViewController *tempWanshan = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    self.loginNavController = [[UINavigationController alloc] initWithRootViewController:tempWanshan];
    //如果登陆了
    
    NSLog(@"-----------TuanAppDelegate-----m---YES--");
    if ([UserManager sharedManager].userInfo) {
        self.loginNavController.view.frame = CGRectMake(700,
                                                                0,
                                                                self.loginNavController.view.frame.size.width,
                                                                self.loginNavController.view.frame.size.height);
    }else {
        self.loginNavController.view.frame = CGRectMake(0,
                                                                0,
                                                                self.loginNavController.view.frame.size.width,
                                                                self.loginNavController.view.frame.size.height);
    }

    [self.window addSubview:self.loginNavController.view];
    
    
    [self.window makeKeyAndVisible];
    
	return YES;
}

- (void)activeateApp:(id)obj
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"gwb1.sqlite"];
    [fileManager createFileAtPath:dbPath contents:nil attributes:nil];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        return ;
    }
    
    //我的文档
    [db executeUpdate:@"CREATE TABLE BOOKS (ID         VARCHAR NOT NULL ,\
     NAME           VARCHAR ,\
     URL            VARCHAR ,\
     SHOUCANG       VARCHAR )"];
    
    [db close];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"FIRST_INSTALL"];
    [userDefaults synchronize];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application
{}

- (void)applicationDidEnterBackground:(UIApplication *)application
{}

- (void)applicationWillEnterForeground:(UIApplication *)application
{}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory2 = [paths2 objectAtIndex:0];
    NSString *dbPath2 = [documentDirectory2 stringByAppendingPathComponent:@"gwb1.sqlite"];
    
    FMDatabase *db2 = [FMDatabase databaseWithPath:dbPath2] ;
    if (![db2 open]) {
        return ;
    }
    
    NSString *sql3 = [NSString stringWithFormat:@"select * from BOOKS where SHOUCANG = %@",@"0"];
    FMResultSet *fmSet3 = [db2 executeQuery:sql3];
    while ([fmSet3 next]) {
        
        [fileManager removeItemAtPath:[fmSet3 stringForColumn:@"URL"] error:nil];
        [db2 executeUpdate:@"DELETE FROM BOOKS WHERE ID = ?",[fmSet3 stringForColumn:@"ID"]];
    }
    
    
    [fmSet3 close];
    
    [db2 close];
    
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_window release];
    
    [super dealloc];
}

//ios6禁止屏幕转动
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
