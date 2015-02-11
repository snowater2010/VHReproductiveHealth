//
//  RHMenstrualDataManger.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHBiaoZhuModel.h"
#import "RHDayimaModel.h"

@interface RHMenstrualDataManger : NSObject

+ (instancetype)sharedInstance;

- (RHBiaoZhuModel *)queryBiaoZhu:(NSDate *)date;
- (NSArray *)queryBiaoZhuStartDate:(NSDate *)strDate endDate:(NSDate *)endDate;
- (void)insertBiaoZhu:(RHBiaoZhuModel *)biaozhu;
- (void)updateBiaoZhu:(RHBiaoZhuModel *)biaozhu;

- (void)insertDayima:(RHDayimaModel *)model;
- (RHDayimaModel *)queryDayimaStartDate:(NSDate *)start;
- (NSArray *)queryDayimaStartDate:(NSDate *)start endDate:(NSDate *)end;
- (void)insertDayimaStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
- (void)deleteDayimaWithDate:(NSDate *)startDate;
- (void)updateDayimaEndDate:(NSDate *)endDate withDate:(NSDate *)date;

- (RHDayimaModel *)queryLastDayimaByDate:(NSDate *)date;

- (NSArray *)queryDayima;
//- (NSArray *)queryLast2MonthTongFang;

- (void)closeDB;

+ (NSDate *)dateFirstAtMonth:(NSDate *)date;
+ (NSDate *)dateLastAtMonth:(NSDate *)date;

- (NSArray *)getMonthData:(NSDate *)date;

@end
