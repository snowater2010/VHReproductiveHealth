//
//  RHBiaoZhuModel.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHBiaoZhuModel.h"

@implementation RHBiaoZhuModel

- (instancetype)init {
    if (self = [super init]) {
        [self initSet];
    }
    return self;
}

- (instancetype)initWithDate:(NSDate *)date {
    if (self = [super init]) {
        [self initSet];
        _calendar = [date timeIntervalSince1970] * 1000;
    }
    return self;
}

- (void)initSet {
    _tongfang = -1;
    _jiandang = -1;
    _jinzhouqi = -1;
    _jianceBchao = -1;
    _nanfangzhunbei = -1;
    _dayezhen = -1;
    _quruan = -1;
    _yizhi = -1;
    _dongpeixufei = -1;
    _xiaohuipeitai = -1;
}

@end
