//
//  RHSettingMenstrualViewCtro.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/7.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingSuperViewCtro.h"

@interface RHSettingMenstrualViewCtro : RHSettingSuperViewCtro

@property(nonatomic, strong) void (^settingBlock)(NSString *jingqi, NSString *zhouqi);

@end