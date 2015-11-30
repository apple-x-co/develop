//
//  MyPedometerGraphPlot.h
//  HealthTest
//
//  Created by Sano Kouhei on 2015/09/22.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPedometerGraphPlot : NSObject

@property (nonatomic, readonly) NSUInteger numberOfLabels;

- (void)addLabel:(NSString *)label number:(NSNumber *)number;

- (NSString *)labelAtIndex:(NSUInteger)index;
- (NSNumber *)numberAtIndex:(NSUInteger)index;

@end
