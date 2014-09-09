//
//  XMLParser.h
//  BanckleRemoteHD
//
//  Created by Kyle on 10-9-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLNode.h"


@interface XMLParser : NSObject <NSXMLParserDelegate>
{
    NSData *_data;
    XMLNode *_root;
    XMLNode *_currentNode;
    NSMutableString *_currentValue;
	
	NSMutableArray *_cDataArr;
}

@property(nonatomic, readonly) NSMutableArray *cDataArr;

- (void)parse:(NSData *)data;

- (XMLNode *)root;

@end
