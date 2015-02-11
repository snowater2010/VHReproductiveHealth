//
//  RHYuejingFenxiViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/10.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHYuejingFenxiViewCtro.h"
#import "RHBarGraphView.h"
#import "RHYjFxCell.h"
#import "RHMenstrualDataManger.h"
#import "ESDateHelper.h"

@interface RHYuejingFenxiViewCtro () <UITableViewDataSource, UITableViewDelegate> {
    UILabel *_labelState;
    UILabel *_labelZhouqi;
    UILabel *_labelJingqi;
    
    UITableView *_tableView;
    RHBarGraphView *_chartView;
    
    NSInteger _jingqi;
    NSInteger _zhouqi;
    NSInteger _averageJingqi;
    NSInteger _averageZhouqi;
    NSString *_state;
    
    NSMutableArray *_datas;
    NSMutableArray *_zhouqiValues;
    NSMutableArray *_jingqiValues;
    NSMutableArray *_chartLabels;
    NSMutableArray *_chartSecondLabels;
    NSMutableArray *_tableDateLabels;
}

@property(nonatomic, strong) NSArray *datas;

@end

@implementation RHYuejingFenxiViewCtro

- (void)initData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _jingqi = [defaults integerForKey:USER_DEFAULT_JINGQI];
    _zhouqi = [defaults integerForKey:USER_DEFAULT_ZHOUQI];
    
    NSArray *dayimaData = [[RHMenstrualDataManger sharedInstance] queryDayima];
    _datas = [NSMutableArray arrayWithArray:dayimaData];
    _zhouqiValues = [NSMutableArray array];
    _jingqiValues = [NSMutableArray array];
    _chartLabels = [NSMutableArray array];
    _chartSecondLabels = [NSMutableArray array];
    _tableDateLabels = [NSMutableArray array];
    
    RHDayimaModel *lastModel = _datas.lastObject;
    NSDate *strDateLast = [NSDate dateWithTimeIntervalSince1970:lastModel.start * 0.001];
    
    CGFloat sumZhouqi = .0f;
    CGFloat sumJingqi = .0f;
    NSInteger in3MonthCount = 0;
    BOOL isTwiceInMonth = NO;
    for (int i = 0; i < _datas.count; i++) {
        RHDayimaModel *model1 = _datas[i];
        NSDate *strDate = [NSDate dateWithTimeIntervalSince1970:model1.start * 0.001];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:model1.end * 0.001];
        [_chartLabels addObject:[strDate stringWithFormat:@"MM/dd"]];
        [_chartSecondLabels addObject:[strDate stringWithFormat:@"yyyy"]];
        [_tableDateLabels addObject:[strDate stringWithFormat:@"yyyy-MM-dd"]];
        
        NSInteger jingqi = [endDate daysFromDate:strDate];
        [_jingqiValues addObject:@(jingqi)];
        BOOL isIn3Month = strDate.month+2 > strDateLast.month;
        if (isIn3Month) {
            sumJingqi += jingqi;
            in3MonthCount ++;
        }
        
        if (_datas.count > i+1) {
            RHDayimaModel *model2 = _datas[i+1];
            NSDate *strDate2 = [NSDate dateWithTimeIntervalSince1970:model2.start * 0.001];
            NSInteger zhouqi = [strDate2 daysFromDate:strDate];
            [_zhouqiValues addObject:@(zhouqi)];
            if (isIn3Month) {
                sumZhouqi += zhouqi;
            }
            if (!isTwiceInMonth) {
                isTwiceInMonth = (strDate.year == strDate2.year) && (strDate.month == strDate2.month);
            }
        }
        else {
            [_zhouqiValues addObject:@(_zhouqi)];
        }
    }
    
    CGFloat aZhouqi = sumZhouqi / (in3MonthCount-1);
    CGFloat aJingqi = sumJingqi / (in3MonthCount);
    _averageZhouqi = round(aZhouqi);
    _averageJingqi = round(aJingqi);
    
    
