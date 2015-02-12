//
//  RHBiaoZhuModel.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHBiaoZhuModel.h"
#import "RHSettingCell.h"

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
    _xiaohuipeitai = -1;
}

+ (NSArray *)getSettingInfo {
    return @[
             @{@"type" : @(CellType3), @"image" : @"yimalaile", @"title" : @"大姨妈来了", @"setting" : @(SettingType1)},
             @{@"type" : @(CellType1), @"image" : @"tongfang", @"title" : @"同房", @"setting" : @(SettingType2)},
             @{@"type" : @(CellType2), @"image" : @"koufubiyunyao", @"title" : @"口服避孕药", @"setting" : @(SettingType3)},
             @{@"type" : @(CellType1), @"image" : @"jiandang", @"title" : @"建档", @"setting" : @(SettingType4)},
             @{@"type" : @(CellType1), @"image" : @"jinzhouqi", @"title" : @"进周期", @"setting" : @(SettingType5)},
             @{@"type" : @(CellType1), @"image" : @"jiancebchao", @"title" : @"检测B超", @"setting" : @(SettingType6)},
             @{@"type" : @(CellType1), @"image" : @"nanfangzhunbei", @"title" : @"男方准备", @"setting" : @(SettingType7)},
             @{@"type" : @(CellType1), @"image" : @"dayezhen", @"title" : @"打夜针", @"setting" : @(SettingType8)},
             @{@"type" : @(CellType1), @"image" : @"quluan", @"title" : @"取卵", @"setting" : @(SettingType9)},
             @{@"type" : @(CellType1), @"image" : @"yizhi", @"title" : @"移植", @"setting" : @(SettingType10)},
             @{@"type" : @(CellType2), @"image" : @"redianliliao", @"title" : @"热电理疗", @"setting" : @(SettingType11)},
             @{@"type" : @(CellType1), @"image" : @"dongpeixufei", @"title" : @"冻胚续费", @"setting" : @(SettingType12)},
             @{@"type" : @(CellType1), @"image" : @"xiaohuipeitai", @"title" : @"销毁胚胎", @"setting" : @(SettingType13)},
             @{@"type" : @(CellType1), @"image" : @"bushufu", @"title" : @"不舒服", @"setting" : @(SettingType14)}];
}

- (NSArray *)getBiaozhuImages {
    NSArray *settingInfo = [RHBiaoZhuModel getSettingInfo];
    NSMutableArray *images = [NSMutableArray array];
    if (self.tongfang > 0) {
        [images addObject:settingInfo[1][@"image"]];
    }
    if (self.jiandang > 0) {
        [images addObject:settingInfo[3][@"image"]];
    }
    if (self.jinzhouqi > 0) {
        [images addObject:settingInfo[4][@"image"]];
    }
    if (self.jianceBchao > 0) {
        [images addObject:settingInfo[5][@"image"]];
    }
    if (self.nanfangzhunbei > 0) {
        [images addObject:settingInfo[6][@"image"]];
    }
    if (self.dayezhen > 0) {
        [images addObject:settingInfo[7][@"image"]];
    }
    if (self.quruan > 0) {
        [images addObject:settingInfo[8][@"image"]];
    }
    if (self.yizhi > 0) {
        [images addObject:settingInfo[9][@"image"]];
    }
    if (self.dongpeixufei.length > 0) {
        [images addObject:settingInfo[11][@"image"]];
    }
    if (self.xiaohuipeitai > 0) {
        [images addObject:settingInfo[12][@"image"]];
    }
    if ([self.bushufu containsString:@"true"]) {
        [images addObject:settingInfo[13][@"image"]];
    }
    return images;
}

@end
