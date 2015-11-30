//
//  MyPedometerGraphPlot.m
//  HealthTest
//
//  Created by Sano Kouhei on 2015/09/22.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import "MyPedometerGraphPlot.h"

@interface MyPedometerGraphPlot ()

@property (nonatomic, readwrite) NSMutableArray *labels;
@property (nonatomic, readwrite) NSMutableArray *numbers;

@end

@implementation MyPedometerGraphPlot

- (instancetype)init
{
    self = [super init];
    if (self) {
        _labels = [[NSMutableArray alloc] init];
        _numbers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addLabel:(NSString *)label number:(NSNumber *)number
{
    [self.labels addObject:label];
    [self.numbers addObject:number];
}

- (NSString *)labelAtIndex:(NSUInteger)index
{
    return [self.labels objectAtIndex:index];
}

- (NSNumber *)numberAtIndex:(NSUInteger)index
{
    return [self.numbers objectAtIndex:index];
}

#pragma mark - Property

- (NSUInteger)numberOfLabels
{
    return self.labels.count;
}

@end
