//
//  RHDayimaModel.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHDayimaModel : NSObject

@property(nonatomic, assign) int tid;
@property(nonatomic, assign) long start;
@property(nonatomic, assign) long end;

@property(nonatomic, assign) BOOL isComing;
@property(nonatomic, assign) BOOL state;

@end
