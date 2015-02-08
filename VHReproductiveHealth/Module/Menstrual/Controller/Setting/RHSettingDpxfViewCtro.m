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
}

@end

@implementation RHSettingDpxfViewCtro

- (instancetype)init {
    if (self = [super init]) {
        [self initSet];
    }
    return self;
}

- (void)initSet {
    self.settingHeight = 300;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    syText = [[UITextField alloc] init];
    UILabel *syLabel = [[UILabel alloc] init];
    UILabel *syTian = [[UILabel alloc] init];
    [self.contentView addSubview:syLabel];
    [self.contentView addSubview:syText];
    [self.contentView addSubview:syTian];
    
    [[[syText setW:50 andH:27] centerXWith:self.contentView] insideTopEdgeBy:yPadding];
    [[[syLabel setW:(self.contentView.width-syText.width-18)*0.5 andH:27] insideTopEdgeBy:yPadding] insideLeftEdgeBy:0];
    [[[syTian setSizeFromView:syLabel] insideTopEdgeBy:yPadding] insideRightEdgeBy:0];
    
    syText.font = FONT_18;
    syText.textAlignment = NSTextAlignmentCenter;
    syText.keyboardType = UIKeyboardTypeNumberPad;
    syText.layer.borderWidth = 1;
    syText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    syLabel.text = @"剩余：";
    syLabel.font = FONT_18;
    syLabel.textAlignment = NSTextAlignmentRight;
    syTian.text = @"管";
    syTian.font = FONT_18;
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
    
    xfText.font = FONT_18;
    xfText.textAlignment = NSTextAlignmentCenter;
    xfText.keyboardType = UIKeyboardTypeNumberPad;
    xfText.layer.borderWidth = 1;
    xfText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    xfLabel.text = @"续费：";
    xfLabel.font = FONT_18;
    xfLabel.textAlignment = NSTextAlignmentRight;
    xfTian.text = @"年";
    xfTian.font = FONT_18;
    xfTian.textAlignment = NSTextAlignmentLeft;
    
    //
    UILabel *toLabel = [[UILabel alloc] init];
    [self.contentView addSubview:toLabel];
    [[toLabel setW:self.contentView.width andH:27] outsideBottomEdgeOf:xfText by:yPadding];
    toLabel.text = @"至";
    toLabel.font = FONT_18;
    toLabel.textAlignment = NSTextAlignmentCenter;
    
    UITextField *toDate = [[UITextField alloc] initWithFrame:toLabel.frame];
    [self.contentView addSubview:toDate];
    [toDate adjustY:toLabel.height + yPadding];
    toDate.font = FONT_18;
    toDate.textAlignment = NSTextAlignmentCenter;
    toDate.keyboardType = UIKeyboardTypeNumberPad;
    toDate.layer.borderWidth = 1;
    toDate.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    //
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:toDate.frame];
    [self.contentView addSubview:alertLabel];
    [alertLabel adjustY:toDate.height+yPadding];
    alertLabel.text = @"设置提醒：";
    alertLabel.font = FONT_18;
    alertLabel.textAlignment = NSTextAlignmentCenter;
    
    UITextField *alertDate = [[UITextField alloc] initWithFrame:alertLabel.frame];
    [self.contentView addSubview:alertDate];
    [alertDate adjustY:toLabel.height + yPadding];
    alertDate.font = FONT_18;
    alertDate.textAlignment = NSTextAlignmentCenter;
    alertDate.keyboardType = UIKeyboardTypeNumberPad;
    alertDate.layer.borderWidth = 1;
    alertDate.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}

@end
