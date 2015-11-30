//
//  MyPedometerData.h
//  HealthTest
//
//  Created by Sano Kouhei on 2015/09/16.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import <HealthKit/HealthKit.h>

typedef struct {
    
    unsigned int startDate;
    unsigned int endDate;
    double count;
    
} MyPedometerData;

static inline MyPedometerData HKQuantitySampleToMyPedometerData(HKQuantitySample *quantitySample)
{
    MyPedometerData myPedometerData;
    
    HKQuantity *quantity = quantitySample.quantity;
    HKUnit *unit = [HKUnit countUnit];
    
    myPedometerData.startDate = quantitySample.startDate.timeIntervalSince1970;
    myPedometerData.endDate = quantitySample.endDate.timeIntervalSince1970;
    myPedometerData.count = [quantity doubleValueForUnit:unit];
    
    return myPedometerData;
}

static inline MyPedometerData HKStatisticsToMyPedometerData(HKStatistics *statistics)
{
    MyPedometerData myPedometerData;
    
    HKQuantity *quantity = statistics.sumQuantity;
    HKUnit *unit = [HKUnit countUnit];
    
    myPedometerData.startDate = statistics.startDate.timeIntervalSince1970;
    myPedometerData.endDate = statistics.endDate.timeIntervalSince1970;
    myPedometerData.count = [quantity doubleValueForUnit:unit];
    
    return myPedometerData;
}
