//
//  MyPedometerGraph.m
//  HealthTest
//
//  Created by Sano Kouhei on 2015/09/22.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import "MyPedometerGraph.h"

#import "MyPedometerGraphPlot.h"

#import "CorePlot-CocoaTouch.h"

@interface MyPedometerGraph () <CPTPlotDataSource>

@property (nonatomic, strong) CPTGraphHostingView *graphHostingView;

@end

@implementation MyPedometerGraph

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _pedometerGraphPlot = nil;
        
        CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
        
        CPTXYGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.view.bounds];
        [graph applyTheme:theme];
        
        _graphHostingView = [[CPTGraphHostingView alloc] initWithFrame:frame];
        _graphHostingView.hostedGraph = graph;
    }
    return self;
}

- (void)configurePlots
{
    CPTGraph *graph = self.graphHostingView.hostedGraph;
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    
    //プロットを作成する
    CPTScatterPlot *scatterPlot = [[CPTScatterPlot alloc] init];
    scatterPlot.dataSource = self;
    scatterPlot.identifier = @"identifier";
    scatterPlot.interpolation = CPTScatterPlotInterpolationCurved;
    [graph addPlot:scatterPlot toPlotSpace:plotSpace];
    
    //プロットスペースをセットアップする
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:scatterPlot, nil]];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    xRange  = [CPTMutablePlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(31.0f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    yRange  = [CPTMutablePlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(180.0f)];
    plotSpace.yRange = yRange;
    
    //スタイルとシンボル作成
    CPTColor *scatterColor = [CPTColor orangeColor];
    CPTMutableLineStyle *scatterLineStyle = [scatterPlot.dataLineStyle mutableCopy];
    scatterLineStyle.lineWidth = 2.5;
    scatterLineStyle.lineColor = scatterColor;
    scatterPlot.dataLineStyle = scatterLineStyle;
    CPTMutableLineStyle *scatterSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    scatterSymbolLineStyle.lineColor = scatterColor;
    CPTPlotSymbol *scatterSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    scatterSymbol.fill = [CPTFill fillWithColor:scatterColor];
    scatterSymbol.lineStyle = scatterSymbolLineStyle;
    scatterSymbol.size = CGSizeMake(6.0f, 6.0f);
    scatterPlot.plotSymbol = scatterSymbol;
}

- (void)configureAxes
{
    CPTGraph *graph = self.graphHostingView.hostedGraph;
    
    //1. スタイル作成
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor brownColor];
    lineStyle.lineWidth = 2.0f;
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor blackColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 11.0f;
    
    
    //2. Axes Setを取得
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    //3. X軸の設定
    CPTXYAxis *x = axisSet.xAxis;
    x.majorIntervalLength = CPTDecimalFromString(@"7");
    x.minorTicksPerInterval = 6;
    x.majorTickLineStyle = lineStyle;
    x.minorTickLineStyle = lineStyle;
    x.axisLineStyle = lineStyle;
    x.minorTickLength = 5.0f;
    x.majorTickLength = 9.0f;
    x.labelTextStyle = axisTextStyle;
    
    //4. Y軸の設定
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength = CPTDecimalFromString(@"20");
    y.minorTicksPerInterval = 4;
    y.majorTickLineStyle = lineStyle;
    y.minorTickLineStyle = lineStyle;
    y.axisLineStyle = lineStyle;
    y.minorTickLength = 5.0f;
    y.majorTickLength = 9.0f;
    y.labelTextStyle = axisTextStyle;
    y.title = @"推移";
    y.titleOffset = 35.0f;
    lineStyle.lineWidth = 0.5f;
    y.majorGridLineStyle = lineStyle;
}

#pragma mark - Property

- (UIView *)view
{
    return self.graphHostingView;
}

- (void)setPedometerGraphPlot:(MyPedometerGraphPlot *)pedometerGraphPlot
{
    if (_pedometerGraphPlot != pedometerGraphPlot) {
        _pedometerGraphPlot = pedometerGraphPlot;
        
        [self configurePlots];
    }
}

#pragma mark - CPTPlotDataSource

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if (self.pedometerGraphPlot == nil) {
        return 0;
    }
    
    return self.pedometerGraphPlot.numberOfLabels;
}

-(id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    return [NSNumber numberWithInteger:index];
//    return [self.pedometerGraphPlot numberAtIndex:index];
}

@end
