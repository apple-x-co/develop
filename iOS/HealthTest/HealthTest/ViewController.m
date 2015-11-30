//
//  ViewController.m
//  HealthTest
//
//  Created by Sano Kouhei on 2015/09/10.
//  Copyright (c) 2015年 Sano Kouhei. All rights reserved.
//

#import "ViewController.h"

#import "MyPedometer.h"
#import "MyPedometerData.h"

#import "NSDate+Escort.h"
//#import "FSLineChart.h"
#import "MyPedometerGraph.h"
#import "MyPedometerGraphPlot.h"

@interface ViewController ()

@property (nonatomic, strong) MyPedometer *pedometer;
//@property (nonatomic, strong) FSLineChart *lineChart;
@property (nonatomic, strong) MyPedometerGraph *pedometerChart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addButtons];
    
    self.pedometer = [[MyPedometer alloc] init];
    
//    self.lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 260, [UIScreen mainScreen].bounds.size.width - 40, 166)];
//    self.lineChart.displayDataPoint = YES;
//    self.lineChart.bezierSmoothing = NO;
//    self.lineChart.backgroundColor = [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.0f];
//    [[self view] addSubview:self.lineChart];
    
    self.pedometerChart = [[MyPedometerGraph alloc] initWithFrame:CGRectMake(5, 260, [UIScreen mainScreen].bounds.size.width - 10, 350)];
    [[self view] addSubview:self.pedometerChart.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)addButtons
{
    UIColor *blueColor = [UIColor colorWithRed:0.000 green:0.549 blue:0.890 alpha:1.000];
    
    UIButton *requestFetchAuthorizationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [requestFetchAuthorizationButton setTitle:@"read authorization" forState:UIControlStateNormal];
    [requestFetchAuthorizationButton addTarget:self action:@selector(requestFetchAuthorizationButton:) forControlEvents:UIControlEventTouchUpInside];
    [requestFetchAuthorizationButton setFrame:CGRectMake(10, 50, 150, 36)];
    [[requestFetchAuthorizationButton layer] setBorderColor:[blueColor CGColor]];
    [[requestFetchAuthorizationButton layer] setBorderWidth:1.0];
    [[requestFetchAuthorizationButton layer] setCornerRadius:5.0f];
    [self.view addSubview:requestFetchAuthorizationButton];
    
    UIButton *fetchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [fetchButton setTitle:@"fetch statistics" forState:UIControlStateNormal];
    [fetchButton addTarget:self action:@selector(fetchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [fetchButton setFrame:CGRectMake(10, 100, 150, 36)];
    [[fetchButton layer] setBorderColor:[blueColor CGColor]];
    [[fetchButton layer] setBorderWidth:1.0];
    [[fetchButton layer] setCornerRadius:5.0f];
    [self.view addSubview:fetchButton];
    
    UIButton *requestAppendAuthorizationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [requestAppendAuthorizationButton setTitle:@"write authorization" forState:UIControlStateNormal];
    [requestAppendAuthorizationButton addTarget:self action:@selector(requestAppendAuthorizationButton:) forControlEvents:UIControlEventTouchUpInside];
    [requestAppendAuthorizationButton setFrame:CGRectMake(10, 150, 150, 36)];
    [[requestAppendAuthorizationButton layer] setBorderColor:[blueColor CGColor]];
    [[requestAppendAuthorizationButton layer] setBorderWidth:1.0];
    [[requestAppendAuthorizationButton layer] setCornerRadius:5.0f];
    [self.view addSubview:requestAppendAuthorizationButton];
    
    UIButton *appendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [appendButton setTitle:@"append source" forState:UIControlStateNormal];
    [appendButton addTarget:self action:@selector(appendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [appendButton setFrame:CGRectMake(10, 200, 150, 36)];
    [[appendButton layer] setBorderColor:[blueColor CGColor]];
    [[appendButton layer] setBorderWidth:1.0];
    [[appendButton layer] setCornerRadius:5.0f];
    [self.view addSubview:appendButton];
}

- (void)appendButtonAction:(id)sender
{
    [self.pedometer appendStepCount:1000
                          startDate:[NSDate date]
                            endDate:[NSDate date]
                         completion:^(BOOL success, NSString *message){
                             
                             if (!success) {
                                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"APPEND ERROR"
                                                                                                message:message
                                                                                         preferredStyle:UIAlertControllerStyleAlert];
                                 UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                       style:UIAlertActionStyleDefault
                                                                                     handler:nil];
                                 [alert addAction:alertAction];
                                 [self presentViewController:alert animated:YES completion:nil];
                             }
                             
                         }];
}

- (void)requestAppendAuthorizationButton:(id)sender
{
    [self.pedometer requestAppendAuthorizationWithCompletion:^(BOOL cancel){
        
        if (cancel) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"AUTHORIZATION ERROR"
                                                                           message:@"Did cancel."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:nil];
            [alert addAction:alertAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];
}

- (void)requestFetchAuthorizationButton:(id)sender
{
    [self.pedometer prepareWithCompletion:^(BOOL cancel){
        
        if (cancel) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"AUTHORIZATION ERROR"
                                                                           message:@"Did cancel."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:nil];
            [alert addAction:alertAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];
}

- (void)fetchButtonAction:(id)sender
{
//    [self.pedometer fetchStepCountFromDate:nil
//                                    toDate:nil
//                            resultsHandler:^(NSArray *results, NSString *message){
//                                
//                                for (HKQuantitySample *quantitySample in results) {
//                                    
//                                    MyPedometerData myPedometerData = HKQuantitySampleToMyPedometerData(quantitySample);
//                                    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:myPedometerData.startDate];
//                                    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:myPedometerData.endDate];
//                                    NSLog(@"%f, %@, %@", myPedometerData.count, startDate, endDate);
//
//                                }
//                                
//                            }];
    
    NSDate *startOfMonth = [[NSDate date] dateAtStartOfMonth];
    NSDate *endOfMonth = [[NSDate date] dateAtEndOfMonth];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    //components.hour = 8;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"MM-dd";
    
    [self.pedometer fetchStatisticsStepCountStartDate:startOfMonth
                                              endDate:endOfMonth
                                              options:MyPedometerStatisticsOptionCumulativeSum
                                           components:components
                                       resultsHandler:^(HKStatisticsCollection *result, NSString *message){
                                           
                                           MyPedometerGraphPlot *pedometerGraphPlot = [[MyPedometerGraphPlot alloc] init];
                                           
                                           [result enumerateStatisticsFromDate:startOfMonth toDate:endOfMonth withBlock:^(HKStatistics *result, BOOL *stop) {
                                               
                                               MyPedometerData myPedometerData = HKStatisticsToMyPedometerData(result);
                                               NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:myPedometerData.startDate];
                                               NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:myPedometerData.endDate];
                                               NSLog(@"%f, %@, %@", myPedometerData.count, startDate, endDate);
                                               
                                               [pedometerGraphPlot addLabel:[dateFormatter stringFromDate:startDate] number:[NSNumber numberWithDouble:myPedometerData.count]];
                                               
                                           }];
                                           
                                           [self.pedometerChart setPedometerGraphPlot:pedometerGraphPlot];
                                           
//                                           NSMutableArray *charData = [NSMutableArray array];
//                                           NSMutableArray *months = [NSMutableArray array];
//                                           
//                                           [result enumerateStatisticsFromDate:startOfMonth toDate:endOfMonth withBlock:^(HKStatistics *result, BOOL *stop) {
//
//                                                MyPedometerData myPedometerData = HKStatisticsToMyPedometerData(result);
//                                                NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:myPedometerData.startDate];
//                                                NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:myPedometerData.endDate];
//                                                NSLog(@"%f, %@, %@", myPedometerData.count, startDate, endDate);
//                                               
//                                               [charData addObject:[NSNumber numberWithDouble:myPedometerData.count]];
//                                               [months addObject:[dateFormatter stringFromDate:startDate]];
//                                               
//                                               
//                                            }];
//                                           
//                                           [self setChartData:charData months:months];
                                           
                                       }];
    
}

//- (void)setChartData:(NSArray *)chartData months:(NSArray *)months
//{
//    [self.lineChart clearChartData];
//    
//    self.lineChart.labelForIndex = ^(NSUInteger item) {
//        return months[item];
//    };
//    
//    self.lineChart.labelForValue = ^(CGFloat value) {
//        return [NSString stringWithFormat:@"%d", (unsigned int)value];
//    };
//    
//    [self.lineChart setChartData:chartData];
//}

@end
