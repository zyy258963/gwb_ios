//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "EGORefreshTableHeaderView.h"
#import "ShowMoreCell.h"
#import <MessageUI/MessageUI.h>

@interface BaseViewController : UIViewController <UIActionSheetDelegate, 
                                                   UIPickerViewDelegate,
                                                 UIPickerViewDataSource, 
                                          EGORefreshTableHeaderDelegate,
											MFMessageComposeViewControllerDelegate> {

	@private
    
    EGORefreshTableHeaderView *_pullHeaderView;
	MBProgressHUD *progressView;
	MFMessageComposeViewController *smsViewController2;
    
    UIActionSheet *_categoryTypeActionSheet;
	UIPickerView  *_categoryTypePickerView;
    NSArray *_categoryList;
    
    UIPickerView *_subcategoryPickerView;
    UIActionSheet *_subcategoryActionSheet;
    
    UIPickerView *_regionPickerView;
    UIActionSheet *_regionActionSheet;
	
	UIBarButtonItem *_feedBackBtn;
											  
	UIBarButtonItem *_commentBtn;
    
    UITableView *_listView; //weak ref
    BOOL          _refreshingData;
    BOOL          _showMoreIndicator;
		
                                                
    UIView   *_shadowBg;    //weak ref                                 
	UILabel *_myLocalLabel;  //weak ref
                                              
    NSString *_curCity; //记录取数据的城市
                                                
    BOOL      _showFavCompleteAlert;	
                                                

    UIImageView  *shadowBarView;   

    BOOL isShowDia;
                                                
    UIButton *_movieHelperBtn; //weak ref
         
    UIActionSheet *sortActionSheet;
    UIPickerView *sortPickerView;
                                                
    int sortType;
    
    //add by yeshenpeng
    int weiboType;
                                                
    NSArray *_photos;
                                                
}

@property(nonatomic, readonly)UIActionSheet *categoryTypeActionSheet;
@property(nonatomic, readonly)UIPickerView *categoryTypePickerView;

@property(nonatomic, readonly)UIActionSheet *subcategoryActionSheet;
@property(nonatomic, readonly)UIPickerView *subcategoryPickerView;

@property(nonatomic, readonly)UIActionSheet *regionActionSheet;
@property(nonatomic, readonly)UIPickerView *regionPickerView;
@property(nonatomic, readonly)UIBarButtonItem *feedBackBtn;
//@property(nonatomic, readonly)UIBarButtonItem *commentBtn;

@property(nonatomic, readonly)EGORefreshTableHeaderView *pullHeaderView;
@property(nonatomic, assign)BOOL showMoreIndicator;
@property(nonatomic, retain)UILabel *myLocalLabel;

@property(nonatomic, retain)NSArray *categoryList;

@property(nonatomic, copy)NSString *curCity;

@property (nonatomic, retain) MFMessageComposeViewController *smsViewController2;

@property BOOL showFavCompleteAlert;

@property BOOL isShowDia;

@property(nonatomic, readonly) UIActionSheet *sortActionSheet;
@property(nonatomic, readonly) UIPickerView *sortPickerView;
@property int sortType;
@property int weiboType;

@property (nonatomic, retain) NSArray *photos;

- (void)showPhotoBrowser:(NSInteger)showType currentIndex:(NSInteger)currentIndex photoArr:(NSArray *)photoArr;
- (void)addBgBackgroundColor;

//- (void)addLongBgBackgroundColor;

- (void)showProgress:(BOOL)animated;

- (void)hideProgress:(BOOL)animated;

- (void)showProgressWithText:(BOOL)animated showText:(NSString *)text;

- (void)addCustomBarItem:(int)postion normalImg:(NSString *)normalImg highlighted:(NSString *)Highlighted sel:(SEL)sel;

- (void)showErrorNote:(NSString *)title msg:(NSString *)msg;

- (void)showWeiBoActionSheet;

- (void)shareToWeibo:(NSNumber *)type;

- (void)addCategoryTypePicker;

- (void)showCategoryActionSheet;

- (void)didCategoreTypeChanged:(id)sender;

- (void)showSubCategoryActionSheet;

- (void)addSubCategoryActionSheet;

- (void)didSubCategoryChanged:(id)sender;

- (void)addRegionActionSheet;

- (void)showZoneActionSheet;

- (void)didZonePickerFinish:(id)sender;

- (void)addFeedBackBtn;

- (void)addCommentBtn;

- (void)favoriteItem:(NSString *)itemId branchId:(NSString *)branchId type:(int)type;

- (void)favoriteShop:(NSString *)branchId;

- (void)favoriteQueryCompleted:(NSNumber *)result;

- (void)addEGORefreshTableHeaderView:(UITableView *)listView;

- (void)egoRefreshTableHeaderViewRestore:(id)object;

- (ShowMoreCell *)createShowMoreCell:(UITableView *)listView;

- (void)updateShowMoreCell:(BOOL)indicator path:(NSIndexPath *)path;

- (void)showShadowBar:(NSString *)text withViewRect:(CGRect)viewRect withTextRect:(CGRect)textRect;

- (void)hideShadowBar;

- (void)setShadowBarTextChange:(NSString *)localText;

//- (void)startReverseLongitudeAndLatitude:(CLLocationDegrees)currentLog currentLat:(CLLocationDegrees)currentLat;

- (void)listenReverseLocation;

- (void)unListenReverseLocation;

- (void)locationReverseCompleted:(NSNumber *)success;

- (void)handleWeiboEvent:(NSInteger)buttonIndex;

- (void)handleSmsMessageEvent; // only for override by subclass

- (void)showSmsController:(NSString *)content;

- (void)craeteWindowAnimate;

- (void)showFavCompleteIndicator;

- (void)hiddenTabBar:(BOOL)hidd;

- (void)createMovieTabBar;

// below for movie order

- (void)showSortActionSheet;

- (void)addSortActionSheet;

- (void)didSortChanged:(id)sender;

- (void)refreshListViewData;

- (void)getMoreRefreshListViewData;

- (void)addCustomBarItem:(int)postion normalImg:(NSString *)normalImg highlighted:(NSString *)Highlighted sel:(SEL)sel btnWithText:(NSString *)myText;
@end
