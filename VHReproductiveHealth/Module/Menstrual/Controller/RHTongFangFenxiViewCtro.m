//
//  RHTongFangFenxiViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/10.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

/*
 1）女性的月经周期有长有短，但排卵日与下次月经开始之间的间隔时间比较固定，一般在14天左右。那么根据排卵和月经之间的这种关系，就可以按月经周期来推算排卵期。推算方法就是从下次月经来潮的第1天算起，倒数14天或减去14天就是排卵日,排卵日及其前5天和后4天加在一起称为排卵期。 这也是安全期避孕法的理论根据，因为在月经周期里除了月经期和排卵期,其余的时间均为安全期。
 
 　　例如，以月经周期为30天为例来算，这次月经来潮的第1天在9月29日，那么下次月经来潮是在10月29日(9月29日加30天)，再从10月29日减去14天,则10月15日就是排卵日。排卵日及其前5天和后4天，也就是从10月10-19日这十天为排卵期。
 
 　　用这种方法推算排卵期，首先要知道月经周期的长短，也就是说要有很正常或是有规律的月经周期，才能推算出下次月经来潮的开始日期进而才能算出排卵期，所以只能适用于月经周期一向正常的女性。如果要是的月经周期无规律或者不正常则无法推算出下次月经来潮的日期，故也无法推算到排卵日和排卵期。
 
 　　对于月经不正常的话，排卵期计算公式为：
 
 　　排卵期第一天＝最短一次月经周期天数减去18天；
 
 　　排卵期最后一天＝最长一次月经周期天数减去11天。
 
 　　例如月经期最短为28天，最长为37天，需将最短的规律期减去18(28－18＝10)以及将最长的规律期减去11(37－11＝26)，所以在月经潮后的第10天至26天都属于排卵期。
 
 2）怀孕几率
 3）月经期：10%
 4）安全期：15%
 5）排卵期第一天：35%
 6）排卵期第二天：40%
 7）排卵期第三天：55%
 8）排卵期第四天：65%
 9）排卵期第五天：80%
 10） 排卵期第六天(排卵日)：90%
 11） 排卵期第七天：80%
 12） 排卵期第八天：75%
 13） 排卵期第九天：65%
 14） 排卵期第十天：50%
 */

#import "RHTongFangFenxiViewCtro.h"
#import "RHBarGraphView.h"
#import "RHYjFxCell.h"
#import "RHMenstrualDataManger.h"
#import "RHTontFangGraphView.h"

@interface RHTongFangFenxiViewCtro () <UITableViewDataSource, UITableViewDelegate> {
    UILabel *_labelState;
    UILabel *_labelZhouqi;
    UILabel *_labelJingqi;
    
    NSDate *_dateMax;
    NSDate *_dateMin;
    
    NSMutableArray *_chartTongFang;
    
    NSMutableArray *_tongfangDatas;
    NSMutableArray *_zhouqiValues;
    NSMutableArray *_jingqiValues;
    NSMutableArray *_chartLabels;
    NSMutableArray *_chartSecondLabels;
    NSMutableArray *_tableDateLabels;
    
    NSMutableArray *_paiLuanDates;
    
    NSMutableArray *_yuejingRange;
    NSMutableArray *_pailuanRange;
    NSMutableArray *_yiyunRange;
    NSMutableArray *_anquanRange;
    
    UITableView *_tableView;
    RHTontFangGraphView *_chartView;
    
    NSInteger _averageZhouqi;
    
    RHMenstrualDataManger *_instance;
    
    
    NSMutableArray *_everydayPercent;
}

@end

@implementation RHTongFangFenxiViewCtro

