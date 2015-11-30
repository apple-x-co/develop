//
//  MyPedometerGraph.h
//  HealthTest
//
//  Created by Sano Kouhei on 2015/09/22.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPTGraphHostingView;
@class MyPedometerGraphPlot;

@interface MyPedometerGraph : NSObject

@property (nonatomic, readonly) UIView *view;
@property (nonatomic, strong) MyPedometerGraphPlot *pedometerGraphPlot;

- (instancetype)initWithFrame:(CGRect)frame;

@end
