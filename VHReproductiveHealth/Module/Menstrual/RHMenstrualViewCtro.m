//
//  RHMenstrualViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/1/27.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHMenstrualViewCtro.h"
#import "JTCalendar.h"

@interface RHMenstrualViewCtro () <JTCalendarDataSource>

@property (strong, nonatomic) JTCalendar *calendar;
@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTCalendarContentView *calendarContentView;

@end

@implementation RHMenstrualViewCtro

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.calendar = [[JTCalendar alloc] init];
    
    self.calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    [self.view addSubview:self.calendarMenuView];
    
    self.calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(0, 50, self.view.width, 300)];
    [self.view addSubview:self.calendarContentView];
    
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date {
    return (rand() % 10) == 1;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date {
    NSLog(@"Date: %@", date);
}



@end
