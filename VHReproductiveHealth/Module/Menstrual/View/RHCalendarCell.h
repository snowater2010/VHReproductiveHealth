//
//  RHCalendarCell.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/9.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHDataModel.h"

@interface RHCalendarCell : UIControl

@property(nonatomic, strong) NSString *number;
@property(nonatomic, strong) NSDate *date;
@property(nonatomic, strong) RHDataModel *dataModel;

- (void)setImageArray:(NSArray *)array;
- (void)setDayimaBg:(BOOL)isDayima;

- (void)setSelectedStyle:(BOOL)isSelected;

@end
