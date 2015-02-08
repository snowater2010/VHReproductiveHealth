//
//  RHSettingCell.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/4.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHSettingCell.h"

@interface RHSettingCell () {
}
@end

@implementation RHSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setCellImage:(NSString *)cellImage {
    _cellImage = cellImage;
    self.imageView.image = [UIImage imageNamed:cellImage];
}

- (void)setCellTitle:(NSString *)cellTitle {
    _cellTitle = cellTitle;
    self.textLabel.text = cellTitle;
}

@end
