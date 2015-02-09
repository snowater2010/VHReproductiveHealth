//
//  RHSettingCell1.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/4.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingCell1.h"

@interface RHSettingCell1 () {
    UIButton *_signButton;
}
@end

@implementation RHSettingCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUIView];
    }
    return self;
}

- (void)initUIView {
    _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:_signButton];
    
    [_signButton setTitleColor:COLOR_TEXT_DGREEN forState:UIControlStateNormal];
    _signButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    [_signButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBiaozhu:(NSString *)biaozhu {
    [_signButton setTitle:biaozhu forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [[[_signButton setW:80 andH:29] centerYWith:self] insideRightEdgeBy:10];
}

- (void)buttonClicked {
    if (_actionBlock) {
        _actionBlock();
    }
}

@end
