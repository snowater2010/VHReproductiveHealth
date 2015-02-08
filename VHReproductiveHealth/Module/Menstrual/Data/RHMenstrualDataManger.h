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
- (void)insertBiaoZhu:(RHBiaoZhuModel *)biaozhu;
- (void)updateBiaoZhu:(RHBiaoZhuModel *)biaozhu;

- (void)insertDayima:(RHDayimaModel *)model;
- (RHDayimaModel *)queryDayimaStartDate:(NSDate *)start;
- (void)insertDayimaStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
- (void)updateDayima:(RHDayimaModel *)model;

- (void)closeDB;

@end
