//
//  LoginViewController.m
//  Tuan
//
//  Created by heyf on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChapterViewController.h"
#import "TuanAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "TableViewCellHelper.h"
#import "TuanAppDelegate.h"
#import "Reachability.h"

@implementation ChapterViewController

@synthesize oneTableView;

@synthesize items;
@synthesize titleLab;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withBookId:(NSString* )itemId withBookName:(NSString* )itemName {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        myBookId = itemId;
        myBookName = itemName;
        
        [myBookId retain];
        [myBookName retain];
    }
    return self;
}

- (IBAction)leftBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (!_logQuery) {
        _logQuery = [[LogQuery alloc] init];
        _logQuery.mytarget = self;
    }
    
    
    searchQuery = [[SearchListQuery alloc] init];
    searchQuery.mytarget = self;
    
    [self.navigationController setNavigationBarHidden:YES];
    if (!items) {
        items = [[NSMutableArray alloc] initWithCapacity:6];
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:252.0f/255.0f green:252.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    
    self.oneTableView.backgroundColor = [UIColor clearColor];
    
//    searchQuery = [[SearchListQuery alloc] init];
//    searchQuery.mytarget = self;
    
//    if (myBookId.length == 0 && myKeyWord.length != 0) {
//        searchQuery.keyWord = myKeyWord;
//        [searchQuery getSearchList];
//        self.titleLab.text = @"检索结果";
//    }
    
    query = [[ChapterListQuery alloc] init];
    query.mytarget = self;
    
    NSLog(@"-----------------myBookId----1-------------%@------",myBookId);
    if (myBookId.length != 0 ) {
        query.bookId = myBookId;
        [query getChapterList];
        self.titleLab.text = myBookName;
    }
    
    [self setLoadingUI:YES];
    
    
    NSLog(@"-----------------myBookId-----------------%@------",myBookId);
//    
//    if (myBookId.length == 0 ) {
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(updateList:)
//                                                     name:@"updateListMy"
//                                                   object:nil];
//        
//        [items removeAllObjects];
//        
//        NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentDirectory2 = [paths2 objectAtIndex:0];
//        NSString *dbPath2 = [documentDirectory2 stringByAppendingPathComponent:@"gwb1.sqlite"];
//        
//        FMDatabase *db2 = [FMDatabase databaseWithPath:dbPath2] ;
//        if (![db2 open]) {
//            return ;
//        }
//        
//        NSString *sql3 = [NSString stringWithFormat:@"select * from BOOKS where SHOUCANG = %@",@"1"];
//        FMResultSet *fmSet3 = [db2 executeQuery:sql3];
//        while ([fmSet3 next]) {
//            
//            ChapterListItem *temp = [[ChapterListItem alloc] init];
//            temp.chapterId = [fmSet3 stringForColumn:@"ID"];
//            temp.chapterName = [fmSet3 stringForColumn:@"NAME"];
////            temp.chapterUrl = [fmSet3 stringForColumn:@"URL"];
//            [items addObject:temp];
//            [temp release];
//            
//        }
//        
//        [fmSet3 close];
//        [db2 close];
//        
//        self.titleLab.text = @"我的常用文档";
//        
//        [self.oneTableView reloadData];
//        
//        [self setLoadingUI:NO];
//        
//        if (items.count == 0) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您还没有收藏文件哦!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            alert.tag = 999;
//            [alert show];
//            [alert release];
//        }
//        
//    }
    
}

