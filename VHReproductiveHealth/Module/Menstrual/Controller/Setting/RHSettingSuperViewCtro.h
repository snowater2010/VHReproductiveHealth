//
//  RHSettingSuperViewCtro.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHRootViewCtro.h"

@interface RHSettingSuperViewCtro : RHRootViewCtro

@property(nonatomic, assign) CGFloat settingHeight;
@property(nonatomic, strong) UIView *contentView;

- (void)doConfirm;
+ (NSString *)getSignNameWithValue:(NSInteger)value;

@end
