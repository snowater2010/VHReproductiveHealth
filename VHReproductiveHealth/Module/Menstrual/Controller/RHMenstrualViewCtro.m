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
#import "RHDayProvider.h"

#import "RHYuejingFenxiViewCtro.h"
#import "RHTongFangFenxiViewCtro.h"

#import "RHKoufubiyuanyaoModel.h"


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

@property (nonatomic, strong) RHDataModel *currDataModel;
@property (nonatomic, strong) NSArray *monthData;

@property (nonatomic, strong) RHStyleProvider *styleProvider;
@property (nonatomic, strong) NSMutableDictionary *controlDic;

@property (nonatomic, strong) RHCalendarCell *lastSelectedCell;

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
    self.settingArray = [RHBiaoZhuModel getSettingInfo];
    
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
    
    self.datePicker.styleProvider = [[RHStyleProvider alloc] init];
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
    
    // 选中标记
    RHCalendarCell *cell = (RHCalendarCell *)control;
    [self.lastSelectedCell setSelectedStyle:NO];
    [cell setSelectedStyle:YES];
    self.lastSelectedCell = cell;
    
    // 判断翻页，查询数据
    BOOL isNewPage = !(_currDate && (_currDate.year == date.year) && (_currDate.month == date.month));
    self.currDate = [date dateAtBeginningOfDay];
    
    if (isNewPage) {
        [self refreshData];
        [self refreshCalendar];
    }
    
    self.currDataModel = self.monthData[_currDate.day-1];
    [self refreshSetting];
}

- (void)refreshData {
    self.monthData = [_dataManager getMonthData:_currDate];
    self.currDataModel = self.monthData[_currDate.day-1];
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
        cell.dataModel = model;
    }
}

- (void)refreshCurrentCell {
    RHCalendarCell *cell = [_controlDic objectForKey:[_currDate stringWithFormat:DefaultDateFormat]];
    cell.dataModel = _currDataModel;
}

- (void)refreshSetting {
    BOOL showComing = NO;
    BOOL showStart = NO;
    if (_currDataModel.isDayima) {
        if (_currDataModel.isDayimaBegin) {
            showComing = YES;
            showStart = YES;
        }
        else if (_currDataModel.isDayimaEnd) {
            showComing = NO;
            showStart = YES;
        }
        else {
            showComing = NO;
            showStart = NO;
        }
    }
    else {
        BOOL isInEndRange = NO;
        NSInteger currIndex = _currDate.day-1;
        for (int i = 0; i < _jingqi; i++) {
            currIndex--;
            if (self.monthData.count > currIndex) {
                RHDataModel *testModel = self.monthData[currIndex];
                if (testModel.isDayima) {
                    isInEndRange = YES;
                    break;
                }
            }
            else {
                break;
            }
        }
        showComing = !isInEndRange;
        showStart = NO;
    }
    
    _currDataModel.showComing = showComing;
    _currDataModel.showStart = showStart;
    
    [self.settingView reloadData];
}

#pragma mark - date view

