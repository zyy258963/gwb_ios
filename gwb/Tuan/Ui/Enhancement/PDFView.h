#import <UIKit/UIKit.h>
#import "MuLuItem.h"

@class PDFTestViewController;

@interface PDFView : UIView {
    
    //这个类封装了PDF画图得所有信息
    CGPDFDocumentRef pdf;
    
    //PDFDocument 中得一页
    CGPDFPageRef page;
    
    //总共页数
    int totalPages;
    
    //当前得页面
    int currentPage;
    
    
    
    PDFTestViewController *pdftest;
    
}

@property(nonatomic,retain)IBOutlet PDFTestViewController *pdftest;

@property(nonatomic,retain)NSMutableArray *categoryArray;

//当前视图初始化类，在该方法中会创建一个CGPDFDocuemntRef对象，传递一个PDF文件得名字，和所需要页面得大小，

- (id)initWithFrame:(CGRect)frame andFileName:(NSString *)fileName;

//创建一个PDF对象，此方法在初始化方法中被调用

- (CGPDFDocumentRef)createPDFFromExistFile:(NSString *)aFilePath;

-(void)reloadView;

/*
 
 页面之间得跳转
 
 */
-(void)goUpPage;   

-(void)goDownPage;

-(void)goToPage:(int)pageNum;

@end