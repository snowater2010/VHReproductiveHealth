//
//  RHBarGraphView.m
//  RHBarGraphView
//
//  Created by lipeng on 15/2/5.
//  Copyright (c) 2015年 vichiger23wee. All rights reserved.
//

#import "RHBarGraphView.h"
#import "GKBarGraph.h"
#import "UIView+CBFrameHelpers.h"

#define kDefaultBarWidth        22
#define kDefaultBarHeight       140
#define kDefaultBarMargin       30
#define kDefaultLabelWidth      40
#define kDefaultLabelHeight     15
#define kDefaultExplainHeight   20

#define kDefaultMinValue        15
#define kDefaultMaxValue        60
#define kDefaultRightLine       30

@interface RHBarGraphView () <GKBarGraphDataSource> {
    UIScrollView *_scrollView;
    GKBarGraph *_barGraph;
}

@end

@implementation RHBarGraphView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init {
    _rightLine = kDefaultRightLine;
    _maxValue = kDefaultMaxValue;
    _minValue = kDefaultMinValue;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _barGraph = [[GKBarGraph alloc] initWithFrame:CGRectMake(kDefaultBarMargin, 0, _scrollView.width, _scrollView.height-kDefaultExplainHeight)];
    _barGraph.dataSource = self;
    _barGraph.barWidth = kDefaultBarWidth;
    _barGraph.barHeight = _barGraph.height - kDefaultLabelHeight*2 - 40;
    _barGraph.marginBar = kDefaultBarMargin;
    [_scrollView addSubview:_barGraph];
}

- (void)draw {
    [self drawAxis];
    [self drawScales];
    
    // resize graph
    CGFloat graphWidth = self.datas.count * (kDefaultBarWidth + kDefaultBarMargin) + kDefaultBarMargin;
    [_barGraph setW:graphWidth];
    _scrollView.contentSize = CGSizeMake(_barGraph.frame.size.width + kDefaultBarMargin, _barGraph.frame.size.height);
    
    [_barGraph draw];
    
    [self drawRightLine];
    
    [self drawTitle];
    [self drawExplain];
}

