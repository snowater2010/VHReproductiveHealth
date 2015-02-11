//
//  RHTongFangFenxiViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/10.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHTongFangFenxiViewCtro.h"
#import "RHBarGraphView.h"
#import "RHYjFxCell.h"

@interface RHTongFangFenxiViewCtro () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    RHBarGraphView *_chartView;
}

@end

@implementation RHTongFangFenxiViewCtro

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"a", @"b"]];
    [seg addTarget:self action:@selector(segmengChanged:) forControlEvents:UIControlEventValueChanged];
    seg.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imageView.backgroundColor = [UIColor greenColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = FONT_14;
    label.textColor = COLOR_TEXT_DGREEN;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    
    
    _chartView = [[RHBarGraphView alloc] initWithFrame:_tableView.frame];
    _chartView.backgroundColor = [UIColor purpleColor];
    _chartView.datas = @[@20, @33, @30, @55, @33];
    _chartView.labels = @[@"12/09", @"12/10", @"12/10", @"12/10", @"12/10"];
    _chartView.yUnit = @"天";
    _chartView.title = @"周期天数";
    [self.view addSubview:_chartView];
    [_chartView draw];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    static NSString *yjfxIdentifier = @"yjfxIdentifier";
    RHYjFxCell *cell = [tableView dequeueReusableCellWithIdentifier:yjfxIdentifier];
    if (!cell) {
        cell = [[RHYjFxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:yjfxIdentifier];
    }
    
    NSDictionary *dataDic = _datas[row];
    
    [cell setData0:@"" data1:@"" data2:@""];
    
    return cell;
}
@end
