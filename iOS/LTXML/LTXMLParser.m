//
//  LTXMLParser.m
//  Libxml2Test
//
//  Created by Sano Kouhei on 2015/08/13.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import "LTXMLParser.h"

#pragma mark - LTXMLParser

@interface LTXMLParser ()

@property (nonatomic, strong) NSString *xml;

@end

@implementation LTXMLParser

- (instancetype)initWithXML:(NSString *)xml
{
    self = [super init];
    if (self) {
        self.xml = xml;
    }
    return self;
}

- (LTXMLDoc *)parse
{
    LTXMLDoc *doc = [[LTXMLDoc alloc] initWithXML:self.xml];
    LTXMLNode *ltNode = [doc root];
    
    NSArray *nodes = [ltNode children];
    for (LTXMLNode *node in nodes) {
        NSLog(@"---");
        
        NSLog(@"name:%@, content:%@", [node name], [node content]);
        
        LTXMLAttribute *attribute = [node attribute:@"driver"];
        NSLog(@"attr name:%@ content:%@, %@", [attribute name], [attribute content], [node attributeContent:@"driver"]);
        
        NSArray *attributes = [node attributes];
        for (LTXMLAttribute *attr in attributes) {
            NSLog(@"attr name:%@ content:%@", [attr name], [attr content]);
        }
    }
    
    return doc;
}

@end
