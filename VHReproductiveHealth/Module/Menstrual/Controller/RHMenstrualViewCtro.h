//
//  RHMenstrualViewCtro.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/1/27.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHRootViewCtro.h"

#define USER_DEFAULT_JINGQI @"rh_jingqi"
#define USER_DEFAULT_ZHOUQI @"rh_zhouqi"

#define DefaultJingqi 5
#define DefaultZhouqi 30

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

@interface RHMenstrualViewCtro : RHRootViewCtro

@end
