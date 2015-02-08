//
//  RHMenstrualDataManger.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHBiaoZhuModel.h"

@interface RHMenstrualDataManger : NSObject

+ (instancetype)sharedInstance;

- (RHBiaoZhuModel *)queryBiaoZhu:(NSDate *)date;
- (void)insertBiaoZhu:(RHBiaoZhuModel *)biaozhu;
- (void)updateBiaoZhu:(RHBiaoZhuModel *)biaozhu;

- (void)closeDB;

@end
