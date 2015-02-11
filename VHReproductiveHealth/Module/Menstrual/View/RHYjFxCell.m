//
//  RHYjFxCell.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/10.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHYjFxCell.h"

@interface RHYjFxCell () {
    UILabel *_label0;
    UILabel *_label1;
    UILabel *_label2;
}

@end

@implementation RHYjFxCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = COLOR_BG_WHITE;
        
        _label0 = [[UILabel alloc] init];
        _label0.font = FONT_14;
        _label0.textColor = COLOR_TEXT_BROWN;
        _label0.textAlignment = NSTextAlignmentCenter;
        
        _label1 = [[UILabel alloc] init];
        _label1.font = FONT_14;
        _label1.textColor = COLOR_TEXT_BROWN;
        _label1.textAlignment = NSTextAlignmentCenter;
        
        _label2 = [[UILabel alloc] init];
        _label2.font = FONT_14;
        _label2.textColor = COLOR_TEXT_BROWN;
        _label2.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_label0];
        [self addSubview:_label1];
        [self addSubview:_label2];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cellWidth = self.width / 3;
    
    [[[_label0 setW:cellWidth andH:self.height] insideLeftEdgeBy:0] centerYWith:self];
    [[[_label1 setW:cellWidth andH:self.height] outsideRightEdgeOf:_label0 by:0] centerYWith:self];
    [[[_label2 setW:cellWidth andH:self.height] outsideRightEdgeOf:_label1 by:0] centerYWith:self];
    
}

- (void)setData0:(NSString *)data0 data1:(NSString *)data1 data2:(NSString *)data2 {
    _label0.text = data0;
    _label1.text = data1;
    _label2.text = data2;
}

@end