- (void)initData {
    _instance = [RHMenstrualDataManger sharedInstance];
    
    _everydayPercent = [NSMutableArray array];
    _chartLabels = [NSMutableArray array];
    _chartSecondLabels = [NSMutableArray array];
    _tableDateLabels = [NSMutableArray array];
    _paiLuanDates = [NSMutableArray array];
    
    _yuejingRange = [NSMutableArray array];
    _pailuanRange = [NSMutableArray array];
    _yiyunRange = [NSMutableArray array];
    _anquanRange = [NSMutableArray array];
    
    _chartTongFang = [NSMutableArray array];
    
    BOOL isJingqiRight = YES;
    _averageZhouqi = 30;
    
    
    _dateMax = [[NSDate date] beginningOfDay];
    _dateMin = [_dateMax dateByAddingMonths:-2];
    
    
    NSDate *exDate = _dateMin;
    RHDayimaModel *exDayima = [_instance queryLastDayimaByDate:_dateMin];
    if (exDayima) {
        exDate = [NSDate dateWithTimeIntervalSince1970:exDayima.start*0.001];
    }
    
    // 月经期
    NSArray *allDayima = [_instance queryDayimaStartDate:exDate endDate:_dateMax];
    for (RHDayimaModel *dayima in allDayima) {
        NSDate *strDate = [NSDate dateWithTimeIntervalSince1970:dayima.start * 0.001];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:dayima.end * 0.001];
        
        NSRange range = [self rangeWithStrDate:strDate endDate:endDate];
        [_yuejingRange addObject:[NSValue valueWithRange:range]];
    }
    
    
    // 排卵期
    for (RHDayimaModel *dayima in allDayima) {
        NSDate *dayimaDate = [NSDate dateWithTimeIntervalSince1970:dayima.start*0.001];
        NSDate *pailuanDate = [dayimaDate dateByAddingDays:_averageZhouqi-14];
        [_paiLuanDates addObject:@([pailuanDate daysFromDate:_dateMin])];
        
        NSDate *strDate = [pailuanDate dateByAddingDays:-5];
        NSDate *endDate = [pailuanDate dateByAddingDays:4];
        
        NSRange range = [self rangeWithStrDate:strDate endDate:endDate];
        [_pailuanRange addObject:[NSValue valueWithRange:range]];
    }
    
    // 同房日
    NSArray *tongfangDatas = [_instance queryBiaoZhuStartDate:_dateMin endDate:_dateMax];
    _tongfangDatas = [NSMutableArray arrayWithArray:tongfangDatas];
    
    for (RHBiaoZhuModel *model in _tongfangDatas) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.calendar * 0.001];
        [_chartTongFang addObject:@{@"index":@([date daysFromDate:_dateMin]), @"type":@(model.tongfang)}];
    }
    
    
    NSInteger i = 0;
    NSDate *eachDate = _dateMin;
    do {
        NSInteger precent = [self calculatePercentAtIndex:i];
        [_chartLabels addObject:[eachDate stringWithFormat:@"M/d"]];
        [_chartSecondLabels addObject:[NSString stringWithFormat:@"%zd", eachDate.weekday]];
        [_tableDateLabels addObject:[eachDate stringWithFormat:@"yyyy-MM-dd"]];
        
        [_everydayPercent addObject:@(precent)];
        eachDate = [eachDate dateByAddingDays:1];
        
        i++;
    }
    while ([eachDate compare:_dateMax] != NSOrderedDescending);
}

- (NSInteger)calculatePercentWithDate:(NSDate *)date {
    NSInteger index = [date daysFromDate:_dateMin];
    return [self calculatePercentAtIndex:index];
}

- (NSInteger)calculatePercentAtIndex:(NSInteger)index {
    NSInteger precent = 0;
    NSRange range1 = [self number:index inRangeArray:_pailuanRange];
    NSRange range2 = [self number:index inRangeArray:_yuejingRange];
    if (range2.length > 0) {
        precent = 10;
    }
    else if (range1.length > 0) {
        precent = [self precentAtIndex:index-range1.location];
    }
    else {
        precent = 15;
    }
    return precent;
}

- (NSInteger)precentAtIndex:(NSInteger)index {
    NSInteger percent = 0;
    switch (index) {
        case 0:
            percent = 35;
            break;
        case 1:
            percent = 40;
            break;
        case 2:
            percent = 55;
            break;
        case 3:
            percent = 65;
            break;
        case 4:
            percent = 80;
            break;
        case 5:
            percent = 90;
            break;
        case 6:
            percent = 80;
            break;
        case 7:
            percent = 75;
            break;
        case 8:
            percent = 65;
            break;
        case 9:
            percent = 50;
            break;
        default:
            percent = 0;
            break;
    }
    return percent;
}

- (NSRange)rangeWithStrDate:(NSDate *)strDate endDate:(NSDate *)endDate {
    NSRange range = NSMakeRange(0, 0);
    NSInteger minStr = [strDate daysFromDate:_dateMin];
    NSInteger minEnd = [endDate daysFromDate:_dateMin];
    NSInteger maxStr = [strDate daysFromDate:_dateMax];
    NSInteger maxEnd = [endDate daysFromDate:_dateMax];
    
    if (minEnd < 0 || maxStr > 0) {
    }
    else if (minStr < 0) {
        range = NSMakeRange(0, minEnd+1);
    }
    else if (maxEnd > 0) {
        range = NSMakeRange(minStr, maxStr+1);
    }
    else {
        range = NSMakeRange(minStr, minEnd-minStr+1);
    }
    return range;
}

