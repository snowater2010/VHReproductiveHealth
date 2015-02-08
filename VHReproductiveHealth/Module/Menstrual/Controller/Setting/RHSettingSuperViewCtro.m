//
//  RHSettingSuperViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingSuperViewCtro.h"

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
    
    UIView *windowView = [[UIView alloc] init];
    [self.view addSubview:windowView];
    [[[windowView setW:self.view.width*0.8 andH:_settingHeight] centerXWith:self.view] insideTopEdgeBy:100];
    
    windowView.backgroundColor = COLOR_BG_DEF;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [windowView addSubview:titleLabel];
    [[titleLabel setW:windowView.width andH:30] insideTopEdgeBy:0];
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"经期设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = FONT_14;
    titleLabel.textColor = COLOR_TEXT_DGREEN;
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    UIButton *confirmBtn = [[UIButton alloc] init];
    [windowView addSubview:cancelBtn];
    [windowView addSubview:confirmBtn];
    
    [[[cancelBtn setW:50 andH:30] insideBottomEdgeBy:0] insideLeftEdgeBy:10];
    [[[confirmBtn setW:50 andH:30] insideBottomEdgeBy:0] insideRightEdgeBy:10];
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:COLOR_TEXT_DGREEN forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:COLOR_TEXT_DGREEN forState:UIControlStateNormal];
    
    [cancelBtn addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn addTarget:self action:@selector(doConfirm) forControlEvents:UIControlEventTouchUpInside];
    
    // content
    self.contentView = [[UIView alloc] init];
    [windowView addSubview:_contentView];
    [[_contentView setW:windowView.width andH:cancelBtn.y-titleLabel.maxY] outsideBottomEdgeOf:titleLabel by:0];
    _contentView.backgroundColor = [UIColor yellowColor];
}

- (void)doCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doConfirm {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
