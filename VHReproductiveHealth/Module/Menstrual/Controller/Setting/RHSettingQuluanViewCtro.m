//
//  RHSettingQuluanViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingQuluanViewCtro.h"

@interface RHSettingQuluanViewCtro () {
    UITextField *qlText;
}

@end

@implementation RHSettingQuluanViewCtro

+ (NSString *)getSignNameWithValue:(NSInteger)value {
    if (value > 0) {
        return [NSString stringWithFormat:@"取卵%zd个", value];
    }
    else {
        return @"未标注";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingTitle = @"取卵记录";
    
    qlText = [[UITextField alloc] init];
    UILabel *qlLabel = [[UILabel alloc] init];
    UILabel *qlUnit = [[UILabel alloc] init];
    [self.contentView addSubview:qlLabel];
    [self.contentView addSubview:qlText];
    [self.contentView addSubview:qlUnit];
    
    [[[qlText setW:50 andH:27] centerXWith:self.contentView] insideTopEdgeBy:25];
    [[[qlLabel setW:(self.contentView.width-qlText.width-18)*0.5 andH:27] insideTopEdgeBy:25] insideLeftEdgeBy:0];
    [[[qlUnit setSizeFromView:qlLabel] insideTopEdgeBy:25] insideRightEdgeBy:0];
    
    qlText.font = FONT_18;
    qlText.textAlignment = NSTextAlignmentCenter;
    qlText.keyboardType = UIKeyboardTypeNumberPad;
    qlText.layer.borderWidth = 1;
    qlText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    qlLabel.text = @"取卵：";
    qlLabel.font = FONT_18;
    qlLabel.textAlignment = NSTextAlignmentRight;
    qlUnit.text = @"个";
    qlUnit.font = FONT_18;
    qlUnit.textAlignment = NSTextAlignmentLeft;
    
    if (_quluan > 0) {
        qlText.text = [NSString stringWithFormat:@"%zd", _quluan];
    }
}

- (void)doConfirm {
    if (qlText.text.length > 0){
        if (_settingBlock) {
            _settingBlock(qlText.text.integerValue);
        }
    }
    [super doConfirm];
}


@end
