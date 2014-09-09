//
//  XMLNode.m
//  BanckleRemoteHD
//
//  Created by Kyle on 10-9-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "XMLNode.h"


@implementation XMLNode

@synthesize attribution = _attribution;

- (void)initContainers
{
    _children = [[NSMutableDictionary alloc] initWithCapacity:3];
    _values = [[NSMutableArray alloc] initWithCapacity:1];
}


- (id)init
{
    self = [super init];
    if (self)
    {
        _name = [[NSString alloc] initWithString:@""];
        [self initContainers];
    }
    
    return self;
}


- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        _name = [[NSString alloc] initWithString:name];
        [self initContainers];
    }
    
    return self;
}


- (void)dealloc
{
    [_children release];
    [_values release];
    [_name release];
    
    [_attribution release];
    [super dealloc];
}


- (XMLNode *)parent
{
    return _parent;
}


- (void)setParent:(XMLNode *)parent;
{
    _parent = parent;
}


- (NSString *)name
{
    return _name;
}


- (NSString *)valueAt:(int)index
{
    NSString *value = nil;
    if ([_values count] > 0)
    {
        value = [_values objectAtIndex:index];
    }
    else
    {
        value = @"";
    }
    
    return value;
}

- (NSString *)attributionWithTagName:(NSString *)tagName
{

    return [self.attribution objectForKey:tagName];
}

- (XMLNode *)childWithName:(NSString *)name withIndex:(int)index
{
    XMLNode *node = nil;
    NSMutableArray *namedChild = [_children objectForKey:name];
    if (namedChild)
    {
        node = [namedChild objectAtIndex:index];
    }
    
    return node;
}


- (NSArray *)childrenWithName:(NSString *)name
{
    return [_children objectForKey:name];
}


- (void)addChild:(XMLNode *)child
{
    id entry = [_children objectForKey:[child name]];
    if (entry == nil)
    {
        NSMutableArray *namedChild = [[NSMutableArray alloc] initWithCapacity:3];
        [namedChild addObject:child];
        [_children setObject:namedChild forKey:[child name]];
        [namedChild release];
    }
    else 
    {
        NSMutableArray *namedChild = (NSMutableArray *)entry;
        [namedChild addObject:child];
    }
}


- (void)addValue:(NSString *)value
{
    [_values addObject:value];
}

@end
