//
//  XMLNode.h
//  BanckleRemoteHD
//
//  Created by Kyle on 10-9-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLNode : NSObject 
{
    NSString *_name;
    NSMutableDictionary *_children;
    
    NSDictionary *_attribution;
    NSMutableArray *_values;
    XMLNode *_parent;
    
}

@property(nonatomic, retain)NSDictionary *attribution;

- (id)initWithName:(NSString *)name;

- (XMLNode *)parent;

- (void)setParent:(XMLNode *)parent;

- (NSString *)name;

- (NSString *)valueAt:(int)index;

- (NSString *)attributionWithTagName:(NSString *)tagName;

- (XMLNode *)childWithName:(NSString *)name withIndex:(int)index;
- (NSArray *)childrenWithName:(NSString *)name;

- (void)addChild:(XMLNode *)child;

- (void)addValue:(NSString *)value;


@end
