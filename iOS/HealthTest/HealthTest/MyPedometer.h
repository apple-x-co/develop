//
//  MyPedometer.h
//  HealthTest
//
//  Created by Sano Kouhei on 2015/09/11.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HKStatisticsCollection;

typedef NS_OPTIONS(NSUInteger, MyPedometerStatisticsOptions) {
    MyPedometerStatisticsOptionNone              		 = 0,
    MyPedometerStatisticsOptionSeparateBySource          = 1 << 0,
    MyPedometerStatisticsOptionDiscreteAverage           = 1 << 1,
    MyPedometerStatisticsOptionDiscreteMin               = 1 << 2,
    MyPedometerStatisticsOptionDiscreteMax               = 1 << 3,
    MyPedometerStatisticsOptionCumulativeSum             = 1 << 4,
};

@interface MyPedometer : NSObject

/**
 * 万歩計（HealthKit）の利用状況の確認
 * @return YES 利用できる場合
 */
+ (BOOL)isAvailable;

/**
 * 万歩計（HealthKit）の利用準備。
 * @param completion コールバック。HealthKitの権限設定画面でキャンセルを選択された場合にFalseを返す。
 * @return なし
 *
 */
- (void)prepareWithCompletion:(void (^)(BOOL authorizationAuthorized))completion;

/**
 * 歩数の書き込み権限の付与
 * @param completion コールバック。HealthKitの権限設定画面でキャンセルを選択された場合にFalseを返す。
 * @return なし
 */
- (void)requestAppendAuthorizationWithCompletion:(void (^)(BOOL cancel))completion;

/**
 * 歩数の書き込み
 * @param count 歩数
 * @param startDate 開始日
 * @param endDate 終了日
 * @param completion コールバック。書き込みに失敗した場合にFalseとエラーメッセージを返す。
 * @return なし
 */
- (void)appendStepCount:(NSUInteger)count startDate:(NSDate *)startDate endDate:(NSDate *)endDate completion:(void(^)(BOOL success, NSString *message))completion;

/**
 * 歩数の取得
 * @param startDate 開始日
 * @param endDate 終了日
 * @param limit 取得件数
 * @param resultsHandler コールバック。
 * @return なし
 */
- (void)fetchStepCountStartDate:(NSDate *)startDate endDate:(NSDate *)endDate limit:(NSUInteger)limit resultsHandler:(void(^)(NSArray *results, NSString *message))resultsHandler;

/**
 * 歩数の取得（件数指定なし）
 * @param startDate 開始日
 * @param endDate 終了日
 * @param resultsHandler コールバック。
 * @return なし
 */
- (void)fetchStepCountStartDate:(NSDate *)startDate endDate:(NSDate *)endDate resultsHandler:(void(^)(NSArray *results, NSString *message))resultsHandler;

/**
 * 統計歩数の取得
 * @param startDate 開始日
 * @param endDate 終了日
 * @param components 間隔
 * @param resultsHandler コールバック。
 * @return なし
 */
- (void)fetchStatisticsStepCountStartDate:(NSDate *)startDate endDate:(NSDate *)endDate options:(MyPedometerStatisticsOptions)options components:(NSDateComponents *)components resultsHandler:(void(^)(HKStatisticsCollection *result, NSString *message))resultsHandler;

@end
