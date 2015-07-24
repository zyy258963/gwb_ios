//
//  LoginViewController.m
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "TuanAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "LoginQuery.h"

@implementation LoginViewController

@synthesize nameText;
@synthesize bgImg;
@synthesize labelTel;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (iPhone5) {
        self.bgImg.frame = CGRectMake(0, 0, 320, 568);
        self.bgImg.image = [UIImage imageNamed:@"loginLogoBig.png"];
    }else{
        self.bgImg.frame = CGRectMake(0, 0, 320, 480);
        self.bgImg.image = [UIImage imageNamed:@"loginLogoSmall.png"];
    }
    
    if (!_logQuery) {
        _logQuery = [[LogQuery alloc] init];
        _logQuery.mytarget = self;
    }
    
//    查询需要现实什么提示语
    
    NSURL *url = [NSURL URLWithString:@"http://www.weebo.com.cn/gwb1/ios/showTel"];
    NSURLRequest *request = [NSURLRequest requestWithURL: url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3.0f];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *stringData =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDict = (NSDictionary *)[stringData JSONValue];
    NSDictionary *content = [jsonDict objectForKey:@"content"];
    NSString *showTel = [content objectForKey:@"showTel"];
    
    if([showTel isEqualToString:@"1"]){
        self.labelTel.text = @"请输入您的手机号码";
        self.nameText.placeholder = @"请输入您的手机号码";
    }else{
        self.labelTel.text = @"请输入您的用户名";
        self.nameText.placeholder = @"请输入您的用户名，首次输入即为注册";
    }
    
	[self addBgBackgroundColor];
    
    [self.navigationController setNavigationBarHidden:YES];

}

- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.nameText == textField) {
        
        self.nameText.returnKeyType = UIReturnKeyDone;
        
    }
    
//    else if (pwdText == textField) {
//        
//        pwdText.returnKeyType = UIReturnKeyDone;
//        
//    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.nameText) {
        
//        [pwdText becomeFirstResponder];
//        
//        return YES;

        [self loginBtn:nil];
        
        return YES;
        
    }else {
        
        return NO;
        
    }
    
}

- (IBAction)loginBtn:(id)sender
{
    
    if (self.nameText.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"用户名不能为空！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else {
        [self setLoadingUI:YES];
        
        query = [[LoginQuery alloc] init];
        query.mytarget = self;
        query.loginName = self.nameText.text;
        [query loginSystem];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆失败，请检查证书！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//        [alertView release];
    }
    
}

-(void)loginQueryDidFinishUpdate:(id)obj{
    
    [self setLoadingUI:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginonotify" object:nil];
    
    if ([self.nameText canResignFirstResponder]) {
		
		[self.nameText resignFirstResponder];
		
	}
    
//    if ([self.pwdText canResignFirstResponder]) {
//		
//		[self.pwdText resignFirstResponder];
//		
//	}
    
    [_logQuery takeTongJi];
    
    TuanAppDelegate *temp = (TuanAppDelegate *)[[UIApplication sharedApplication] delegate];
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [temp.window bringSubviewToFront:temp.loginNavController.view];
    temp.loginNavController.view.frame = CGRectMake(700,0,
                                                            temp.loginNavController.view.frame.size.width,
                                                            temp.loginNavController.view.frame.size.height);
    
    [UIView commitAnimations];

    
    self.nameText.text = @"";
//    self.pwdText.text = @"";
    
}
-(void)loginQueryError:(id)obj{
    
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:obj delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [alert release];
    [self setLoadingUI:NO];
}

- (void)setLoadingUI:(BOOL)isLoading
{
    if (isLoading)
    {
		[self showProgress:YES];
    }
    else
    {
		[self hideProgress:YES];
    }
}

- (void)dealloc {
    [labelTel release];
    [super dealloc];
}

@end
