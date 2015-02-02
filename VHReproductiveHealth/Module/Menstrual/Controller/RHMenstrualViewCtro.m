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

@property (nonatomic, strong) JTCalendar *calendar;
@property (nonatomic, strong) JTCalendarMenuView *calendarMenuView;
@property (nonatomic, strong) JTCalendarContentView *calendarContentView;

@property (nonatomic, strong) NSArray *tipArray;

@end

@implementation RHMenstrualViewCtro

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"周期经历";
    
    [self initData];
    [self makePageUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.calendar reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user method

- (void)initData {
    self.tipArray = @[@{@"name" : @"月经", @"color" : @"5CA2D3", @"image" : @"menses_acyeterion"},
                      @{@"name" : @"同房", @"color" : @"74A14C", @"image" : @"menses_havesex"},
                      @{@"name" : @"口服避孕药", @"color" : @"5CA2D3", @"image" : @"menses_acyeterion"},
                      @{@"name" : @"进周期", @"color" : @"74A14C", @"image" : @"menses_havesex"},
                      @{@"name" : @"检测B超", @"color" : @"5CA2D3", @"image" : @"menses_acyeterion"},
                      @{@"name" : @"月经", @"color" : @"5CA2D3", @"image" : @"menses_acyeterion"},
                      @{@"name" : @"同房", @"color" : @"74A14C", @"image" : @"menses_havesex"},
                      @{@"name" : @"口服避孕药", @"color" : @"5CA2D3", @"image" : @"menses_acyeterion"},
                      @{@"name" : @"进周期", @"color" : @"74A14C", @"image" : @"menses_havesex"},
                      @{@"name" : @"检测B超", @"color" : @"5CA2D3", @"image" : @"menses_acyeterion"}];
    
    
}

- (void)makePageUI {
    [self makeCalendarView];
    [self makeTipView];
}

- (void)makeTipView {
    UIScrollView *tipView = [[UIScrollView alloc] init];
    tipView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tipView];
    [[tipView setW:self.view.width andH:31] outsideBottomEdgeOf:self.calendarContentView by:4];
    tipView.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat imageSize = tipView.height/3;
    CGFloat padding1 = 6;
    CGFloat padding2 = 10;
    
    int tipLength = 0;
    for (NSDictionary *tipDic in self.tipArray) {
        NSString *color = tipDic[@"color"];
        
        UIImage *image = [UIImage imageNamed:tipDic[@"image"]];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = tipDic[@"name"];
        nameLabel.font = FONT_12;
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.textColor = UIColorFromRGB(color.intValue);
        
        [tipView addSubview:imageView];
        [tipView addSubview:nameLabel];
        
        CGSize textSize = [nameLabel.text sizeWithAttributes:@{NSFontAttributeName : nameLabel.font}];
        
        [[[imageView setW:imageSize andH:imageSize] setX:tipLength+padding2] centerYWith:tipView];
        [[[nameLabel setSizeFromSize:textSize] outsideRightEdgeOf:imageView by:padding1] centerYWith:tipView];
        
        tipLength = nameLabel.maxX;
    }
    
    tipView.contentSize = CGSizeMake(tipLength+padding2, tipView.contentSize.height);
}

- (void)makeCalendarView {
    
    self.calendar = [[JTCalendar alloc] init];
    
    // creat ui
    self.calendarMenuView = [[JTCalendarMenuView alloc] init];
    self.calendarMenuView.backgroundColor = COLOR_BG_LGREEN;
    [self.view addSubview:self.calendarMenuView];
    
    self.calendarContentView = [[JTCalendarContentView alloc] init];
    self.calendarContentView.backgroundColor = COLOR_BG_WHITE;
    [self.view addSubview:self.calendarContentView];
    
    // layout ui
    [[self.calendarMenuView setW:self.view.width andH:50] insideTopEdgeBy:0];
    [[self.calendarContentView setW:self.view.width andH:300] outsideBottomEdgeOf:self.calendarMenuView by:0];
    
    // calendar appearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 0. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
        self.calendar.calendarAppearance.focusSelectedDayChangeMode = YES;
        
        self.calendar.calendarAppearance.menuMonthTextColor = COLOR_TEXT_DGREEN;
        self.calendar.calendarAppearance.menuMonthTextFont = FONT_20B;
        
        self.calendar.calendarAppearance.dayBorderWidth = 1;
        self.calendar.calendarAppearance.dayBorderColor = COLOR_BG_DGREEN;
        
        self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, JTCalendar *jt_calendar){
            NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
            [fmt setDateFormat:@"yyyy年MM月"];
            return [fmt stringFromDate:date];
        };
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date {
    return (rand() % 10) == 1;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date {
    NSLog(@"Date: %@", date);
}

@end
