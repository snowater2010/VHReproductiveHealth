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
#import "RHMenstrualDataManger.h"

#import "RHBiaoZhuModel.h"
#import "RHStyleProvider.h"
#import "RHCalendarCell.h"
#import "RHDataModel.h"

#define DefaultDateFormat @"yyyy-MM-dd"

@interface RHMenstrualViewCtro () <UITableViewDataSource, UITableViewDelegate, ABCalendarPickerDelegateProtocol>
{
}
@property(nonatomic, assign) NSInteger jingqi;
@property(nonatomic, assign) NSInteger zhouqi;

@property (nonatomic, strong) ABCalendarPicker *datePicker;

@property (nonatomic, strong) UIScrollView *tipView;
@property (nonatomic, strong) UITableView *settingView;

@property (nonatomic, strong) NSArray *settingArray;

@property (nonatomic, strong) NSDate *currDate;
@property (nonatomic, strong) RHMenstrualDataManger *dataManager;
@property (nonatomic, strong) RHBiaoZhuModel *biaozhuModel;
@property (nonatomic, strong) NSArray *monthData;

@property (nonatomic, strong) RHStyleProvider *styleProvider;
@property (nonatomic, strong) NSMutableDictionary *controlDic;

@end

@implementation RHMenstrualViewCtro

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"周期经历";
    
    [self initData];
    [self initUIView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_dataManager closeDB];
}

#pragma mark - user method

