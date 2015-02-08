//
//  RHMenstrualViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/1/27.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHMenstrualViewCtro.h"
#import "JTCalendar.h"
#import "ABCalendarPicker.h"
#import "RHSettingCell.h"
#import "RHSettingCell1.h"
#import "RHSettingCell2.h"
#import "RHSettingCell3.h"

#import "RHSettingMenstrualViewCtro.h"
#import "RHSettingTongfangViewCtro.h"
#import "RHSettingQuluanViewCtro.h"
#import "RHSettingYizhiViewCtro.h"
#import "RHSettingDpxfViewCtro.h"
#import "RHSettingBushufuViewCtro.h"

@interface RHMenstrualViewCtro () <JTCalendarDataSource, UITableViewDataSource, UITableViewDelegate, ABCalendarPickerDelegateProtocol, SettingCell1Delegate>

@property (nonatomic, strong) JTCalendar *calendar;
@property (nonatomic, strong) JTCalendarMenuView *calendarMenuView;
@property (nonatomic, strong) JTCalendarContentView *calendarContentView;

@property (nonatomic, strong) ABCalendarPicker *datePicker;

@property (nonatomic, strong) NSArray *tipArray;
@property (nonatomic, strong) UIScrollView *tipView;
@property (nonatomic, strong) UITableView *settingView;

@property (nonatomic, strong) NSArray *settingArray;

@end

@implementation RHMenstrualViewCtro

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"周期经历";
    
    [self initData];
    [self initUIView];
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
    
    self.settingArray = @[
        @{@"type" : @(CellType3), @"image" : @"yimalaile", @"title" : @"姨妈来了", @"setting" : @(SettingType1)},
        @{@"type" : @(CellType1), @"image" : @"tongfang", @"title" : @"同房", @"setting" : @(SettingType2)},
        @{@"type" : @(CellType2), @"image" : @"koufubiyunyao", @"title" : @"口服避孕药", @"setting" : @(SettingType3)},
        @{@"type" : @(CellType1), @"image" : @"jiandang", @"title" : @"建档", @"setting" : @(SettingType4)},
        @{@"type" : @(CellType1), @"image" : @"jinzhouqi", @"title" : @"进周期", @"setting" : @(SettingType5)},
        @{@"type" : @(CellType1), @"image" : @"jiancebchao", @"title" : @"检测B超", @"setting" : @(SettingType6)},
        @{@"type" : @(CellType1), @"image" : @"nanfangzhunbei", @"title" : @"男方准备", @"setting" : @(SettingType7)},
        @{@"type" : @(CellType1), @"image" : @"dayezhen", @"title" : @"打夜针", @"setting" : @(SettingType8)},
        
        @{@"type" : @(CellType1), @"image" : @"quluan", @"title" : @"取卵", @"setting" : @(SettingType9)},
        @{@"type" : @(CellType1), @"image" : @"yizhi", @"title" : @"移植", @"setting" : @(SettingType10)},
        
        @{@"type" : @(CellType2), @"image" : @"redianliliao", @"title" : @"热电理疗", @"setting" : @(SettingType11)},
        @{@"type" : @(CellType1), @"image" : @"dongpeixufei", @"title" : @"冻胚续费", @"setting" : @(SettingType12)},
        @{@"type" : @(CellType1), @"image" : @"xiaohuipeitai", @"title" : @"销毁胚胎", @"setting" : @(SettingType13)},
        @{@"type" : @(CellType1), @"image" : @"bushufu", @"title" : @"不舒服", @"setting" : @(SettingType14)}];
}

- (void)initUIView {
    [self makeCalendarView];
    [self makeTipView];
    [self makeSettingView];
}

- (void)makeSettingView {
    self.settingView = [[UITableView alloc] init];
    [self.view addSubview:self.settingView];
    [[self.settingView setW:self.view.width andH:self.view.height-self.tipView.maxY-4] outsideBottomEdgeOf:self.tipView by:4];
    
    self.settingView.dataSource = self;
    self.settingView.delegate = self;
}

