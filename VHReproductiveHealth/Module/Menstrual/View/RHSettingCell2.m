//
//  RHSettingCell2.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/4.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingCell2.h"

@interface RHSettingCell2 () {
    UISegmentedControl *_segment;
}
@end

@implementation RHSettingCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUIView];
    }
    return self;
}

- (void)initUIView {
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"开始", @"结束"]];
    [self addSubview:_segment];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [[[_segment setW:80 andH:29] centerYWith:self] insideRightEdgeBy:10];
}


@end