- (NSRange)number:(NSInteger)number inRangeArray:(NSArray *)rangeArray {
    for (NSValue *obj in rangeArray) {
        NSRange range = obj.rangeValue;
        if (range.length == 0) {
            continue;
        }
        BOOL isInRange = number >= range.location && number <= (range.location+range.length-1);
        if (isInRange) {
            return range;
        }
    }
    return NSMakeRange(0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
//    self.title = @"同房分析";
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
//    _labelState.text = _state;
    
    _labelZhouqi = [[UILabel alloc] init];
    [self.view addSubview:_labelZhouqi];
    _labelZhouqi.frame = _labelState.frame;
    [_labelZhouqi adjustY:_labelState.height];
    _labelZhouqi.font = FONT_14;
    _labelZhouqi.textColor = COLOR_TEXT_BROWN;
    _labelZhouqi.textAlignment = NSTextAlignmentLeft;
//    _labelZhouqi.text = [NSString stringWithFormat:@"平均周期：%zd天", _averageZhouqi];
    
    _labelJingqi = [[UILabel alloc] init];
    [self.view addSubview:_labelJingqi];
    _labelJingqi.frame = _labelZhouqi.frame;
    [_labelJingqi adjustY:_labelState.height];
    _labelJingqi.font = FONT_14;
    _labelJingqi.textColor = COLOR_TEXT_BROWN;
    _labelJingqi.textAlignment = NSTextAlignmentLeft;
//    _labelJingqi.text = [NSString stringWithFormat:@"平均经期：%zd天", _averageJingqi];
    
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"分析", @"表格"]];
    [self.view addSubview:seg];
    [[[seg setW:280 andH:33] centerXWith:self.view] insideTopEdgeBy:134];
    seg.tintColor = COLOR_BG_DGREEN;
    [seg addTarget:self action:@selector(segmengChanged:) forControlEvents:UIControlEventValueChanged];
    [seg setSelectedSegmentIndex:0];
    
    _chartView = [[RHTontFangGraphView alloc] initWithFrame:CGRectMake(0, seg.maxY+20, self.view.width, self.view.height-seg.maxY-40)];
    _chartView.datas = _everydayPercent;
    _chartView.labels = _chartLabels;
    _chartView.secondLabels = _chartSecondLabels;
    _chartView.yuejingRange = _yuejingRange;
    _chartView.pailuanRange = _pailuanRange;
    _chartView.paiLuanIndexs = _paiLuanDates;
    _chartView.chartTongFang = _chartTongFang;
    _chartView.yUnit = @"%";
    _chartView.title = @"怀孕几率";
    _chartView.minValue = 0;
    _chartView.maxValue = 100;
    _chartView.paddingValue = 10;
    _chartView.explainHeight = 50;
    [self.view addSubview:_chartView];
    [_chartView draw];
    
    _tableView = [[UITableView alloc] initWithFrame:_chartView.frame];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.hidden = YES;
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
    [cell setData0:@"记录日期" data1:@"生理期" data2:@"安全措施"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tongfangDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    static NSString *tffxIdentifier = @"tffxIdentifier";
    RHYjFxCell *cell = [tableView dequeueReusableCellWithIdentifier:tffxIdentifier];
    if (!cell) {
        cell = [[RHYjFxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tffxIdentifier];
    }
    
    RHBiaoZhuModel *model = _tongfangDatas[row];
    
    NSDate *tongfangDate = [NSDate dateWithTimeIntervalSince1970:model.calendar * 0.001];
    NSString *strDate = [tongfangDate stringWithFormat:@"yyyy-MM-dd"];
    NSInteger precent = [self calculatePercentWithDate:tongfangDate];
    NSString *type = @"";
    if (precent == 10) {
        type = @"月经期";
    }
    else if (precent > 15) {
        type = @"易孕期";
    }
    else {
        type = @"安全期";
    }
    
    NSString *safe = @"";
    switch (model.tongfang) {
        case 1:
            safe = @"无";
            break;
        case 2:
            safe = @"避孕套";
            break;
        case 3:
            safe = @"避孕药";
            break;
        default:
            break;
    }
    
    [cell setData0:strDate data1:type data2:safe];
    
    return cell;
}
@end
