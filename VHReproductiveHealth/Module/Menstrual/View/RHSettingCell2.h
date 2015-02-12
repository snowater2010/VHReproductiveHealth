//
//  RHSettingCell2.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/4.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHSettingCell.h"

@interface RHSettingCell2 : RHSettingCell

@property(nonatomic, strong) UIColor *segmentColor;
@property(nonatomic, assign) BOOL segmentState;
@property(nonatomic, strong) UISegmentedControl *segment;
@property(nonatomic, strong) BlockBool actionBlock;

@end
