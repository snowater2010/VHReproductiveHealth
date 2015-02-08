//
//  RHSettingCell3.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingCell3.h"

@interface RHSettingCell3 () {
    UIButton *_analysis;
    UIButton *_setting;
}
@end

@implementation RHSettingCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.segment setTitle:@"是" forSegmentAtIndex:0];
        [self.segment setTitle:@"否" forSegmentAtIndex:1];
        
        _analysis = [UIButton buttonWithType:UIButtonTypeSystem];
        _setting = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_analysis];
        [self addSubview:_setting];
        
        [_analysis setTitle:@"查看分析" forState:UIControlStateNormal];
        [_setting setTitle:@"经期设置" forState:UIControlStateNormal];
        
        _analysis.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        _setting.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        
        [_analysis setTitleColor:COLOR_TEXT_PINK forState:UIControlStateNormal];
        [_setting setTitleColor:COLOR_TEXT_PINK forState:UIControlStateNormal];
        
        [_analysis addTarget:self action:@selector(doAnalze) forControlEvents:UIControlEventTouchUpInside];
        [_setting addTarget:self action:@selector(doSetting) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[[_analysis setW:300 andH:30] insideRightEdgeBy:10] outsideTopEdgeOf:self.segment by:5];
    [[[_setting setW:300 andH:30] insideRightEdgeBy:10] outsideBottomEdgeOf:self.segment by:5];
}

- (void)doAnalze {
    if (_analysisBlock) {
        _analysisBlock();
    }
}

- (void)doSetting {
    if (_settingBlock) {
        _settingBlock();
    }
}

- (void)setTitleJingqi:(NSInteger)jingqi zhouqi:(NSInteger)zhouqi {
    NSString *title = [NSString stringWithFormat:@"经期%zd天、周期%zd天", jingqi, zhouqi];
    [_setting setTitle:title forState:UIControlStateNormal];
}

- (void)setDayimaComing:(BOOL)isComing state:(BOOL)state {
    if (isComing) {
        self.textLabel.text = @"大姨妈来了";
    }
    else {
        self.textLabel.text = @"大姨妈走了";
    }
    if (state) {
        [self.segment setSelectedSegmentIndex:0];
    }
    else {
        [self.segment setSelectedSegmentIndex:1];
    }
}

@end
