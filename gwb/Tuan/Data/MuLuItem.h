//
//  AddvItem.h
//  coupon
//
//  Created by emacle emacle on 11-11-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLNode.h"
#import "XMLParser.h"

@interface MuLuItem : NSObject
{

    NSString *muluName;
    NSString *muluPage;
    
}

@property(nonatomic, retain)NSString *muluName;
@property(nonatomic, retain)NSString *muluPage;

@end
