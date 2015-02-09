//
//  RHCalendarCell.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/9.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHCalendarCell.h"

@interface RHCalendarCell () {
    UILabel *_numberLabel;
    UIImageView *_dayimaIv;
    
    UIImageView *_iv1;
    UIImageView *_iv2;
    UIImageView *_iv3;
    UIImageView *_iv4;
    UIImageView *_iv5;
    UIImageView *_iv6;
}

@end

@implementation RHCalendarCell

- (instancetype)init {
    if (self = [super init]) {
        [self setSelectedStyle:NO];
        
        _numberLabel = [[UILabel alloc] init];
        [self addSubview:_numberLabel];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
        _dayimaIv = [[UIImageView alloc] init];
        [self addSubview:_dayimaIv];
        
        _iv1 = [[UIImageView alloc] init];
        [self addSubview:_iv1];
        _iv2 = [[UIImageView alloc] init];
        [self addSubview:_iv2];
        _iv3 = [[UIImageView alloc] init];
        [self addSubview:_iv3];
        _iv4 = [[UIImageView alloc] init];
        [self addSubview:_iv4];
        _iv5 = [[UIImageView alloc] init];
        [self addSubview:_iv5];
        _iv6 = [[UIImageView alloc] init];
        [self addSubview:_iv6];
    }
    return self;
}

- (void)setNumber:(NSString *)number {
    _number = number;
    _numberLabel.text = _number;
}

- (void)layoutSubviews {
    [[[_numberLabel setW:self.width*0.5 andH:self.height*0.5] insideLeftEdgeBy:0] insideTopEdgeBy:0];
    
    CGFloat imageSize = (self.height-_numberLabel.height)*0.5;
    CGFloat hPadding = (self.width-imageSize*3)*0.25;
    
    [[[_dayimaIv setW:imageSize andH:imageSize] insideBottomEdgeBy:3] insideLeftEdgeBy:hPadding];
    
    _iv1.frame = _dayimaIv.frame;
    [_iv1 adjustY:-imageSize];
    
    _iv2.frame = _iv1.frame;
    [_iv2 adjustX:imageSize+hPadding];
    
    _iv3.frame = _iv2.frame;
    [_iv3 adjustX:imageSize+hPadding];

    _iv4.frame = _iv3.frame;
    [_iv4 adjustY:imageSize];
    
    _iv5.frame = _iv4.frame;
    [_iv5 adjustX:-imageSize-hPadding];
    
    _iv6.frame = _iv3.frame;
    [_iv6 adjustY:-imageSize];
}

- (void)setImageArray:(NSArray *)array {
    for (int i = 0; i<array.count; i++) {
        UIImage *image = [UIImage imageNamed:array[i]];
        switch (i) {
            case 0:
                _iv1.image = image;
                break;
            case 1:
                _iv2.image = image;
                break;
            case 2:
                _iv3.image = image;
                break;
            case 3:
                _iv4.image = image;
                break;
            case 4:
                _iv5.image = image;
                break;
            case 5:
                _iv6.image = image;
                break;
            default:
                break;
        }
    }
}

- (void)setDayimaImage:(DayimaState)state {
    
    switch (state) {
        case DayimaBegin:
            _dayimaIv.image = [UIImage imageNamed:@"dayima_begin"];
            break;
        case DayimaEnd:
            _dayimaIv.image = [UIImage imageNamed:@"dayima_end"];
            break;
        default:
            break;
    }
    
}

- (void)setDayimaBg:(BOOL)isDayima {
    if (isDayima) {
        self.backgroundColor = COLOR_BG_PINK;
    }
    else {
        self.backgroundColor = COLOR_BG_WHITE;
    }
}

- (void)setSelectedStyle:(BOOL)isSelected {
    if (isSelected) {
        self.layer.borderWidth = 3;
        self.layer.borderColor = [[UIColor redColor] CGColor];
    }
    else {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [COLOR_DGREEN CGColor];
    }
}

- (void)setIsDayima:(BOOL)isDayima {
    _isDayima = isDayima;
    if (isDayima) {
        self.backgroundColor = COLOR_BG_PINK;
    }
    else {
        self.backgroundColor = COLOR_BG_WHITE;
    }
}

@end
