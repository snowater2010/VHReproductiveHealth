//
//  RHSettingCell2.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/4.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingCell2.h"

@implementation RHSettingCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"开始", @"结束"]];
        [self addSubview:_segment];
        
        [_segment addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [[[_segment setW:90 andH:29] centerYWith:self] insideRightEdgeBy:10];
//    [_segment setBackgroundImage:[UIImage imageNamed:@"seg_normal"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [_segment setBackgroundImage:[UIImage imageNamed:@"seg_blue"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
}

- (void)segAction:(UISegmentedControl *)segment {
    if (_actionBlock) {
        _actionBlock(segment.selectedSegmentIndex==0);
    }
}

@end