- (void)makeTipView {
    self.tipView = [[UIScrollView alloc] init];
    [self.view addSubview:self.tipView];
    [[self.tipView setW:self.view.width andH:31] outsideBottomEdgeOf:self.datePicker by:4];
    
    self.tipView.showsHorizontalScrollIndicator = NO;
    self.tipView.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat imageSize = self.tipView.height/3;
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
        
        [self.tipView addSubview:imageView];
        [self.tipView addSubview:nameLabel];
        
        CGSize textSize = [nameLabel.text sizeWithAttributes:@{NSFontAttributeName : nameLabel.font}];
        
        [[[imageView setW:imageSize andH:imageSize] setX:tipLength+padding2] centerYWith:self.tipView];
        [[[nameLabel setSizeFromSize:textSize] outsideRightEdgeOf:imageView by:padding1] centerYWith:self.tipView];
        
        tipLength = nameLabel.maxX;
    }
    
    self.tipView.contentSize = CGSizeMake(tipLength+padding2, self.tipView.contentSize.height);
}

- (void)makeCalendarView {
    // 日期控件
    self.datePicker = [[ABCalendarPicker alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 240)];
    [self.view addSubview:self.datePicker];
    
    self.datePicker.delegate = self;
}


#pragma mark - ABCalendarPickerDelegateProtocol
- (void)calendarPicker:(ABCalendarPicker*)calendarPicker animateNewHeight:(CGFloat)height {
    [self.tipView outsideBottomEdgeOf:self.datePicker by:4];
    
    [[self.settingView setH:self.view.height-self.tipView.maxY-4] outsideBottomEdgeOf:self.tipView by:4];
    
}

