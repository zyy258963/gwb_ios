//
//  LoginViewController.m
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FourthViewController.h"
#import "TuanAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ReaderDocument.h"
#import "ReaderViewController.h"

@implementation FourthViewController

@synthesize totalPro;
@synthesize currentPro;
@synthesize progressBarView;
@synthesize shouCangBtn;
@synthesize titleLab;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withUrl:(NSString *)itemUrl withId:(NSString *)itemId withTitle:(NSString *)itemTitle{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        myUrl = [NSString stringWithFormat:@"%@%@",@"http://117.79.84.185:8080/FileUpload/upload/books/",itemUrl];
        myId = itemId;
        [myId retain];
        myTitle = itemTitle;
        [myId retain];
        [myTitle retain];
        [myUrl retain];
        
        [ConfigManager sharedManager].cangId = myId;
    }
    return self;
}

- (IBAction)leftBtnPressed:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateListMy" object:nil];

    if (isDownloadComplete == NO) {
        //暂停
        ASIHTTPRequest *request = [[queue operations] objectAtIndex:0];
        //取消请求
        [request clearDelegatesAndCancel];
        [queue cancelAllOperations];
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)downpage:(NSNotification *)notification {

    [self leftBtnPressed:nil];
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downpage:)
                                                 name:@"downpage"
                                               object:nil];
    
    self.titleLab.text = myTitle;
    [self.navigationController setNavigationBarHidden:YES];
    
    isDownloadComplete = NO;
    
	[self addBgBackgroundColor];
    
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory2 = [paths2 objectAtIndex:0];
    NSString *dbPath2 = [documentDirectory2 stringByAppendingPathComponent:@"GWB.sqlite"];
    
    FMDatabase *db2 = [FMDatabase databaseWithPath:dbPath2] ;
    if (![db2 open]) {
        return ;
    }
    
    shouCangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shouCangBtn.frame = CGRectMake(220, 20, 44, 44);
    shouCangBtn.hidden = YES;
    
    //创建队列
    queue = [[ASINetworkQueue alloc] init];
    //高精度进度
    [queue setShowAccurateProgress:YES];
    //启动
    [queue go];
    
    [ConfigManager sharedManager].cangId = myId;
    
    NSString *sql2 = [NSString stringWithFormat:@"select * from BOOKS where ID = %@", myId];
    FMResultSet *fmSet2 = [db2 executeQuery:sql2];
    if ([fmSet2 next]) {
        pdfview = [[PDFView alloc] initWithFrame:CGRectMake(0, 0, 320, 504) andFileName:myId];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *docPath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.pdf",myId]];

        self.totalPro.hidden = YES;
        self.currentPro.hidden = YES;
        self.progressBarView.hidden = YES;
        
        if ([[fmSet2 stringForColumn:@"SHOUCANG"] isEqualToString:@"0"]) {
            //没收藏
            isShouCang = NO;
            [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCangSel.png"] forState:UIControlStateNormal];
            [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCang.png"] forState:UIControlStateSelected];
        }else {
            //已经收藏了
            isShouCang = YES;
            [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCang.png"] forState:UIControlStateNormal];
            [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCangSel.png"] forState:UIControlStateSelected];
        }
        
        [shouCangBtn addTarget:self action:@selector(shouCangBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shouCangBtn];
        
        [fmSet2 close];
        
        [db2 close];
        
        shouCangBtn.hidden = NO;
        
        isDownloadComplete = YES;
        
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:docPath password:nil];
        
        if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
        {
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            
            readerViewController.delegate = self; // Set the ReaderViewController delegate to self
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentViewController:readerViewController animated:NO completion:nil];
            
        }
        
    }else {
        
        isShouCang = NO;
        [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCangSel.png"] forState:UIControlStateNormal];
        [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCang.png"] forState:UIControlStateSelected];
        
        //保存
        NSString *cacheDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        downloadPath = [NSString stringWithFormat:@"%@/%@.pdf",cacheDirectoryPath,myId];
        NSURL *url = [NSURL URLWithString:myUrl];
        //创建请求
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setTimeOutSeconds:120];
        request.delegate = self;
        [request setDownloadDestinationPath:downloadPath];
        [request setAllowResumeForFileDownloads:NO];//断点续传
        request.downloadProgressDelegate = self;//下载进度代理
        [queue addOperation:request];//添加到队列，队列启动后不需重新启动
        
        [shouCangBtn addTarget:self action:@selector(shouCangBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shouCangBtn];
        
        [fmSet2 close];
        
        [db2 close];
        
    }
    
}

//收到头信息
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    if (fileLength == 0) {
        fileLength = [[request.responseHeaders valueForKey:@"Content-Length"] floatValue]/1024.0/1024.0;
        totalPro.text = [NSString stringWithFormat:@"%.2fMB",fileLength];
    }
}

//设置进度条
- (void)setProgress:(float)newProgress
{
    progressBarView.progress = newProgress;
    currentPro.text = [NSString stringWithFormat:@"%.2fMB",fileLength*newProgress];
}

//开始下载
- (void)requestStarted:(ASIHTTPRequest *)request
{
}

//下载成功
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [request clearDelegatesAndCancel];
    [queue cancelAllOperations];
    
    isDownloadComplete = YES;

    pdfview = [[PDFView alloc] initWithFrame:CGRectMake(0, 0, 320, 504) andFileName:myId];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *docPath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.pdf",myId]];
    
    //写入本地数据库
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory2 = [paths2 objectAtIndex:0];
    NSString *dbPath2 = [documentDirectory2 stringByAppendingPathComponent:@"GWB.sqlite"];
    
    FMDatabase *db2 = [FMDatabase databaseWithPath:dbPath2] ;
    if (![db2 open]) {
        return ;
    }
    
    [db2 executeUpdate:@"INSERT INTO BOOKS (ID, NAME, URL, SHOUCANG) VALUES (?,?,?,?)",myId,myTitle,docPath,@"0"];
    
    self.totalPro.hidden = YES;
    self.currentPro.hidden = YES;
    self.progressBarView.hidden = YES;
    
    shouCangBtn.hidden = NO;
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:docPath password:nil];
    
    if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:readerViewController animated:NO completion:nil];
    }
    
}