//    1、相邻＞2次月经月经周期＜21天   月经不规律
//    2、相邻＞2次月经月经周期＞40天    月经不规律
//    3、一个月经周期内来两次月经  月经不规律
    BOOL isJingqiRight = YES;
    if (isTwiceInMonth) {
        // 3
        isJingqiRight = NO;
    }
    else {
        // 1,2
        for (int i = 0; i < _zhouqiValues.count; i++) {
            if (!isJingqiRight) break;
            if (_zhouqiValues.count > i + 1) {
                NSNumber *value1 = (NSNumber *)_zhouqiValues[i];
                NSNumber *value2 = (NSNumber *)_zhouqiValues[i+1];
                isJingqiRight = !((value1.intValue < 21 || value1.intValue > 40) && (value2.intValue < 21 || value2.intValue > 40));
            }
            
        }
    }
    
    _state = isJingqiRight ? @"月经正常！" : @"月经不正常！";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    self.title = @"月经分析";
    self.view.backgroundColor = COLOR_BG_WHITE;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touxiang"]];
    [self.view addSubview:imageView];
    [[[imageView setSizeFromSize:imageView.image.size] insideTopEdgeBy:10] insideLeftEdgeBy:10];
    
    CGFloat labelHeight = imageView.height / 3;
    
    _labelState = [[UILabel alloc] init];
    [self.view addSubview:_labelState];
    [[[_labelState setW:self.view.width-imageView.maxX andH:labelHeight] outsideRightEdgeOf:imageView by:0] insideTopEdgeBy:0];
    _labelState.font = FONT_14;
    _labelState.textColor = COLOR_TEXT_DGREEN;
    _labelState.textAlignment = NSTextAlignmentLeft;
    _labelState.text = _state;
    
    _labelZhouqi = [[UILabel alloc] init];
    [self.view addSubview:_labelZhouqi];
    _labelZhouqi.frame = _labelState.frame;
    [_labelZhouqi adjustY:_labelState.height];
    _labelZhouqi.font = FONT_14;
    _labelZhouqi.textColor = COLOR_TEXT_BROWN;
    _labelZhouqi.textAlignment = NSTextAlignmentLeft;
    _labelZhouqi.text = [NSString stringWithFormat:@"平均周期：%zd天", _averageZhouqi];
    
    _labelJingqi = [[UILabel alloc] init];
    [self.view addSubview:_labelJingqi];
    _labelJingqi.frame = _labelZhouqi.frame;
    [_labelJingqi adjustY:_labelState.height];
    _labelJingqi.font = FONT_14;
    _labelJingqi.textColor = COLOR_TEXT_BROWN;
    _labelJingqi.textAlignment = NSTextAlignmentLeft;
    _labelJingqi.text = [NSString stringWithFormat:@"平均经期：%zd天", _averageJingqi];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"分析", @"表格"]];
    [self.view addSubview:seg];
    [[[seg setW:280 andH:33] centerXWith:self.view] insideTopEdgeBy:134];
    seg.tintColor = COLOR_BG_DGREEN;
    [seg addTarget:self action:@selector(segmengChanged:) forControlEvents:UIControlEventValueChanged];
    [seg setSelectedSegmentIndex:0];
    
    _chartView = [[RHBarGraphView alloc] initWithFrame:CGRectMake(0, seg.maxY+20, self.view.width, self.view.height-seg.maxY-40)];
    _chartView.datas = _zhouqiValues;
    _chartView.labels = _chartLabels;
    _chartView.secondLabels = _chartSecondLabels;
    _chartView.yUnit = @"天";
    _chartView.title = @"周期天数";
    [self.view addSubview:_chartView];
    [_chartView draw];
    
    _tableView = [[UITableView alloc] initWithFrame:_chartView.frame];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.hidden = YES;
//    [_tableView reloadData];
}

- (BOOL)doAnalyze {
    return YES;
}

#pragma mark - segment
- (void)segmengChanged:(UISegmentedControl *)segment {
    _tableView.hidden = segment.selectedSegmentIndex == 0;
    _chartView.hidden = segment.selectedSegmentIndex != 0;
}

#pragma mark - UITableViewDataSource + UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RHYjFxCell *cell = [[RHYjFxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    [cell setData0:@"经期开始时间" data1:@"经期天数" data2:@"周期天数"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger index = _datas.count - row - 1; //倒序
    
    static NSString *yjfxIdentifier = @"yjfxIdentifier";
    RHYjFxCell *cell = [tableView dequeueReusableCellWithIdentifier:yjfxIdentifier];
    if (!cell) {
        cell = [[RHYjFxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:yjfxIdentifier];
    }
    NSString *strDate = @"";
    NSString *strJingqi = @"";
    NSString *strZhouqi = @"";
    if (_tableDateLabels.count > index) {
        strDate = _tableDateLabels[index];
    }
    if (_jingqiValues.count > index) {
        strJingqi = ((NSNumber *)_jingqiValues[index]).stringValue;
    }
    if (_zhouqiValues.count > index) {
        strZhouqi = row == 0 ? @"—" : ((NSNumber *)_zhouqiValues[index]).stringValue;
    }
    
    [cell setData0:strDate data1:strJingqi data2:strZhouqi];
    
    return cell;
}

@end
