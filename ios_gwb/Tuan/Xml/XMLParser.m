//
//  XMLParser.m
//  BanckleRemoteHD
//
//  Created by Kyle on 10-9-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser
@synthesize cDataArr = _cDataArr;

- (id)init
{
    self = [super init];
    if (self)
    {
        _root = nil;
        _currentNode = nil;
        _currentValue = nil;
		
		_cDataArr = [[NSMutableArray alloc] initWithCapacity:8];
    }
    
    return self;
}


- (void)dealloc
{
    [_root release];
    [_currentValue release];
    [_cDataArr release];
	
    [super dealloc];
}


- (void)parse:(NSData *)data
{
    [_root release];
    _root = [[XMLNode alloc] initWithName:@""];
    _currentNode = _root;
    
    [_currentValue release];
    _currentValue = nil;
    
    NSXMLParser *nsparser = [[NSXMLParser alloc] initWithData:data];
    [nsparser setDelegate:self];
    [nsparser parse];
    [nsparser release];
}


- (XMLNode *)root
{
    return _root;
}


- (void)didFinishCurrentValue
{
    [_currentNode addValue:_currentValue];
    [_currentValue release];
    _currentValue = nil;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
                                        namespaceURI:(NSString *)namespaceURI
                                       qualifiedName:(NSString *)qName
                                          attributes:(NSDictionary *)attributeDict
{
    // NSLog(@"Start Element: %@", elementName);
    if (_currentValue)
    {
        [self didFinishCurrentValue];
    }
    
    XMLNode *newNode = [[XMLNode alloc] initWithName:elementName];
    newNode.attribution = attributeDict;
    [newNode setParent:_currentNode];
    [_currentNode addChild:newNode];
    _currentNode = newNode;
    [newNode release];
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // NSLog(@"Characters: %@", string);
    if (!_currentValue)
    {
        _currentValue = [[NSMutableString alloc] initWithString:string];
    }
    else 
    {
        [_currentValue appendString:string];
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
                                      namespaceURI:(NSString *)namespaceURI
                                     qualifiedName:(NSString *)qName
{
    // NSLog(@"End Element: %@", elementName);
    if (_currentValue)
    {
        [self didFinishCurrentValue];
    }
    
    if ([_currentNode parent])
    {
        _currentNode = [_currentNode parent];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{

	[_cDataArr addObject:CDATABlock];
	
}

@end
