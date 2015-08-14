//
//  LTXMLParser.h
//  Libxml2Test
//
//  Created by Sano Kouhei on 2015/08/13.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTXMLParser : NSObject

- (instancetype)initWithXML:(NSString *)xml;
- (void)parse;

@end