- (void)initData {
    
    self.controlDic = [NSMutableDictionary dictionary];
    
    self.settingArray = @[
        @{@"type" : @(CellType3), @"image" : @"yimalaile", @"title" : @"大姨妈来了", @"setting" : @(SettingType1)},
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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _jingqi = [defaults integerForKey:USER_DEFAULT_JINGQI];
    _zhouqi = [defaults integerForKey:USER_DEFAULT_ZHOUQI];
    if (_jingqi == 0) {
        _jingqi = DefaultJingqi;
        [defaults setInteger:DefaultJingqi forKey:USER_DEFAULT_JINGQI];
    }
    if (_zhouqi == 0) {
        _zhouqi = DefaultZhouqi;
        [defaults setInteger:DefaultZhouqi forKey:USER_DEFAULT_ZHOUQI];
    }
    
    self.dataManager = [RHMenstrualDataManger sharedInstance];
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
    self.tipView.backgroundColor = COLOR_BG_WHITE;
    
    CGFloat imageSize = self.tipView.height * 0.5;
    CGFloat padding1 = 6;
    CGFloat padding2 = 10;
    
    int tipLength = 0;
    for (NSDictionary *tipDic in self.settingArray) {
        CellType cellType = ((NSNumber *)tipDic[@"type"]).intValue;
        if (cellType != CellType1) {
            continue;
        }
        
        UIImage *image = [UIImage imageNamed:tipDic[@"image"]];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = tipDic[@"title"];
        nameLabel.font = FONT_12;
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.textColor = COLOR_TEXT_BLACK;
        
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
    
    self.styleProvider =[[RHStyleProvider alloc] init];
    self.datePicker.styleProvider = _styleProvider;
    self.datePicker.weekdaysProvider = [[ABCalendarPickerDefaultWeekdaysProvider alloc] init];
}

#pragma mark - ABCalendarPickerDelegateProtocol
- (void)calendarPicker:(ABCalendarPicker*)calendarPicker animateNewHeight:(CGFloat)height {
    [self.tipView outsideBottomEdgeOf:self.datePicker by:4];
    [[self.settingView setH:self.view.height-self.tipView.maxY-4] outsideBottomEdgeOf:self.tipView by:4];
    
    [self refreshCellCache];
    [self refreshCalendar];
}

- (void)calendarPicker:(ABCalendarPicker*)calendarPicker controlSelected:(UIControl*)control dateSelected:(NSDate*)date withState:(ABCalendarPickerState)state {
    // 判断翻页，查询数据
    BOOL isNewPage = !(_currDate && (_currDate.year == date.year) && (_currDate.month == date.month));
    self.currDate = [date dateAtBeginningOfDay];
    
    if (isNewPage) {
        [self refreshData];
        [self refreshCalendar];
    }
    
    RHDataModel *model = self.monthData[_currDate.day-1];
    self.biaozhuModel = model.biaozhu;
    
    [self refreshSetting];
}

- (void)refreshData {
    self.monthData = [_dataManager getMonthData:_currDate];
    [self refreshCellCache];
}

- (void)refreshCellCache {
    [_controlDic removeAllObjects];
    for (int i = 0; i < self.datePicker.controls.count; i++) {
        NSArray *arr = self.datePicker.controls[i];
        for (int j = 0; j < arr.count; j++) {
            RHCalendarCell *cell = (RHCalendarCell *)arr[j];
            [_controlDic setObject:cell forKey:[cell.date stringWithFormat:DefaultDateFormat]];
        }
    }
}

- (void)refreshCalendar {
    for (RHDataModel *model in self.monthData) {
        RHCalendarCell *cell = [_controlDic objectForKey:[model.date stringWithFormat:DefaultDateFormat]];
        if (model.isDayima) {
            cell.backgroundColor = COLOR_BG_PINK;
        }
        else {
            cell.backgroundColor = COLOR_BG_WHITE;
        }
    }
}

- (void)refreshSetting {
    [self.settingView reloadData];
}

#pragma mark - date view

- (void)settingDayima {
    NSDate *endDate = [_currDate dateByAddingDays:_jingqi];
    [_dataManager insertDayimaStartDate:_currDate endDate:endDate];
    
    [self refreshData];
    [self refreshCalendar];
    [self refreshSetting];
}

- (void)settingBiyunyao {
    
}

- (void)settingRedianliliao {
    
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
    
    CellType cellType = ((NSNumber *)cellDic[@"type"]).intValue;
    SettingType settingType = ((NSNumber *)cellDic[@"setting"]).intValue;
    
    static NSString *cellType0 = @"cellType";
    static NSString *cellType1 = @"cellType1";
    static NSString *cellType2 = @"cellType2";
    static NSString *cellType3 = @"cellType3";
    
    RHSettingCell *cell = nil;
    if (cellType == CellType3) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellType3];
        if (!cell) {
            cell = [[RHSettingCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType3];
        }
        RHSettingCell3 *cell3 = (RHSettingCell3 *)cell;
        [cell3 setDayimaComing:NO state:NO];
        
        if (_jingqi > 0 && _zhouqi > 0) {
            [cell3 setTitleJingqi:_jingqi zhouqi:_zhouqi];
        }
        WEAK_INSTANCE(cell3)
        cell3.actionBlock = ^(BOOL isStart) {
            [weakself settingDayima];
        };
        cell3.analysisBlock = ^() {
            
        };
        cell3.settingBlock = ^() {
            RHSettingMenstrualViewCtro *ctro = [[RHSettingMenstrualViewCtro alloc] init];
            ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            ctro.jingqi = weakself.jingqi;
            ctro.zhouqi = weakself.zhouqi;
            [weakself presentViewController:ctro animated:YES completion:^{
                ctro.settingBlock = ^(NSString *jingqi, NSString *zhouqi) {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    if (jingqi && jingqi.length > 0) {
                        _jingqi = jingqi.integerValue;
                        [defaults setInteger:jingqi.integerValue forKey:USER_DEFAULT_JINGQI];
                    }
                    if (zhouqi && zhouqi.length > 0) {
                        _zhouqi = zhouqi.integerValue;
                        [defaults setInteger:zhouqi.integerValue forKey:USER_DEFAULT_ZHOUQI];
                    }
                    if (jingqi > 0 && zhouqi > 0) {
                        [weakcell3 setTitleJingqi:jingqi.intValue zhouqi:zhouqi.intValue];
                    }
                };
            }];
        };
    }
    else if (cellType == CellType1) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellType1];
        if (!cell) {
            cell = [[RHSettingCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType1];
        }
        RHSettingCell1 *cell1 = (RHSettingCell1 *)cell;
        
        if (settingType == SettingType2) {
            // 同房
            [cell1 setBiaozhu:[RHSettingTongfangViewCtro getSignNameWithValue:_biaozhuModel.tongfang]];
            
            cell1.actionBlock = ^() {
                RHSettingTongfangViewCtro *ctro = [[RHSettingTongfangViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                ctro.tongfang = _biaozhuModel.tongfang;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSInteger tongfang) {
                        weakself.biaozhuModel.tongfang = tongfang;
                        [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                        [weakself.settingView reloadData];
                    };
                }];
            };
        }
        else if (settingType == SettingType4) {
            // 建档
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_biaozhuModel.jiandang]];
            BOOL flag = _biaozhuModel.jiandang == 1;
            cell1.actionBlock = ^() {
                weakself.biaozhuModel.jiandang = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                [weakself.settingView reloadData];
            };
        }
        else if (settingType == SettingType5) {
            // 进周期
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_biaozhuModel.jinzhouqi]];
            BOOL flag = _biaozhuModel.jinzhouqi == 1;
            cell1.actionBlock = ^() {
                weakself.biaozhuModel.jinzhouqi = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                [weakself.settingView reloadData];
            };
        }
        else if (settingType == SettingType6) {
            // 检测B超
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_biaozhuModel.jianceBchao]];
            BOOL flag = _biaozhuModel.jianceBchao == 1;
            cell1.actionBlock = ^() {
                weakself.biaozhuModel.jianceBchao = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                [weakself.settingView reloadData];
            };
        }
        else if (settingType == SettingType7) {
            // 男方准备
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_biaozhuModel.nanfangzhunbei]];
            BOOL flag = _biaozhuModel.nanfangzhunbei == 1;
            cell1.actionBlock = ^() {
                weakself.biaozhuModel.nanfangzhunbei = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                [weakself.settingView reloadData];
            };
        }
        else if (settingType == SettingType8) {
            // 打夜针
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_biaozhuModel.dayezhen]];
            BOOL flag = _biaozhuModel.dayezhen == 1;
            cell1.actionBlock = ^() {
                weakself.biaozhuModel.dayezhen = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                [weakself.settingView reloadData];
            };
        }
        else if (settingType == SettingType9) {
            // 取卵
            [cell1 setBiaozhu:[RHSettingQuluanViewCtro getSignNameWithValue:_biaozhuModel.quruan]];
            cell1.actionBlock = ^() {
                RHSettingQuluanViewCtro *ctro = [[RHSettingQuluanViewCtro alloc] init];
                ctro.quluan = _biaozhuModel.quruan;
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSInteger quluan) {
                        weakself.biaozhuModel.quruan = quluan;
                        [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                        [weakself.settingView reloadData];
                    };
                }];
            };
        }
        else if (settingType == SettingType10) {
            // 移植
            [cell1 setBiaozhu:[RHSettingYizhiViewCtro getSignNameWithValue:_biaozhuModel.yizhi]];
            cell1.actionBlock =  ^() {
                RHSettingYizhiViewCtro *ctro = [[RHSettingYizhiViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                ctro.yizhi = _biaozhuModel.yizhi;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSInteger yizhi) {
                        weakself.biaozhuModel.yizhi = yizhi;
                        [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                        [weakself.settingView reloadData];
                    };
                }];
            };
        }
        else if (settingType == SettingType12) {
            // 冻胚续费
            [cell1 setBiaozhu:[RHSettingDpxfViewCtro getSignNameWithValue:_biaozhuModel.dongpeixufei]];
            cell1.actionBlock =  ^() {
                RHSettingDpxfViewCtro *ctro = [[RHSettingDpxfViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(BOOL dongpeixufei) {
                        weakself.biaozhuModel.dongpeixufei = [NSNumber numberWithBool:dongpeixufei].integerValue;
                        [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                        [weakself.settingView reloadData];
                    };
                }];
            };
        }
        else if (settingType == SettingType13) {
            // 销毁胚胎
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_biaozhuModel.xiaohuipeitai]];
            BOOL flag = _biaozhuModel.xiaohuipeitai == 1;
            cell1.actionBlock = ^() {
                weakself.biaozhuModel.xiaohuipeitai = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                [weakself.settingView reloadData];
            };
        }
        else if (settingType == SettingType14) {
            // 不舒服
            [cell1 setBiaozhu:[RHSettingBushufuViewCtro getSignNameWithText:_biaozhuModel.bushufu]];
            cell1.actionBlock = ^() {
                RHSettingBushufuViewCtro *ctro = [[RHSettingBushufuViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                ctro.bushufu = _biaozhuModel.bushufu;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSString *bushufu) {
                        weakself.biaozhuModel.bushufu = bushufu;
                        [weakself.dataManager updateBiaoZhu:weakself.biaozhuModel];
                        [weakself.settingView reloadData];
                    };
                }];
            };
        }
    }
    else if (cellType == CellType2) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellType2];
        if (!cell) {
            cell = [[RHSettingCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType2];
        }
        RHSettingCell2 *cell2 = (RHSettingCell2 *)cell;
        cell2.actionBlock = ^(BOOL isStart) {
            
        };
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellType0];
        if (!cell) {
            cell = [[RHSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType0];
        }
    }
    
    cell.cellImage = cellDic[@"image"];
    if (indexPath.row != 0) {
        cell.cellTitle = cellDic[@"title"];
    }
    
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
