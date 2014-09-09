//
//  FileDataManager.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDataManager : NSObject
{
    NSMutableArray *fileArray;
    NSMutableArray *onlineArray;
    NSString *total;
    int pageIndex;
}

@property (nonatomic, retain) NSMutableArray *fileArray;
@property (nonatomic, retain) NSMutableArray *onlineArray;
@property (nonatomic, retain) NSString *total;
@property (nonatomic, assign) int pageIndex;

+ (FileDataManager *)sharedManager;

- (void)clearAllDates;

@end
