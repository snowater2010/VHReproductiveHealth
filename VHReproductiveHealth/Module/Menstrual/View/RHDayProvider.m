//
//  RHDayProvider.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/10.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHDayProvider.h"

@implementation RHDayProvider

- (ABCalendarPickerAnimation)animationForPrev {
    return ABCalendarPickerAnimationScrollLeft;
}
- (ABCalendarPickerAnimation)animationForNext {
    return ABCalendarPickerAnimationScrollRight;
}

- (ABCalendarPickerAnimation)animationForLongPrev {
    return ABCalendarPickerAnimationNone;
}
- (ABCalendarPickerAnimation)animationForLongNext {
    return ABCalendarPickerAnimationNone;
}

@end
