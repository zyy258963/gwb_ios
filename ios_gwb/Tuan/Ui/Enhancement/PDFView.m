//
//  PDFView.m
//  PDFViewTest
//
//  Created by Evan Lynn on 10-6-20.
//  Copyright 2010 Tera Age. All rights reserved.
//

#import "PDFView.h"
@implementation PDFView

@synthesize pdftest;
@synthesize categoryArray;

- (id)initWithFrame:(CGRect)frame andFileName:(NSString *)fileName{
    
    if (self = [super initWithFrame:frame]) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *docPath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.pdf",fileName]];
        
        pdf = [self createPDFFromExistFile:docPath];
        
        self.backgroundColor = [UIColor clearColor];
        
        if (!categoryArray) {
            categoryArray = [[NSMutableArray alloc] initWithCapacity:10];
        }
        
    }
    
    return self;
    
}



- (CGPDFDocumentRef)createPDFFromExistFile:(NSString *)aFilePath{
    
    CFStringRef path;
    
    CFURLRef url;
    
    CGPDFDocumentRef document;
    
    path = CFStringCreateWithCString(NULL, [aFilePath UTF8String], kCFStringEncodingUTF8);
    
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, NO);
    
    CFRelease(path);
    
    document = CGPDFDocumentCreateWithURL(url);
    
    CFRelease(url);
    
    totalPages = CGPDFDocumentGetNumberOfPages(document);
    
    currentPage=1;
    
    
    
    if (totalPages == 0) {
        
        
        
        return NULL;
        
    }
    
    NSMutableArray *cataLogTitles = [NSMutableArray array];
    [cataLogTitles removeAllObjects];
    [self.categoryArray removeAllObjects];
    
    CGPDFDictionaryRef catalogDictionary = CGPDFDocumentGetCatalog(document);
    
    CGPDFDictionaryRef namesDictionary = NULL;
    if (CGPDFDictionaryGetDictionary(catalogDictionary, "Outlines", &namesDictionary)) {
        
        long int myCount;
        if (CGPDFDictionaryGetInteger(namesDictionary, "Count", &myCount)) {
            NSLog(@"destinationName:%ld", myCount);
        }
        
        CGPDFDictionaryRef myDic;
        if( CGPDFDictionaryGetDictionary(namesDictionary, "First", &myDic) )
        {
            CGPDFStringRef myTitle;
            if( CGPDFDictionaryGetString(myDic, "Title", &myTitle) )
            {
                
                NSString *tempStr = (NSString *)CGPDFStringCopyTextString(myTitle);
                
                NSLog(@"myTitle===:%@", tempStr);
                NSString *num = [self returnCatalogListNumber:myDic PDFDoc:document];
                MuLuItem *temp = [[MuLuItem alloc] init];
                temp.muluName = tempStr;
                temp.muluPage = num;
                [cataLogTitles addObject:temp];
                NSLog(@"%@===", num);
                CGPDFDictionaryRef tempDic;
                tempDic = myDic;
                int i = 0;
                while ( i < myCount ) {
                    if( CGPDFDictionaryGetDictionary( tempDic , "Next", &tempDic) )
                    {
                        CGPDFStringRef tempTitle;
                        if( CGPDFDictionaryGetString(tempDic, "Title", &tempTitle) )
                        {
                            NSString *tempStr = (NSString *)CGPDFStringCopyTextString(tempTitle);
                            NSLog(@"myTitle:%@", tempStr);
                            NSString *num = [self returnCatalogListNumber:tempDic PDFDoc:document];
                            NSLog(@"%@", num);
                            MuLuItem *temp = [[MuLuItem alloc] init];
                            temp.muluName = tempStr;
                            temp.muluPage = num;
                            
                            [cataLogTitles addObject:temp];
                            
                        }
                    }
                    
                    i++;
                }
                
            }
        }
        
    }
    categoryArray = cataLogTitles;
    
    [ConfigManager sharedManager].muluArray = categoryArray;
    
    [[ConfigManager sharedManager].muluArray retain];
    
    return document;
    
}

//=============
-(NSString *)returnCatalogListNumber:(CGPDFDictionaryRef)tempCGPDFDic PDFDoc:(CGPDFDocumentRef)tempCGPDFDoc
{
    //------
    CGPDFDictionaryRef destDic;
    if( CGPDFDictionaryGetDictionary(tempCGPDFDic, "A", &destDic ))
    {
        CGPDFArrayRef destArray;
        if( CGPDFDictionaryGetArray(destDic, "D", &destArray) )
        {
            NSInteger targetPageNumber = 0; // The target page number
            
            CGPDFDictionaryRef pageDictionaryFromDestArray = NULL; // Target reference
            
            if (CGPDFArrayGetDictionary(destArray, 0, &pageDictionaryFromDestArray) == true)
            {
                NSInteger pageCount = CGPDFDocumentGetNumberOfPages(tempCGPDFDoc);
                
                for (NSInteger pageNumber = 1; pageNumber <= pageCount; pageNumber++)
                {
                    CGPDFPageRef pageRef = CGPDFDocumentGetPage(tempCGPDFDoc, pageNumber);
                    
                    CGPDFDictionaryRef pageDictionaryFromPage = CGPDFPageGetDictionary(pageRef);
                    
                    if (pageDictionaryFromPage == pageDictionaryFromDestArray) // Found it
                    {
                        targetPageNumber = pageNumber; break;
                    }
                }
            }
            else // Try page number from array possibility
            {
                CGPDFInteger pageNumber = 0; // Page number in array
                
                if (CGPDFArrayGetInteger(destArray, 0, &pageNumber) == true)
                {
                    targetPageNumber = (pageNumber + 1); // 1-based
                }
            }
            
            //NSLog(@"%d====", targetPageNumber);
            
            if (targetPageNumber > 0) // We have a target page number
            {
                return [NSString stringWithFormat:@"%d", targetPageNumber];
            }
        }
        
    }
    
    return @"0";
    //------
}



- (void)drawRect:(CGRect)rect {
    
    //得到绘图上下文环境
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //得到一个PDF页面
    
    page = CGPDFDocumentGetPage(pdf, currentPage);
    
    /*进行坐标转换向右移动100个单位，并且向下移动当前视图得高度，
     
     这是因为Quartz画图得坐标系统是以左下角为开始点，但iphone视图是以左上角为开始点
     
     */
    
    if (iPhone5) {
        CGContextTranslateCTM(context, 1.0,self.bounds.size.height);
    }else{
        CGContextTranslateCTM(context, 1.0,self.bounds.size.height - 100);
    }
    //CGContextTranslateCTM(context, -80.0,567);

    //转变坐标系
    //CGContextScaleCTM(context, 0.75, -0.75);
    if (iPhone5) {
        CGContextScaleCTM(context, 0.86, -0.86);
    }else{
        CGContextScaleCTM(context, 0.75, -0.75);
    }
    
    CGContextDrawPDFPage(context, page);
    
}



- (void)dealloc {
    
    [super dealloc];
    
}



-(void)reloadView{
    
    [self setNeedsDisplay];
    
}



-(void)goUpPage{
    
    if(currentPage < 2)
        
        return;
    
    --currentPage;
    
    [self reloadView];
    
}



-(void)goDownPage{
    
    if(currentPage >=totalPages)
        
        return;
    
    ++currentPage;
    
    [self reloadView];
    
}

-(void)goToPage:(int)pageNum {
    
    currentPage = pageNum;
    
    [self reloadView];
    
}

@end