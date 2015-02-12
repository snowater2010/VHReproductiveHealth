//
//  RHSettingDpxfViewCtro.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/8.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingDpxfViewCtro.h"

#define yPadding 10

@interface RHSettingDpxfViewCtro () {
    UITextField *syText;
    UITextField *xfText;
    
    UITextField *toDate;
    UITextField *alertDate;
}

@end

@implementation RHSettingDpxfViewCtro

- (instancetype)init {
    if (self = [super init]) {
        [self initSet];
    }
    return self;
}

+ (NSString *)getSignNameWithText:(NSString *)value {
    if (value.length > 3) {
        return @"已标注";
    }
    else {
        return @"未标注";
    }
}

- (void)initSet {
    self.settingHeight = 250;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingTitle = @"冻胚续费";
    
    //
    syText = [[UITextField alloc] init];
    UILabel *syLabel = [[UILabel alloc] init];
    UILabel *syTian = [[UILabel alloc] init];
    [self.contentView addSubview:syLabel];
    [self.contentView addSubview:syText];
    [self.contentView addSubview:syTian];
    
    [[[syText setW:50 andH:25] centerXWith:self.contentView] insideTopEdgeBy:yPadding];
    [[[syLabel setW:(self.contentView.width-syText.width-18)*0.5 andH:25] insideTopEdgeBy:yPadding] insideLeftEdgeBy:0];
    [[[syTian setSizeFromView:syLabel] insideTopEdgeBy:yPadding] insideRightEdgeBy:0];
    
    syText.font = FONT_16;
    syText.textAlignment = NSTextAlignmentCenter;
    syText.keyboardType = UIKeyboardTypeNumberPad;
    syText.layer.borderWidth = 1;
    syText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    syLabel.text = @"剩余：";
    syLabel.font = FONT_16;
    syLabel.textAlignment = NSTextAlignmentRight;
    syTian.text = @"管";
    syTian.font = FONT_16;
    syTian.textAlignment = NSTextAlignmentLeft;
    
    //
    xfText = [[UITextField alloc] initWithFrame:syText.frame];
    UILabel *xfLabel = [[UILabel alloc] initWithFrame:syLabel.frame];
    UILabel *xfTian = [[UILabel alloc] initWithFrame:syTian.frame];
    [self.contentView addSubview:xfLabel];
    [self.contentView addSubview:xfText];
    [self.contentView addSubview:xfTian];
    
    [xfText adjustY:xfText.height+yPadding];
    [xfLabel adjustY:xfLabel.height+yPadding];
    [xfTian adjustY:xfTian.height+yPadding];
    
    xfText.font = FONT_16;
    xfText.textAlignment = NSTextAlignmentCenter;
    xfText.keyboardType = UIKeyboardTypeNumberPad;
    xfText.layer.borderWidth = 1;
    xfText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    xfLabel.text = @"续费：";
    xfLabel.font = FONT_16;
    xfLabel.textAlignment = NSTextAlignmentRight;
    xfTian.text = @"年";
    xfTian.font = FONT_16;
    xfTian.textAlignment = NSTextAlignmentLeft;
    
    //
    UILabel *toLabel = [[UILabel alloc] initWithFrame:xfLabel.frame];
    [self.contentView addSubview:toLabel];
    [toLabel adjustY:xfLabel.height+yPadding];
    toLabel.text = @"至：";
    toLabel.font = FONT_16;
    toLabel.textAlignment = NSTextAlignmentRight;
    
    toDate = [[UITextField alloc] initWithFrame:CGRectMake(xfText.x, xfText.maxY+yPadding, 100, xfText.height)];
    [self.contentView addSubview:toDate];
    toDate.font = FONT_16;
    toDate.textAlignment = NSTextAlignmentCenter;
    toDate.keyboardType = UIKeyboardTypeNumberPad;
    toDate.layer.borderWidth = 1;
    toDate.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    toDate.placeholder = [[NSDate date] stringWithFormat:@"yyyy-MM"];
    
    //
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:toLabel.frame];
    [self.contentView addSubview:alertLabel];
    [alertLabel adjustY:toDate.height+yPadding];
    alertLabel.text = @"设置提醒：";
    alertLabel.font = FONT_16;
    alertLabel.textAlignment = NSTextAlignmentRight;
    
    alertDate = [[UITextField alloc] initWithFrame:toDate.frame];
    [self.contentView addSubview:alertDate];
    [alertDate adjustY:toLabel.height + yPadding];
    alertDate.font = FONT_16;
    alertDate.textAlignment = NSTextAlignmentCenter;
    alertDate.keyboardType = UIKeyboardTypeNumberPad;
    alertDate.layer.borderWidth = 1;
    alertDate.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    alertDate.placeholder = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
}

- (void)setDongpeixufei:(NSString *)dongpeixufei {
    NSArray *arr = [dongpeixufei componentsSeparatedByString:@","];
    if (arr.count > 0) {
        syText.text = arr[0];
    }
    if (arr.count > 1) {
        xfText.text = arr[1];
    }
    if (arr.count > 2) {
        toDate.text = arr[2];
    }
    if (arr.count > 3) {
        alertDate.text = arr[3];
    }
}

- (void)doConfirm {
    if (_settingBlock) {
        NSString *str = [NSString stringWithFormat:@"%@,%@,%@,%@", syText.text, xfText.text, toDate.text, alertDate.text];
        _settingBlock(str);
    }
    [super doConfirm];
}

@end