- (IBAction)shouCangBtn:(id)sender {
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory2 = [paths2 objectAtIndex:0];
    NSString *dbPath2 = [documentDirectory2 stringByAppendingPathComponent:@"GWB.sqlite"];
    
    FMDatabase *db2 = [FMDatabase databaseWithPath:dbPath2] ;
    if (![db2 open]) {
        return ;
    }
    
    NSString *sql2 = [NSString stringWithFormat:@"select * from BOOKS where ID = %@", myId];
    FMResultSet *fmSet2 = [db2 executeQuery:sql2];
    if ([fmSet2 next]) {
        if ([[fmSet2 stringForColumn:@"SHOUCANG"] isEqualToString:@"0"]) {
            //没收藏
            isShouCang = NO;
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您确认收藏本篇文章？" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确认",nil];
            alertView.tag = 101;
            [alertView show];
            //[alertView release];
            
        }else{
            //已经收藏
            isShouCang = YES;
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您确认取消收藏本篇文章？" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确认",nil];
            alertView.tag = 102;
            [alertView show];
            //[alertView release];
        }
    }else{
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory2 = [paths2 objectAtIndex:0];
    NSString *dbPath2 = [documentDirectory2 stringByAppendingPathComponent:@"GWB.sqlite"];
    
    FMDatabase *db2 = [FMDatabase databaseWithPath:dbPath2] ;
    if (![db2 open]) {
        return ;
    }
    
    if(alertView.tag == 101 && buttonIndex == 1) {
        isShouCang = YES;
        [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCang.png"] forState:UIControlStateNormal];
        [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCangSel.png"] forState:UIControlStateSelected];
        
        [db2 executeUpdate:@"UPDATE BOOKS SET SHOUCANG = ? WHERE ID = ?", @"1", myId];
        
    }else if (alertView.tag == 102 && buttonIndex == 1){
        isShouCang = NO;
        [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCangSel.png"] forState:UIControlStateNormal];
        [shouCangBtn setBackgroundImage:[UIImage imageNamed:@"shouCang.png"] forState:UIControlStateSelected];
        
        [db2 executeUpdate:@"UPDATE BOOKS SET SHOUCANG = ? WHERE ID = ?", @"0", myId];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return pdfview;
}

- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
    
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




- (void)viewDidUnload {
    [super viewDidUnload];
}


@end