- (void)drawExplain {
    CGPoint initPoint = [self getInitPoint];
    CGFloat xLoc = initPoint.x;
    
    NSString *tip1 = @"---理想周期";
    NSString *tip2 = @"（30天）";
    NSString *tip3 = @"月/日";
    NSString *tip4 = @"来经时间";
    CGSize size1 = [tip1 sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    CGSize size2 = [tip2 sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
    CGSize size3 = [tip3 sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
    CGSize size4 = [tip4 sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    
    
    CATextLayer *textLayer1 = [CATextLayer layer];
    textLayer1.contentsScale = 2;
    textLayer1.string = tip1;
    textLayer1.fontSize = 14.f;
    textLayer1.alignmentMode = kCAAlignmentLeft;
    textLayer1.foregroundColor = [UIColorFromRGB(0xAE9570) CGColor];
    textLayer1.frame = CGRectMake(xLoc+5, _barGraph.maxY+(kDefaultExplainHeight-size1.height)*0.5, size1.width,size1.height);
    [self.layer addSublayer:textLayer1];
    
    xLoc += size1.width;
    
    CATextLayer *textLayer2 = [CATextLayer layer];
    textLayer2.contentsScale = 2;
    textLayer2.string = tip2;
    textLayer2.fontSize = 10.f;
    textLayer2.alignmentMode = kCAAlignmentLeft;
    textLayer2.foregroundColor = [UIColorFromRGB(0xAE9570) CGColor];
    textLayer2.frame = CGRectMake(xLoc, textLayer1.frame.origin.y+textLayer1.frame.size.height-size2.height, size2.width, size2.height);
    [self.layer addSublayer:textLayer2];
    
    xLoc += size2.width;
    
    CATextLayer *textLayer3 = [CATextLayer layer];
    textLayer3.contentsScale = 2;
    textLayer3.string = tip3;
    textLayer3.fontSize = 10.f;
    textLayer3.alignmentMode = kCAAlignmentLeft;
    textLayer3.foregroundColor = [COLOR_TEXT_DGREEN CGColor];
    textLayer3.frame = CGRectMake(xLoc+10, textLayer2.frame.origin.y, size3.width, size3.height);
    [self.layer addSublayer:textLayer3];
    
    xLoc += size3.width + 10;
    CATextLayer *textLayer4 = [CATextLayer layer];
    textLayer4.contentsScale = 2;
    textLayer4.string = tip4;
    textLayer4.fontSize = 14.f;
    textLayer4.alignmentMode = kCAAlignmentLeft;
    textLayer4.foregroundColor = [UIColorFromRGB(0xAE9570) CGColor];
    textLayer4.frame = CGRectMake(xLoc+2, textLayer1.frame.origin.y, size4.width, size4.height);
    [self.layer addSublayer:textLayer4];
    
    
}

- (void)drawTitle {
    if (_title && _title.length > 0) {
        CGPoint initPoint = [self getInitPoint];
        
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.contentsScale = 2;
        textLayer.string = _title;
        textLayer.fontSize = 14.f;
        textLayer.alignmentMode = kCAAlignmentLeft;
        textLayer.foregroundColor = [UIColorFromRGB(0xA19996) CGColor];
        textLayer.frame = CGRectMake(initPoint.x+5, 5, 100, 16);
        [self.layer addSublayer:textLayer];
    }
}

- (void)drawRightLine {
    
    CGFloat rightLineY = [self getHeightByNumber:self.rightLine];
    
    UIBezierPath *rightLinePath = [UIBezierPath bezierPath];
    [rightLinePath moveToPoint:CGPointMake(0, rightLineY)];
    [rightLinePath addLineToPoint:CGPointMake(self.width, rightLineY)];
    
    CAShapeLayer *rightLineLayer = [CAShapeLayer layer];
    rightLineLayer.lineWidth = 1;
    rightLineLayer.strokeColor = [[UIColor orangeColor] CGColor];
    rightLineLayer.lineDashPhase = 2;
    rightLineLayer.lineDashPattern = @[@5, @5];
    rightLineLayer.path = rightLinePath.CGPath;
    [self.layer addSublayer:rightLineLayer];
}

- (CGFloat)getHeightByNumber:(CGFloat)number {
    CGPoint initPoint = [self getInitPoint];
    return initPoint.y - (number-_minValue) / (_maxValue-_minValue) * _barGraph.barHeight;
}

- (CGPoint)getInitPoint {
    return CGPointMake(kDefaultBarMargin, self.height - kDefaultLabelHeight * 2 - kDefaultExplainHeight);
}

- (void)drawAxis {
    CGPoint initPoint = [self getInitPoint];
    
    // y axis
    UIBezierPath *yAxisPath = [UIBezierPath bezierPath];
    [yAxisPath moveToPoint:CGPointMake(initPoint.x, self.height)];
    [yAxisPath addLineToPoint:CGPointMake(initPoint.x, 0)];
    
    CAShapeLayer *yAxis = [CAShapeLayer layer];
    yAxis.lineWidth = 1;
    yAxis.path = yAxisPath.CGPath;
    yAxis.strokeColor = [UIColorFromRGB(0xA19996) CGColor];
    
    [self.layer addSublayer:yAxis];
    
    // x axis
    UIBezierPath *xAxisPath = [UIBezierPath bezierPath];
    [xAxisPath moveToPoint:CGPointMake(0, initPoint.y)];
    [xAxisPath addLineToPoint:CGPointMake(self.width, initPoint.y)];
    
    [xAxisPath moveToPoint:CGPointMake(0, initPoint.y + kDefaultLabelHeight)];
    [xAxisPath addLineToPoint:CGPointMake(self.width, initPoint.y + kDefaultLabelHeight)];
    
    CAShapeLayer *xAxis = [CAShapeLayer layer];
    xAxis.lineWidth = 1;
    xAxis.path = xAxisPath.CGPath;
    xAxis.strokeColor = [UIColorFromRGB(0xA19996) CGColor];
    
    [self.layer addSublayer:xAxis];
}

// 刻度
- (void)drawScales {
    CGPoint initPoint = [self getInitPoint];
    
    UIBezierPath *scalePath = [UIBezierPath bezierPath];
    
    CGFloat axisY = .0;
    NSInteger scaleValue = _minValue + 5;
    while (scaleValue <= _maxValue) {
        axisY = [self getHeightByNumber:scaleValue];
        [scalePath moveToPoint:CGPointMake(initPoint.x, axisY)];
        if (scaleValue % 10 == 0) {
            [scalePath addLineToPoint:CGPointMake(initPoint.x-7, axisY)];
        }
        else {
            [scalePath addLineToPoint:CGPointMake(initPoint.x-3, axisY)];
        }
        
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.contentsScale = 2;
        textLayer.string = [NSString stringWithFormat:@"%zd", scaleValue];
        textLayer.fontSize = 12.f;
        textLayer.alignmentMode = kCAAlignmentRight;
        textLayer.foregroundColor = [UIColorFromRGB(0xA19996) CGColor];
        textLayer.frame = CGRectMake(0, axisY-8, initPoint.x-10, 16);
        [self.layer addSublayer:textLayer];
        
        scaleValue += 5;
    }
    
    CAShapeLayer *scales = [CAShapeLayer layer];
    scales.lineWidth = 1;
    scales.path = scalePath.CGPath;
    scales.strokeColor = [UIColorFromRGB(0xA19996) CGColor];
    
    [self.layer addSublayer:scales];
    
    // unit
    if (_yUnit && _yUnit.length > 0) {
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.contentsScale = 2;
        textLayer.string = _yUnit;
        textLayer.fontSize = 12.f;
        textLayer.alignmentMode = kCAAlignmentRight;
        textLayer.foregroundColor = [UIColorFromRGB(0xA19996) CGColor];
        textLayer.frame = CGRectMake(0, axisY-30, initPoint.x-10, 16);
        [self.layer addSublayer:textLayer];
    }
}

#pragma mark - GKBarGraphDataSource
- (NSInteger)numberOfBars {
    return self.datas.count;
}

- (NSNumber *)valueForBarAtIndex:(NSInteger)index {
    NSNumber *value = (NSNumber *)self.datas[index];
    CGFloat percentage = (value.floatValue-_minValue) / (_maxValue-_minValue) * 100;
    return [NSNumber numberWithFloat:percentage];
}

- (NSNumber *)numberForBarAtIndex:(NSInteger)index {
    return self.datas[index];
}

- (UIColor *)colorForBarBackgroundAtIndex:(NSInteger)index {
    return UIColorFromRGB(0xFAFAFA);
}

- (UIColor *)colorForBarAtIndex:(NSInteger)index {
    if (((NSNumber *)self.datas[index]).integerValue >= self.rightLine) {
        return UIColorFromRGB(0xFFECD6);
    }
    else {
        return UIColorFromRGB(0xA19996);
    }
}

- (NSString *)titleForBarAtIndex:(NSInteger)index {
    if (self.labels.count > index) {
        return self.labels[index];
    }
    return @"";
}

- (NSString *)secondTitleForBarAtIndex:(NSInteger)index {
    if (self.secondLabels.count > index) {
        return self.secondLabels[index];
    }
    return @"";
}

@end