//
//  ViewController.m
//  Libxml2Test
//
//  Created by Sano Kouhei on 2015/08/13.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import "ViewController.h"

#import "LTXMLParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LTXMLParser *ltParser = [[LTXMLParser alloc] initWithXML:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                            @"<!DOCTYPE nrdatasource PUBLIC \"-//NR//DTD NRDATASOURCE 1.0//EN\" "
                            @"\"http://www.katay-ph.com/nr/dtd/nrdatasource/1.0/nrdatasource.dtd\">"
                            @"<nrdatasource version=\"1.0\">"
                            @"<datasource driver=\"Pg\" dbname=\"banascheduler_dv\" user=\"banascheduler\" password=\"12345a\" />"
                            @"<datasource driver=\"MySQL\" dbname=\"banascheduler_dv\" user=\"banascheduler\" password=\"12345a\" />"
                            @"</nrdatasource>"];
    LTXMLDoc *doc = [ltParser parse];
    
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
    
    NSArray *array = [doc xmlNodesByXPath:@"/nrdatasource/datasource"];
    for (LTXMLNode *node in array) {
        NSLog(@"node name:%@ driver:%@", node.name, [node attributeContent:@"driver"]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
