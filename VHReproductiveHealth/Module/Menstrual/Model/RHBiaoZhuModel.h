//
//  RHBiaoZhuModel.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SettingTypeNone,
    SettingType1,
    SettingType2,
    SettingType3,
    SettingType4,
    SettingType5,
    SettingType6,
    SettingType7,
    SettingType8,
    SettingType9,
    SettingType10,
    SettingType11,
    SettingType12,
    SettingType13,
    SettingType14
} SettingType;

@interface RHBiaoZhuModel : NSObject

@property(nonatomic, assign) NSInteger tid;
@property(nonatomic, assign) long calendar;
@property(nonatomic, assign) NSInteger tongfang;
@property(nonatomic, assign) NSInteger jiandang;
@property(nonatomic, assign) NSInteger jinzhouqi;
@property(nonatomic, assign) NSInteger jianceBchao;
@property(nonatomic, assign) NSInteger nanfangzhunbei;
@property(nonatomic, assign) NSInteger dayezhen;
@property(nonatomic, assign) NSInteger quruan;
@property(nonatomic, assign) NSInteger yizhi;
@property(nonatomic, assign) NSInteger dongpeixufei;
@property(nonatomic, assign) NSInteger xiaohuipeitai;
@property(nonatomic, strong) NSString *bushufu;

- (instancetype)initWithDate:(NSDate *)date;
+ (NSArray *)getSettingInfo;
- (NSArray *)getBiaozhuImages;

@end
