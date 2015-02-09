//
//  RHStyleProvider.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/9.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHStyleProvider.h"
#import "RHCalendarCell.h"

@implementation RHStyleProvider

- (UIFont *)columnFont
{
    return [UIFont boldSystemFontOfSize:10.0f];
}

- (UIColor *)textColor
{
    return COLOR_TEXT_DGREEN;
}

- (UIColor *)textShadowColor
{
    return [UIColor clearColor];
}

- (UIImage *)patternImageForGradientBar
{
    return [UIImage imageNamed:@"calendar_bg"];
}

- (UIControl*)calendarPicker:(ABCalendarPicker*)calendarPicker
                  buttonDate:(NSDate *)date
            cellViewForTitle:(NSString*)cellTitle
                    andState:(ABCalendarPickerState)state
{
    RHCalendarCell *cell = [[RHCalendarCell alloc] init];
    cell.number = cellTitle;
    cell.date = date;
    
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [COLOR_DGREEN CGColor];
    cell.backgroundColor = COLOR_BG_WHITE;
    
    return cell;
}

@end