- (void)settingDayima:(BOOL)isStart {
    if (self.currDataModel.showComing) {
        if (isStart) {
            NSDate *endDate = [_currDate dateByAddingDays:_jingqi];
            [_dataManager insertDayimaStartDate:_currDate endDate:endDate];
        }
        else {
            [_dataManager deleteDayimaWithDate:_currDate];
        }
    }
    else if (!self.currDataModel.showComing) {
        if (isStart) {
            RHDataModel *lastModel = nil;
            NSInteger index = _currDate.day-1;
            do {
                if (_monthData.count > index) {
                    RHDataModel *datamodel = _monthData[index];
                    if (datamodel.isDayima) {
                        lastModel = datamodel;
                        break;
                    }
                }
                index--;
            } while (index != 0);
            
            [_dataManager updateDayimaEndDate:_currDate withDate:lastModel.date];
        }
    }
    
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
        cell3.segmentColor = UIColorFromRGB(0xFD879F);
        [cell3 setDayimaComing:_currDataModel.showComing state:_currDataModel.showStart];
        
        if (_jingqi > 0 && _zhouqi > 0) {
            [cell3 setTitleJingqi:_jingqi zhouqi:_zhouqi];
        }
        WEAK_INSTANCE(cell3)
        cell3.actionBlock = ^(BOOL isStart) {
            [weakself settingDayima:isStart];
        };
        cell3.analysisBlock = ^() {
            [weakself.navigationController pushViewController:[[RHYuejingFenxiViewCtro alloc] init] animated:YES];
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
            [cell1 setBiaozhu:[RHSettingTongfangViewCtro getSignNameWithValue:_currDataModel.biaozhu.tongfang]];
            
            cell1.actionBlock = ^() {
                RHSettingTongfangViewCtro *ctro = [[RHSettingTongfangViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                ctro.tongfang = _currDataModel.biaozhu.tongfang;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSInteger tongfang) {
                        weakself.currDataModel.biaozhu.tongfang = tongfang;
                        [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                        [weakself.settingView reloadData];
                        [weakself refreshCurrentCell];
                    };
                    ctro.analyzeBlock = ^(){
                        [weakself.navigationController pushViewController:[[RHTongFangFenxiViewCtro alloc] init] animated:YES];
                    };
                }];
            };
        }
        else if (settingType == SettingType4) {
            // 建档
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_currDataModel.biaozhu.jiandang]];
            BOOL flag = _currDataModel.biaozhu.jiandang == 1;
            cell1.actionBlock = ^() {
                weakself.currDataModel.biaozhu.jiandang = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                [weakself.settingView reloadData];
                [weakself refreshCurrentCell];
            };
        }
        else if (settingType == SettingType5) {
            // 进周期
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_currDataModel.biaozhu.jinzhouqi]];
            BOOL flag = _currDataModel.biaozhu.jinzhouqi == 1;
            cell1.actionBlock = ^() {
                weakself.currDataModel.biaozhu.jinzhouqi = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                [weakself.settingView reloadData];
                [weakself refreshCurrentCell];
            };
        }
        else if (settingType == SettingType6) {
            // 检测B超
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_currDataModel.biaozhu.jianceBchao]];
            BOOL flag = _currDataModel.biaozhu.jianceBchao == 1;
            cell1.actionBlock = ^() {
                weakself.currDataModel.biaozhu.jianceBchao = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                [weakself.settingView reloadData];
                [weakself refreshCurrentCell];
            };
        }
        else if (settingType == SettingType7) {
            // 男方准备
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_currDataModel.biaozhu.nanfangzhunbei]];
            BOOL flag = _currDataModel.biaozhu.nanfangzhunbei == 1;
            cell1.actionBlock = ^() {
                weakself.currDataModel.biaozhu.nanfangzhunbei = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                [weakself.settingView reloadData];
                [weakself refreshCurrentCell];
            };
        }
        else if (settingType == SettingType8) {
            // 打夜针
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_currDataModel.biaozhu.dayezhen]];
            BOOL flag = _currDataModel.biaozhu.dayezhen == 1;
            cell1.actionBlock = ^() {
                weakself.currDataModel.biaozhu.dayezhen = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                [weakself.settingView reloadData];
                [weakself refreshCurrentCell];
            };
        }
        else if (settingType == SettingType9) {
            // 取卵
            [cell1 setBiaozhu:[RHSettingQuluanViewCtro getSignNameWithValue:_currDataModel.biaozhu.quruan]];
            cell1.actionBlock = ^() {
                RHSettingQuluanViewCtro *ctro = [[RHSettingQuluanViewCtro alloc] init];
                ctro.quluan = _currDataModel.biaozhu.quruan;
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSInteger quluan) {
                        weakself.currDataModel.biaozhu.quruan = quluan;
                        [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                        [weakself.settingView reloadData];
                        [weakself refreshCurrentCell];
                    };
                }];
            };
        }
        else if (settingType == SettingType10) {
            // 移植
            [cell1 setBiaozhu:[RHSettingYizhiViewCtro getSignNameWithValue:_currDataModel.biaozhu.yizhi]];
            cell1.actionBlock =  ^() {
                RHSettingYizhiViewCtro *ctro = [[RHSettingYizhiViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                ctro.yizhi = _currDataModel.biaozhu.yizhi;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSInteger yizhi) {
                        weakself.currDataModel.biaozhu.yizhi = yizhi;
                        [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                        [weakself.settingView reloadData];
                        [weakself refreshCurrentCell];
                    };
                }];
            };
        }
        else if (settingType == SettingType12) {
            // 冻胚续费
            [cell1 setBiaozhu:[RHSettingDpxfViewCtro getSignNameWithText:_currDataModel.biaozhu.dongpeixufei]];
            cell1.actionBlock =  ^() {
                RHSettingDpxfViewCtro *ctro = [[RHSettingDpxfViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.dongpeixufei = _currDataModel.biaozhu.dongpeixufei;

                    ctro.settingBlock = ^(NSString *dongpeixufei) {
                        weakself.currDataModel.biaozhu.dongpeixufei = dongpeixufei;
                        [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                        [weakself.settingView reloadData];
                        [weakself refreshCurrentCell];
                    };
                }];
            };
        }
        else if (settingType == SettingType13) {
            // 销毁胚胎
            [cell1 setBiaozhu:[RHSettingSuperViewCtro getSignNameWithValue:_currDataModel.biaozhu.xiaohuipeitai]];
            BOOL flag = _currDataModel.biaozhu.xiaohuipeitai == 1;
            cell1.actionBlock = ^() {
                weakself.currDataModel.biaozhu.xiaohuipeitai = [NSNumber numberWithBool:!flag].integerValue;
                [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                [weakself.settingView reloadData];
                [weakself refreshCurrentCell];
            };
        }
        else if (settingType == SettingType14) {
            // 不舒服
            [cell1 setBiaozhu:[RHSettingBushufuViewCtro getSignNameWithText:_currDataModel.biaozhu.bushufu]];
            cell1.actionBlock = ^() {
                RHSettingBushufuViewCtro *ctro = [[RHSettingBushufuViewCtro alloc] init];
                ctro.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                ctro.bushufu = _currDataModel.biaozhu.bushufu;
                [weakself presentViewController:ctro animated:YES completion:^{
                    ctro.settingBlock = ^(NSString *bushufu) {
                        weakself.currDataModel.biaozhu.bushufu = bushufu;
                        [weakself.dataManager updateBiaoZhu:weakself.currDataModel.biaozhu];
                        [weakself.settingView reloadData];
                        [weakself refreshCurrentCell];
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
        if (settingType == SettingType3) {
            cell2.segmentColor = UIColorFromRGB(0x94BDF9);
            cell2.segmentState = _currDataModel.isKfbyy;
            cell2.actionBlock = ^(BOOL isStart) {
                [weakself doKoufuBiyunyao:isStart];
            };
        }
        else if (settingType == SettingType11) {
            cell2.segmentColor = UIColorFromRGB(0xFFB036);
            cell2.segmentState = _currDataModel.isRdll;
            cell2.actionBlock = ^(BOOL isStart) {
                [weakself doRdll:isStart];
            };
        }
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

- (void)doKoufuBiyunyao:(BOOL)isStart {
    if (isStart) {
        [_dataManager insertKfbyy:_currDate];
    }
    else {
        RHKoufubiyuanyaoModel *model = [_dataManager queryLastKfbyy:_currDate];
        if (model) {
            model.end = [_currDate timeIntervalSince1970] * 1000;
            [_dataManager updateKfbyy:model];
        }
    }
    
    [self refreshData];
    [self refreshCalendar];
    [self refreshSetting];
}

- (void)doRdll:(BOOL)isStart {
    if (isStart) {
        [_dataManager insertRdll:_currDate];
    }
    else {
        RHRedianliliaoModel *model = [_dataManager queryLastRdll:_currDate];
        if (model) {
            model.end = [_currDate timeIntervalSince1970] * 1000;
            [_dataManager updateRdll:model];
        }
    }
    
    [self refreshData];
    [self refreshCalendar];
    [self refreshSetting];
}

@end
