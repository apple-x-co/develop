//
//  LTXML.m
//  Libxml2Test
//
//  Created by Sano Kouhei on 2015/08/14.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import "LTXML.h"

#pragma mark - LTXMLAttribute

@implementation LTXMLAttribute

- (instancetype)initWithXMLAttrPtr:(xmlAttrPtr)xmlAttrPtr;
{
    self = [super init];
    if (self) {
        self.xmlAttrPtr = xmlAttrPtr;
    }
    return self;
}

- (NSString *)name {
    
    return [NSString stringWithCString:(char *)self.xmlAttrPtr->name encoding:NSUTF8StringEncoding];
    
}

- (NSString *)content {
    
    if (self.xmlAttrPtr->children->content == NULL) {
        return nil;
    }
    
    return [NSString stringWithCString:(char *)self.xmlAttrPtr->children->content encoding:NSUTF8StringEncoding];
}

@end

#pragma mark - LTXMLNode

@implementation LTXMLNode

- (instancetype)initWithXMLNodePtr:(xmlNodePtr)xmlNodePtr
{
    self = [super init];
    if (self) {
        self.xmlNodePtr = xmlNodePtr;
    }
    return self;
}

- (NSString *)name {
    
    return [NSString stringWithCString:(char *)self.xmlNodePtr->name encoding:NSUTF8StringEncoding];
    
}

- (NSString *)content {
    
    if (self.xmlNodePtr->content == NULL) {
        return nil;
    }
    
    return [NSString stringWithCString:(char *)self.xmlNodePtr->content encoding:NSUTF8StringEncoding];
    
}

- (NSArray *)children {
    
    NSMutableArray *nodes = [NSMutableArray array];
    
    for (xmlNodePtr xmlNode = self.xmlNodePtr->children; xmlNode != NULL; xmlNode = xmlNode->next) {
        
        LTXMLNode *node = [[LTXMLNode alloc] initWithXMLNodePtr:xmlNode];
        [nodes addObject:node];
        
    }
    
    return nodes;
}

- (NSString *)attributeContent:(NSString *)name {
    
    xmlChar *attr = xmlGetProp(self.xmlNodePtr, (const xmlChar *)[name UTF8String]);
    return [NSString stringWithCString:(char *)attr encoding:NSUTF8StringEncoding];
    
}

- (LTXMLAttribute *)attribute:(NSString *)name {
    
    xmlAttrPtr attr = xmlHasProp(self.xmlNodePtr, (const xmlChar *)[name UTF8String]);
    LTXMLAttribute *attribute = [[LTXMLAttribute alloc] initWithXMLAttrPtr:attr];
    return attribute;
    
}

- (BOOL)hasAttribute:(NSString *)name {
    
    xmlAttrPtr attr = xmlHasProp(self.xmlNodePtr, (const xmlChar *)[name UTF8String]);
    return (attr == NULL) ? NO : YES;
}

- (NSMutableArray *)attributes {
    
    NSMutableArray *attrs = [NSMutableArray array];
    
    for (xmlAttrPtr attr = self.xmlNodePtr->properties; attr != NULL; attr = attr->next) {
        
        LTXMLAttribute *attribute = [[LTXMLAttribute alloc] initWithXMLAttrPtr:attr];
        [attrs addObject:attribute];
        
    }
    
    return attrs;
    
}

@end

#pragma mark - LTXMLDoc

@interface LTXMLDoc ()

@property (nonatomic, assign) xmlDocPtr xmlDocPtr;

@end

@implementation LTXMLDoc

- (instancetype)initWithXML:(NSString *)xml
{
    self = [super init];
    if (self) {
        self.xml = xml;
        self.xmlDocPtr = xmlParseMemory([self.xml UTF8String], (int)[self.xml lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
        self.xmlRootPtr = xmlDocGetRootElement(self.xmlDocPtr);
    }
    return self;
}

- (LTXMLNode *)root
{
    LTXMLNode *ltNode = [[LTXMLNode alloc] initWithXMLNodePtr:self.xmlRootPtr];
    return ltNode;
}

- (NSArray *)xmlNodesByXPath:(NSString *)xpath
{
    xmlXPathContextPtr context = xmlXPathNewContext(self.xmlDocPtr);
    
    xmlChar *xmlXPath = (xmlChar *)[xpath UTF8String];
    xmlXPathObjectPtr result = xmlXPathEvalExpression(xmlXPath, context);
    
    xmlXPathFreeContext(context);
    
    if (result == nil) {
        return [NSMutableArray array];
    }
    
    NSMutableArray *nodes = [NSMutableArray array];

    xmlNodeSetPtr nodeset = result->nodesetval;
    NSInteger count = nodeset->nodeNr;
    
    for (NSUInteger i = 0; i < count; i++) {
        
        LTXMLNode *xmlNode = [[LTXMLNode alloc] initWithXMLNodePtr:nodeset->nodeTab[i]];
        [nodes addObject:xmlNode];
        
    }
    
    return nodes;
}

@end

#pragma mark - LTXML

@implementation LTXML

@end
