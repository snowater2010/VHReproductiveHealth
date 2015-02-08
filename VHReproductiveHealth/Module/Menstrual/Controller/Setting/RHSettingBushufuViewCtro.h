//
//  RHSettingBushufuViewCtro.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingSuperViewCtro.h"

@interface RHSettingBushufuViewCtro : RHSettingSuperViewCtro

@property(nonatomic, strong) NSString *bushufu;
@property(nonatomic, strong) BlockString settingBlock;

+ (NSString *)getSignNameWithText:(NSString *)value;

@end
