//
//  RHSettingSuperViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingSuperViewCtro.h"

@interface RHSettingSuperViewCtro () {
}



@end

@implementation RHSettingSuperViewCtro

- (instancetype)init {
    if (self = [super init]) {
        [self initSet];
    }
    return self;
}

- (void)initSet {
    self.settingHeight = 200;
}

+ (NSString *)getSignNameWithValue:(NSInteger)value {
    switch (value) {
        case 1:
            return @"已标注";
            break;
        default:
            return @"未标注";
            break;
    }
}

- (void)loadView {
    [super loadView];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    
    _windowView = [[UIView alloc] init];
    [self.view addSubview:_windowView];
    [[[_windowView setW:self.view.width*0.8 andH:_settingHeight] centerXWith:self.view] insideTopEdgeBy:100];
    
    _windowView.backgroundColor = COLOR_BG_WHITE;
    
    _titleLabel = [[UILabel alloc] init];
    [_windowView addSubview:_titleLabel];
    [[_titleLabel setW:_windowView.width andH:30] insideTopEdgeBy:10];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = FONT_18;
    _titleLabel.textColor = COLOR_TEXT_DGREEN;
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    UIButton *confirmBtn = [[UIButton alloc] init];
    [_windowView addSubview:cancelBtn];
    [_windowView addSubview:confirmBtn];
    
    [[[cancelBtn setW:50 andH:30] insideBottomEdgeBy:10] insideLeftEdgeBy:20];
    [[[confirmBtn setW:50 andH:30] insideBottomEdgeBy:10] insideRightEdgeBy:30];
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:COLOR_TEXT_DGREEN forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:COLOR_TEXT_DGREEN forState:UIControlStateNormal];
    
    [cancelBtn addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn addTarget:self action:@selector(doConfirm) forControlEvents:UIControlEventTouchUpInside];
    
    // content
    self.contentView = [[UIView alloc] init];
    [_windowView addSubview:_contentView];
    [[_contentView setW:_windowView.width andH:cancelBtn.y-_titleLabel.maxY] outsideBottomEdgeOf:_titleLabel by:0];
}

- (void)setSettingTitle:(NSString *)settingTitle {
    _settingTitle = settingTitle;
    _titleLabel.text = _settingTitle;
}

- (void)doCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doConfirm {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
