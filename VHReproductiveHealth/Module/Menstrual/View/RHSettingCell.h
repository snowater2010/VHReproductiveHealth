//
//  RHSettingCell.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/4.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CellType1,
    CellType2,
    CellType3
} CellType;

@interface RHSettingCell : UITableViewCell

@property (nonatomic, assign) CellType cellType;
@property (nonatomic, strong) NSString *cellImage;
@property (nonatomic, strong) NSString *cellTitle;

@end
