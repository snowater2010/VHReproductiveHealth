//
//  RHSettingTongfangViewCtro.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingSuperViewCtro.h"

@interface RHSettingTongfangViewCtro : RHSettingSuperViewCtro

@property(nonatomic, assign) NSInteger tongfang;
@property(nonatomic, strong) BlockInteger settingBlock;
@property(nonatomic, strong) BlockVoid analyzeBlock;

@end
