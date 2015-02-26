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
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "MuLuItem.h"
#import "TableViewCellHelper.h"
#import "ReaderViewController.h"
#import "PDFView.h"
#import "LogQuery.h"


@interface FourthViewController : BaseViewController<UIScrollViewDelegate,ReaderViewControllerDelegate>
{
    ASINetworkQueue *queue;
    IBOutlet UILabel *titleLab;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIProgressView *progressBarView;
    NSString *myUrl;
    NSString *myId;
    NSString *myTitle;
    
    BOOL isDownloadComplete;
    float fileLength;
    
    IBOutlet UILabel *totalPro;
    IBOutlet UILabel *currentPro;
    
    IBOutlet UIButton *shouCangBtn;
    
    NSString *downloadPath;
    
    BOOL isShouCang;
    
    
    PDFView *pdfview;
    LogQuery *_logQuery;
        
}

@property (nonatomic, retain) IBOutlet UILabel *titleLab;

@property (nonatomic, retain) IBOutlet UIProgressView *progressBarView;
@property (nonatomic, retain) IBOutlet UILabel *totalPro;
@property (nonatomic, retain) IBOutlet UILabel *currentPro;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UIButton *shouCangBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withUrl:(NSString *)itemUrl withId:(NSString *)itemId withTitle:(NSString *)itemTitle;
- (void)setLoadingUI:(BOOL)isLoading;

@end
