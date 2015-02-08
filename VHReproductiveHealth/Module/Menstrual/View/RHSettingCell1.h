//
//  RHSettingCell1.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/4.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHSettingCell.h"
#import "RHMenstrualViewCtro.h"

typedef void (^BlockSetting)(SettingType type);

@protocol SettingCell1Delegate <NSObject>

- (void)doAction:(SettingType)type;

@end

@interface RHSettingCell1 : RHSettingCell

@property(nonatomic, assign) SettingType settingType;

@property(nonatomic, strong) BlockSetting actionBlock;

@property(nonatomic, weak) id<SettingCell1Delegate> delegate;

@end