- (void)updateList:(NSNotification*)result {
    
    NSLog(@"-----------------updateList-----------------%@------",myBookId);
    if (myBookId.length == 0 ) {
        [items removeAllObjects];
        
        NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory2 = [paths2 objectAtIndex:0];
        NSString *dbPath2 = [documentDirectory2 stringByAppendingPathComponent:@"gwb1.sqlite"];
        
        FMDatabase *db2 = [FMDatabase databaseWithPath:dbPath2] ;
        if (![db2 open]) {
            return ;
        }
        
        NSString *sql3 = [NSString stringWithFormat:@"select * from BOOKS where SHOUCANG = %@",@"1"];
        FMResultSet *fmSet3 = [db2 executeQuery:sql3];
        while ([fmSet3 next]) {
            
            ChapterListItem *temp = [[ChapterListItem alloc] init];
            temp.bookId = [fmSet3 stringForColumn:@"ID"];
            temp.chapterName = [fmSet3 stringForColumn:@"NAME"];
            [items addObject:temp];
            [temp release];
        }
        
        [fmSet3 close];
        [db2 close];
        
        self.titleLab.text = @"我的常用文档";
        
        [self.oneTableView reloadData];
        
        [self setLoadingUI:NO];
        
        if (items.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您需要的文件尚未出版或未纳入公文包数据库,我们会尽快为您录入。请电客服：18601024316 联系或给QQ号：910166361 联系留言，谢谢！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 999;
            [alert show];
            [alert release];
        }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

-(void)getChapterListComplete:(NSNumber *)result
{
    [items removeAllObjects];
    
    
    NSLog(@"-----------------query.listItemArray-----------11111------%@------",query.listItemArray);
    
    for (int w = 0; w < query.listItemArray.count; w ++) {
        NSLog(@"-----------------query.listItemArray-----------------%i------",w);
        
        [items addObject:[query.listItemArray objectAtIndex:w]];
    }
    NSLog(@"-----------------items------------%@------",items);
    
    [self.oneTableView reloadData];
    
    [self setLoadingUI:NO];
    
//    if (items.count == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您需要的文件尚未出版或未纳入公文包数据库，我们会尽快为您录入。请电客服：18601024316 联系或给QQ号：910166361 联系留言，谢谢！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        alert.tag = 999;
//        [alert show];
//        [alert release];
//    }
    
}

- (void)getChapterListQueryError:(id)obj
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:(NSString *)obj delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [self setLoadingUI:NO];
}
//
//-(void)getSearchListComplete:(NSNumber *)result
//{
//    [items removeAllObjects];
//    
//    
//    for (int w = 0; w < searchQuery.listItemArray.count; w ++) {
//        [items addObject:[searchQuery.listItemArray objectAtIndex:w]];
//    }
//    
//    [self.oneTableView reloadData];
//    
//    [self setLoadingUI:NO];
//    
//    if (items.count == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您需要的文件尚未出版或未纳入公文包数据库，我们会尽快为您录入。请电客服：18601024316 联系或给QQ号：910166361 联系留言，谢谢！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        alert.tag = 999;
//        [alert show];
//        [alert release];
//    }
//    
//}

//- (void)getSearchListQueryError:(id)obj
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:(NSString *)obj delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//    [self setLoadingUI:NO];
//}

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [items count];
    
    return count;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

//处理连接改变后的情况
- (int) updateInterfaceWithReachability: (Reachability*) curReach
{
    
    int temp = 1;
    
    //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == kReachableViaWiFi) {
        //wifi
        temp = 2;
    }else if(status == kNotReachable){
        //没网
        temp = 1;
    }else{
        temp = 3;
    }
    return temp;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    
    ChapterListItem *temp = (ChapterListItem *)[items objectAtIndex:row];
    return [TableViewCellHelper createChapterListCell:self view:tableView appWithItem:temp];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    
    Reachability *hostReach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    int temp = [self updateInterfaceWithReachability:hostReach];
    
//    if (temp == 1) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请检查您的网络是否连接。" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//        [alertView release];
//    }else if (temp == 3){
//        downloadTemp = (ChapterListItem *)[items objectAtIndex:row];
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您当前不在WIFI环境下，是否继续下载？" message:nil delegate:self cancelButtonTitle:@"否"otherButtonTitles:@"是",nil];
//        alertView.tag = 101;
//        [alertView show];
//        [alertView release];
//        
//    }else {
        ChapterListItem *tempItem = (ChapterListItem *)[items objectAtIndex:row];
        
        [ConfigManager sharedManager].chooseBook = tempItem.bookId;
        [ConfigManager sharedManager].chooseChapter = tempItem.chapterName;
        
        
        NSLog(@"---下载 pdf --%@-%@----------",tempItem.chapterId,tempItem.chapterName);
        [_logQuery takeTongJiDoc:tempItem.chapterName];

        FourthViewController *contentView = [[FourthViewController alloc] initWithNibName:@"FourthViewController" bundle:nil withUrl:tempItem.chapterUrl withId:[NSString stringWithFormat:@"%d",[tempItem.chapterId intValue]] withTitle:tempItem.chapterName];
        [contentView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:contentView animated:YES];
        [contentView release];
//    }
    
    [self.oneTableView reloadData];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if(alertView.tag == 101 && buttonIndex == 1) {
//        FourthViewController *contentView = [[FourthViewController alloc] initWithNibName:@"FourthViewController" bundle:nil withId:[NSString stringWithFormat:@"%d",[downloadTemp.bookId intValue]] withTitle:downloadTemp.bookName];
//        [contentView setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:contentView animated:YES];
//        [contentView release];
//    }else if (alertView.tag == 999){
//        [self leftBtnPressed:nil];
//    }
//}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
