//
//  RHTontFangGraphView.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/11.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHBarGraphView.h"

@interface RHTontFangGraphView : RHBarGraphView

@property(nonatomic, strong) NSArray *yuejingRange;
@property(nonatomic, strong) NSArray *pailuanRange;

@property(nonatomic, strong) NSArray *paiLuanIndexs;
@property(nonatomic, strong) NSArray *tongfangDatas;

@property(nonatomic, strong) NSArray *chartTongFang;

@end
