//
//  RHSettingCell3.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingCell2.h"

@interface RHSettingCell3 : RHSettingCell2

@property(nonatomic, strong) BlockVoid analysisBlock;
@property(nonatomic, strong) BlockVoid settingBlock;

- (void)setTitleJingqi:(NSInteger)jingqi zhouqi:(NSInteger)zhouqi;

@end
