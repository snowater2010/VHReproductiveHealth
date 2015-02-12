//
//  RHSettingTongfangViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingTongfangViewCtro.h"
#import "RHTongFangFenxiViewCtro.h"

@interface RHSettingTongfangViewCtro() <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *_picker;
    NSArray *_datas;
}
@end

@implementation RHSettingTongfangViewCtro

- (instancetype)init {
    if (self = [super init]) {
        [self initSet];
    }
    return self;
}

- (void)initSet {
    self.settingHeight = 300;
    self.tongfang = 1;
    _datas = @[@"无安全措施", @"避孕套", @"避孕药"];
}

+ (NSString *)getSignNameWithValue:(NSInteger)value {
    switch (value) {
        case 1:
            return @"无安全措施";
            break;
        case 2:
            return @"避孕套";
            break;
        case 3:
            return @"避孕药";
            break;
        default:
            return @"未标注";
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingTitle = @"同房记录";
    
    _picker = [[UIPickerView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_picker];
    
    _picker.dataSource = self;
    _picker.delegate = self;
    
    if (_tongfang > 0) {
        [_picker selectRow:_tongfang-1 inComponent:0 animated:NO];
    }
    
    UIButton *analyze = [[UIButton alloc] initWithFrame:self.titleLabel.frame];
    [self.windowView addSubview:analyze];
    [[analyze setW:100] insideRightEdgeBy:0];
    [analyze setTitleColor:COLOR_TEXT_DGREEN forState:UIControlStateNormal];
    [analyze setTitle:@"查看分析" forState:UIControlStateNormal];
    analyze.titleLabel.font = FONT_14;
    [analyze addTarget:self action:@selector(doAnalyze) forControlEvents:UIControlEventTouchUpInside];
}

- (void)doAnalyze {
    [self doCancel];
    if (_analyzeBlock) {
        _analyzeBlock();
    }
}

- (void)doConfirm {
    if (_settingBlock) {
        _settingBlock([_picker selectedRowInComponent:0]+1);
    }
    [super doConfirm];
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _datas.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _datas[row];
}

@end
