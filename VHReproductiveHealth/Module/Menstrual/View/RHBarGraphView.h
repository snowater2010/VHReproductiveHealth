//
//  RHBarGraphView.h
//  RHBarGraphView
//
//  Created by lipeng on 15/2/5.
//  Copyright (c) 2015年 vichiger23wee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHBarGraphView : UIView

@property (nonatomic, assign) NSInteger maxValue;
@property (nonatomic, assign) NSInteger minValue;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *secondLabels;
@property (nonatomic, strong) NSString *yUnit;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger rightLine;


- (void)draw;

@end
