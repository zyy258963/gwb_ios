//
//  ConfigManager.h
//  ZLdisk
//
//  Created by zhang zuochen on 12-06-01.
//  Copyright 2012年 AMG-TECH All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#define K_DOUJIAOTEST_BASEURL 1

@interface ConfigManager : NSObject 
{
    NSMutableArray *muluArray;
    NSString *chooseMulu;
    NSString *cangId;
    NSString *chooseBook;
}
@property(nonatomic,retain)NSMutableArray *muluArray;
@property(nonatomic,retain)NSString *chooseMulu;
@property(nonatomic,retain)NSString *cangId;
@property(nonatomic,retain)NSString *chooseBook;

+ (ConfigManager *)sharedManager;


@end
