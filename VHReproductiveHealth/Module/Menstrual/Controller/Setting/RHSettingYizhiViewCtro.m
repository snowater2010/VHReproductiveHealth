//
//  RHSettingYizhiViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingYizhiViewCtro.h"

@interface RHSettingYizhiViewCtro() <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *_picker;
    NSArray *_datas;
}
@end

@implementation RHSettingYizhiViewCtro

- (instancetype)init {
    if (self = [super init]) {
        [self initSet];
    }
    return self;
}

- (void)initSet {
    self.settingHeight = 200;
    self.yizhi = 1;
    _datas = @[@"一个", @"两个"];
}

+ (NSString *)getSignNameWithValue:(NSInteger)value {
    if (value > 0) {
        return [NSString stringWithFormat:@"移植%zd个", value];
    }
    else {
        return @"未标注";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingTitle = @"移植记录";
    
    _picker = [[UIPickerView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_picker];
    
    _picker.dataSource = self;
    _picker.delegate = self;
    
    if (_yizhi > 0) {
        [_picker selectRow:_yizhi-1 inComponent:0 animated:NO];
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
