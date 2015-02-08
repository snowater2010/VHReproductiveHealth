//
//  RHCalendarCell.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/9.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMyButton.h"

typedef enum {
    DayimaBegin,
    DayimaEnd
} DayimaState;

@interface RHCalendarCell : UIControl

@property(nonatomic, strong) NSString *number;

- (void)setImageArray:(NSArray *)array;
- (void)setDayimaImage:(DayimaState)state;
- (void)setDayimaBg:(BOOL)isDayima;

@end
