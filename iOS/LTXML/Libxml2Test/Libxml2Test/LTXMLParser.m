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
    return doc;
}

@end
