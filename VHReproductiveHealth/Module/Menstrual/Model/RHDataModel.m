//
//  RHDataModel.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/9.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHDataModel.h"

@implementation RHDataModel

- (instancetype)init {
    if (self = [super init]) {
        _date = nil;
        _isDayima = NO;
        _biaozhu = [[RHBiaoZhuModel alloc] init];
    }
    return self;
}

- (instancetype)initWithDate:(NSDate *)date {
    if (self = [super init]) {
        _date = date;
        _isDayima = NO;
        _biaozhu = [[RHBiaoZhuModel alloc] initWithDate:_date];
    }
    return self;
}

@end
