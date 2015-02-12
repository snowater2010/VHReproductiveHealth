//
//  RHSettingCell1.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/4.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHSettingCell.h"
#import "RHBiaoZhuModel.h"

@interface RHSettingCell1 : RHSettingCell

@property(nonatomic, assign) SettingType settingType;

@property(nonatomic, strong) BlockVoid actionBlock;

@property(nonatomic, strong) UIButton *signButton;

- (void)setBiaozhu:(NSString *)biaozhu;

@end
