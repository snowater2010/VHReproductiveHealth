//
//  RHMenstrualDataHelper.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/1.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHMenstrualDataHelper.h"

@implementation RHMenstrualDataHelper

+ (RHMenstrualDataHelper*)sharedInstance
{
    static RHMenstrualDataHelper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RHMenstrualDataHelper alloc] init];
    });
    
    return _sharedInstance;
}

@end
