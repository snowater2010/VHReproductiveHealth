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
}

- (void)segAction:(UISegmentedControl *)segment {
    if (_actionBlock) {
        _actionBlock(segment.selectedSegmentIndex==0);
    }
}

- (void)setSegmentColor:(UIColor *)segmentColor {
    _segmentColor = segmentColor;
    _segment.tintColor = _segmentColor;
}

- (void)setSegmentState:(BOOL)segmentState {
    _segmentState = segmentState;
    if (segmentState) {
        _segment.selectedSegmentIndex = 0;
    }
    else {
        _segment.selectedSegmentIndex = 1;
    }
}

@end
