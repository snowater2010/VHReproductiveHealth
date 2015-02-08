//
//  RHSettingMenstrualViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/7.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingMenstrualViewCtro.h"

@interface RHSettingMenstrualViewCtro () {
    UITextField *jqText;
    UITextField *zqText;
}

@end

@implementation RHSettingMenstrualViewCtro

- (instancetype)init {
    if (self = [super init]) {
        [self initSet];
    }
    return self;
}

- (void)initSet {
    self.settingHeight = 200;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    jqText = [[UITextField alloc] init];
    UILabel *jqLabel = [[UILabel alloc] init];
    UILabel *jqTian = [[UILabel alloc] init];
    [self.contentView addSubview:jqLabel];
    [self.contentView addSubview:jqText];
    [self.contentView addSubview:jqTian];
    
    [[[jqText setW:50 andH:27] centerXWith:self.contentView] insideTopEdgeBy:25];
    [[[jqLabel setW:(self.contentView.width-jqText.width-18)*0.5 andH:27] insideTopEdgeBy:25] insideLeftEdgeBy:0];
    [[[jqTian setSizeFromView:jqLabel] insideTopEdgeBy:25] insideRightEdgeBy:0];
    
    jqText.font = FONT_18;
    jqText.textAlignment = NSTextAlignmentCenter;
    jqText.keyboardType = UIKeyboardTypeNumberPad;
    jqText.layer.borderWidth = 1;
    jqText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    jqLabel.text = @"经期：";
    jqLabel.font = FONT_18;
    jqLabel.textAlignment = NSTextAlignmentRight;
    jqTian.text = @"天";
    jqTian.font = FONT_18;
    jqTian.textAlignment = NSTextAlignmentLeft;
    
    //
    zqText = [[UITextField alloc] initWithFrame:jqText.frame];
    UILabel *zqLabel = [[UILabel alloc] initWithFrame:jqLabel.frame];
    UILabel *zqTian = [[UILabel alloc] initWithFrame:jqTian.frame];
    [self.contentView addSubview:zqLabel];
    [self.contentView addSubview:zqText];
    [self.contentView addSubview:zqTian];
    
    [zqText adjustY:zqText.height+21];
    [zqLabel adjustY:zqLabel.height+21];
    [zqTian adjustY:zqTian.height+21];
    
    zqText.font = FONT_18;
    zqText.textAlignment = NSTextAlignmentCenter;
    zqText.keyboardType = UIKeyboardTypeNumberPad;
    zqText.layer.borderWidth = 1;
    zqText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    zqLabel.text = @"周期：";
    zqLabel.font = FONT_18;
    zqLabel.textAlignment = NSTextAlignmentRight;
    zqTian.text = @"天";
    zqTian.font = FONT_18;
    zqTian.textAlignment = NSTextAlignmentLeft;
}

- (void)doConfirm {
    
    if (_settingBlock) {
        _settingBlock(jqText.text, zqText.text);
    }
    
    [super doConfirm];
}

@end
