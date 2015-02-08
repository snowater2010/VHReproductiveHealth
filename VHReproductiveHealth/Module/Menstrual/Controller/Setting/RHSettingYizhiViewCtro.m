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
    self.settingHeight = 300;
    _datas = @[@"一个", @"两个"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _picker = [[UIPickerView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_picker];
    _picker.backgroundColor = [UIColor purpleColor];
    
    _picker.dataSource = self;
    _picker.delegate = self;
}

- (void)doConfirm {
    
    if (_settingBlock) {
        _settingBlock([_picker selectedRowInComponent:0]);
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
