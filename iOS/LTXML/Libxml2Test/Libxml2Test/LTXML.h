//
//  LTXML.h
//  Libxml2Test
//
//  Created by Sano Kouhei on 2015/08/14.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <libxml/parser.h>
#include <libxml/xpath.h>

#pragma mark - LTXMLAttribute

@interface LTXMLAttribute : NSObject

@property (nonatomic, assign) xmlAttrPtr xmlAttrPtr;

- (instancetype)initWithXMLAttrPtr:(xmlAttrPtr)xmlAttrPtr;

- (NSString *)name;
- (NSString *)content;

@end

#pragma mark - LTXMLNode

@interface LTXMLNode : NSObject

@property (nonatomic, assign) xmlNodePtr xmlNodePtr;

- (instancetype)initWithXMLNodePtr:(xmlNodePtr)xmlNodePtr;

- (NSString *)name;
- (NSString *)content;
- (NSArray *)children;
- (NSString *)attributeContent:(NSString *)name;
- (LTXMLAttribute *)attribute:(NSString *)name;
- (BOOL)hasAttribute:(NSString *)name;
- (NSMutableArray *)attributes;

@end

#pragma mark - LTXMLDoc

@interface LTXMLDoc : NSObject

@property (nonatomic, retain) NSString *xml;
@property (nonatomic, assign) xmlNodePtr xmlRootPtr;

- (instancetype)initWithXML:(NSString *)xml;

- (LTXMLNode *)root;
- (NSArray *)xmlNodesByXPath:(NSString *)xpath;

@end

#pragma mark - LTXML

@interface LTXML : NSObject

@end
