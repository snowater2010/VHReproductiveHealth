//
//  RHDataModel.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/9.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHBiaoZhuModel.h"

@interface RHDataModel : NSObject

@property(nonatomic, assign) BOOL isDayima;
@property(nonatomic, strong) RHBiaoZhuModel *biaozhu;
@property(nonatomic, strong) NSDate *date;

- (instancetype)initWithDate:(NSDate *)date;

@end
