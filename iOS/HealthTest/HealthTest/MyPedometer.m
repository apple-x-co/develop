//
//  MyPedometer.m
//  HealthTest
//
//  Created by Sano Kouhei on 2015/09/11.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import <HealthKit/HealthKit.h>

#import "MyPedometer.h"

@interface MyPedometer ()

@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation MyPedometer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _healthStore = [[HKHealthStore alloc] init];
    }
    return self;
}

#pragma mark - Class Methods

/**
 * 万歩計（HealthKit）の利用状況の確認
 * @return YES 利用できる場合
 */
+ (BOOL)isAvailable
{
    return HKHealthStore.isHealthDataAvailable;
}

#pragma mark -

/**
 * 万歩計（HealthKit）の利用準備。
 * @param completion コールバック。HealthKitの権限設定画面でキャンセルを選択された場合にFalseを返す。
 * @return なし
 *
 */
- (void)prepareWithCompletion:(void (^)(BOOL cancel))completion
{
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    [self.healthStore requestAuthorizationToShareTypes:[NSSet set]
                                             readTypes:[NSSet setWithObject:quantityType]
                                            completion:^(BOOL success, NSError *error){
                                                if (success) {
                                                    completion(NO);
                                                }
                                                else {
                                                    completion(YES);
                                                }
                                            }];
}

/**
 * 歩数の書き込み権限の付与
 * @param completion コールバック。HealthKitの権限設定画面でキャンセルを選択された場合にFalseを返す。
 * @return なし
 */
- (void)requestAppendAuthorizationWithCompletion:(void (^)(BOOL cancel))completion
{
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    [self.healthStore requestAuthorizationToShareTypes:[NSSet setWithObject:quantityType]
                                             readTypes:[NSSet setWithObject:quantityType]
                                            completion:^(BOOL success, NSError *error){
                                                if (success) {
                                                    completion(NO);
                                                }
                                                else {
                                                    completion(YES);
                                                }
                                            }];
}

/**
 * 歩数の書き込み
 * @param count 歩数
 * @param startDate 開始日
 * @param endDate 終了日
 * @param completion コールバック。書き込みに失敗した場合にFalseとエラーメッセージを返す。
 * @return なし
 */
- (void)appendStepCount:(NSUInteger)count startDate:(NSDate *)startDate endDate:(NSDate *)endDate completion:(void(^)(BOOL success, NSString *message))completion
{
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantity *quantity = [HKQuantity quantityWithUnit:HKUnit.countUnit doubleValue:count];
    HKQuantitySample *quantitySample = [HKQuantitySample quantitySampleWithType:quantityType
                                                                       quantity:quantity
                                                                      startDate:startDate
                                                                        endDate:endDate];
    [self.healthStore saveObject:quantitySample
                  withCompletion:^(BOOL success, NSError *error){
                      if (success) {
                          completion(YES, nil);
                      }
                      else {
                          NSString *message = [error.userInfo valueForKey:NSLocalizedDescriptionKey];
                          completion(NO, message);
                      }
                  }];
}

/**
 * 歩数の取得
 * @param startDate 開始日
 * @param endDate 終了日
 * @param limit 取得件数
 * @param resultsHandler コールバック。
 * @return なし
 */
- (void)fetchStepCountStartDate:(NSDate *)startDate endDate:(NSDate *)endDate limit:(NSUInteger)limit resultsHandler:(void(^)(NSArray *results, NSString *message))resultsHandler
{
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate
                                                                     ascending:YES];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:quantityType
                                                                 predicate:predicate
                                                                     limit:limit
                                                           sortDescriptors:@[sortDescriptor]
                                                            resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error){
                                                                if (error == nil) {
                                                                    resultsHandler(results, nil);
                                                                }
                                                                else {
                                                                    NSString *message = [error.userInfo valueForKey:NSLocalizedDescriptionKey];
                                                                    resultsHandler(nil, message);
                                                                }
                                                            }];
    [self.healthStore executeQuery:sampleQuery];
}

/**
 * 歩数の取得（件数指定なし）
 * @param startDate 開始日
 * @param endDate 終了日
 * @param resultsHandler コールバック。
 * @return なし
 */
- (void)fetchStepCountStartDate:(NSDate *)startDate endDate:(NSDate *)endDate resultsHandler:(void(^)(NSArray *results, NSString *message))resultsHandler
{
    [self fetchStepCountStartDate:startDate endDate:endDate limit:0 resultsHandler:resultsHandler];
}

/**
 * 統計歩数の取得
 * @param startDate 開始日
 * @param endDate 終了日
 * @param options オプション（複数指定可）
 * @param components 間隔
 * @param resultsHandler コールバック。
 * @return なし
 */
- (void)fetchStatisticsStepCountStartDate:(NSDate *)startDate endDate:(NSDate *)endDate options:(MyPedometerStatisticsOptions)options components:(NSDateComponents *)components resultsHandler:(void(^)(HKStatisticsCollection *result, NSString *message))resultsHandler
{
    /// FIXME: MyPedometerStatisticsOptions TO HKStatisticsOption
    
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    
    HKStatisticsCollectionQuery *statisticsQuery = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType
                                                                                     quantitySamplePredicate:predicate
                                                                                                     options:HKStatisticsOptionCumulativeSum
                                                                                                  anchorDate:startDate
                                                                                          intervalComponents:components];
    statisticsQuery.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error) {
        if (error == nil) {
            resultsHandler(result, nil);
        } else {
            NSString *message = [error.userInfo valueForKey:NSLocalizedDescriptionKey];
            resultsHandler(nil, message);
        }
    };
    
    [self.healthStore executeQuery:statisticsQuery];
    
}

@end