//- (void)makeCalendarView {
//    
//    self.calendar = [[JTCalendar alloc] init];
//    
//    // creat ui
//    self.calendarMenuView = [[JTCalendarMenuView alloc] init];
//    self.calendarMenuView.backgroundColor = COLOR_BG_LGREEN;
//    [self.view addSubview:self.calendarMenuView];
//    
//    self.calendarContentView = [[JTCalendarContentView alloc] init];
//    self.calendarContentView.backgroundColor = COLOR_BG_WHITE;
//    [self.view addSubview:self.calendarContentView];
//    
//    // layout ui
//    [[self.calendarMenuView setW:self.view.width andH:50] insideTopEdgeBy:0];
//    [[self.calendarContentView setW:self.view.width andH:300] outsideBottomEdgeOf:self.calendarMenuView by:0];
//    
//    // calendar appearance
//    {
//        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
//        self.calendar.calendarAppearance.dayCircleRatio = 0. / 10.;
//        self.calendar.calendarAppearance.ratioContentMenu = 1.;
//        self.calendar.calendarAppearance.focusSelectedDayChangeMode = YES;
//        
//        self.calendar.calendarAppearance.menuMonthTextColor = COLOR_TEXT_DGREEN;
//        self.calendar.calendarAppearance.menuMonthTextFont = FONT_20B;
//        
//        self.calendar.calendarAppearance.dayBorderWidth = 1;
//        self.calendar.calendarAppearance.dayBorderColor = COLOR_BG_DGREEN;
//        
//        self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, JTCalendar *jt_calendar){
//            NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
//            [fmt setDateFormat:@"yyyy年MM月"];
//            return [fmt stringFromDate:date];
//        };
//    }
//    
//    [self.calendar setMenuMonthsView:self.calendarMenuView];
//    [self.calendar setContentView:self.calendarContentView];
//    [self.calendar setDataSource:self];
//    
//}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date {
    return (rand() % 10) == 1;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date {
    NSLog(@"Date: %@", date);
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }
    else {
        return 50;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAK_INSTANCE(self);
    
    NSDictionary *cellDic = self.settingArray[indexPath.row];
    
    static NSString *cellType = @"cellType";
    static NSString *cellType1 = @"cellType1";
    static NSString *cellType2 = @"cellType2";
    static NSString *cellType3 = @"cellType3";
    
    RHSettingCell *cell = nil;
    if (((NSNumber *)cellDic[@"type"]).intValue == CellType3) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellType3];
        if (!cell) {
            cell = [[RHSettingCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType3];
        }
        RHSettingCell3 *cell3 = (RHSettingCell3 *)cell;
        WEAK_INSTANCE(cell3)
        cell3.actionBlock = ^(BOOL isStart) {
            
        };
        cell3.analysisBlock = ^() {
            
        };
        cell3.settingBlock = ^() {
            RHSettingMenstrualViewCtro *ctro = [[RHSettingMenstrualViewCtro alloc] init];
            ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [weakself presentViewController:ctro animated:YES completion:^{
                ctro.settingBlock = ^(NSString *jingqi, NSString *zhouqi) {
                    if (jingqi && jingqi.length > 0) {
                        gJingqi = jingqi.intValue;
                    }
                    if (zhouqi && zhouqi.length > 0) {
                        gZhouqi = zhouqi.intValue;
                    }
                    if (gJingqi > 0 && gZhouqi > 0) {
                        [weakcell3 setTitleJingqi:gJingqi zhouqi:gZhouqi];
                    }
                };
            }];
        };
    }
    else if (((NSNumber *)cellDic[@"type"]).intValue == CellType1) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellType1];
        if (!cell) {
            cell = [[RHSettingCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType1];
        }
        
        RHSettingCell1 *cell1 = (RHSettingCell1 *)cell;
        cell1.settingType = ((NSNumber *)cellDic[@"setting"]).intValue;
        cell1.delegate = self;
        cell1.actionBlock = ^(SettingType type) {
            if (type == SettingType2) {
                // 同房
                RHSettingTongfangViewCtro *ctro = [[RHSettingTongfangViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSInteger row) {
                        
                    };
                }];
            }
            else if (type == SettingType4) {
                // 建档
            }
            else if (type == SettingType5) {
                // 进周期
            }
            else if (type == SettingType6) {
                // 检测B超
            }
            else if (type == SettingType7) {
                // 男方准备
            }
            else if (type == SettingType8) {
                // 打夜针
            }
            else if (type == SettingType9) {
                // 取卵
                RHSettingQuluanViewCtro *ctro = [[RHSettingQuluanViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSInteger number) {
                        
                    };
                }];
            }
            else if (type == SettingType10) {
                // 移植
                RHSettingYizhiViewCtro *ctro = [[RHSettingYizhiViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSInteger number) {
                        
                    };
                }];
            }
            else if (type == SettingType12) {
                // 冻胚续费
                RHSettingDpxfViewCtro *ctro = [[RHSettingDpxfViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [weakself presentViewController:ctro animated:YES completion:^{
                    
                }];
            }
            else if (type == SettingType13) {
                // 胚胎销毁
                
            }
            else if (type == SettingType14) {
                // 不舒服
                RHSettingBushufuViewCtro *ctro = [[RHSettingBushufuViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [weakself presentViewController:ctro animated:YES completion:^{
                    
                }];
            }
        };
    }
    else if (((NSNumber *)cellDic[@"type"]).intValue == CellType2) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellType2];
        if (!cell) {
            cell = [[RHSettingCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType2];
        }
        RHSettingCell2 *cell2 = (RHSettingCell2 *)cell;
        cell2.actionBlock = ^(BOOL isStart) {
            
        };
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (!cell) {
            cell = [[RHSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
        }
    }
    
    cell.cellImage = cellDic[@"image"];
    cell.cellTitle = cellDic[@"title"];
    
    return cell;
}

- (void)doAction:(SettingType)type {
    switch (type) {
        case SettingType2:
        {
            RHSettingMenstrualViewCtro *ctro = [[RHSettingMenstrualViewCtro alloc] init];
            ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:ctro animated:YES completion:^{
                
            }];
        }
            break;
            
        default:
            break;
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.row) {
//        case 0:
//            
//            break;
//        case 1:
//            
//            break;
//        default:
//            break;
//    }
//}

@end
