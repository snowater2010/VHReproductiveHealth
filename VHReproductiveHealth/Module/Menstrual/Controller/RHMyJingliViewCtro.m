//
//  RHMyJingliViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/10.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHMyJingliViewCtro.h"
#import "RHMenstrualViewCtro.h"

@implementation RHMyJingliViewCtro

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的经历";
    
//    [self initData];
    [self initUIView];
}

- (void)initUIView {
    
    CGFloat btnWidth = 203;
    CGFloat btnHeight = 32;
    
    UIButton *jingliBtn = [[UIButton alloc] init];
    UIButton *zhushouBtn = [[UIButton alloc] init];
    
    [self.view addSubview:jingliBtn];
    [self.view addSubview:zhushouBtn];
    
    [[[jingliBtn setW:btnWidth andH:btnHeight] centerXWith:self.view] insideTopEdgeBy:190];
    zhushouBtn.frame = jingliBtn.frame;
    [zhushouBtn adjustY:jingliBtn.height + 20];
    
    jingliBtn.backgroundColor = COLOR_BG_DGREEN;
    zhushouBtn.backgroundColor = COLOR_BG_DGREEN;
    
    [jingliBtn setTitle:@"周期经历" forState:UIControlStateNormal];
    [zhushouBtn setTitle:@"用药助手" forState:UIControlStateNormal];
    
    [jingliBtn setTitleColor:COLOR_TEXT_WHITE forState:UIControlStateNormal];
    [zhushouBtn setTitleColor:COLOR_TEXT_WHITE forState:UIControlStateNormal];
    
    [jingliBtn addTarget:self action:@selector(goZhouqijingli) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goZhouqijingli {
    [self.navigationController pushViewController:[[RHMenstrualViewCtro alloc] init] animated:YES];
    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backItem;
}

@end
