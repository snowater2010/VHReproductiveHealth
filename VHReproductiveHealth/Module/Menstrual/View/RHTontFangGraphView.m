//
//  RHTontFangGraphView.m
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/11.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import "RHTontFangGraphView.h"

@implementation RHTontFangGraphView

- (UIColor *)colorForBarAtIndex:(NSInteger)index {
    return UIColorFromRGB(0xFFECD6);
}

- (void)drawExplain {
    UIImage *image = [UIImage imageNamed:@"explain"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    [[[imageView setSizeFromSize:image.size] centerXWith:self] insideBottomEdgeBy:0];
}

- (void)drawXAxis {
    CGPoint initPoint = [self getInitPoint];
    
    // x axis
    {
        UIBezierPath *xAxisPath = [UIBezierPath bezierPath];
        [xAxisPath moveToPoint:CGPointMake(0, initPoint.y)];
        [xAxisPath addLineToPoint:CGPointMake(self.barGraph.width, initPoint.y)];
        
        CAShapeLayer *xAxis = [CAShapeLayer layer];
        xAxis.lineWidth = 1;
        xAxis.path = xAxisPath.CGPath;
        xAxis.strokeColor = [UIColorFromRGB(0xA8CE4D) CGColor];
        
        [self.barGraph.layer addSublayer:xAxis];
    }
    
    CGFloat unitWidth = self.barWidth + self.barMargin;
    for (NSValue *value in _yuejingRange) {
        NSRange range = value.rangeValue;
        if (range.length > 0) {
            UIBezierPath *xAxisPath = [UIBezierPath bezierPath];
            [xAxisPath moveToPoint:CGPointMake(range.location*unitWidth, initPoint.y)];
            [xAxisPath addLineToPoint:CGPointMake((range.location+range.length)*unitWidth, initPoint.y)];
            
            CAShapeLayer *xAxis = [CAShapeLayer layer];
            xAxis.lineWidth = 1;
            xAxis.path = xAxisPath.CGPath;
            xAxis.strokeColor = [UIColorFromRGB(0xFF8BA8) CGColor];
            
            [self.barGraph.layer addSublayer:xAxis];
        }
    }
    
    for (NSValue *value in _pailuanRange) {
        NSRange range = value.rangeValue;
        if (range.length > 0) {
            UIBezierPath *xAxisPath = [UIBezierPath bezierPath];
            [xAxisPath moveToPoint:CGPointMake(range.location*unitWidth, initPoint.y)];
            [xAxisPath addLineToPoint:CGPointMake((range.location+range.length)*unitWidth, initPoint.y)];
            
            CAShapeLayer *xAxis = [CAShapeLayer layer];
            xAxis.lineWidth = 1;
            xAxis.path = xAxisPath.CGPath;
            xAxis.strokeColor = [UIColorFromRGB(0xD491D0) CGColor];
            
            [self.barGraph.layer addSublayer:xAxis];
        }
    }
    
    for (NSDictionary *obj in _chartTongFang) {
        NSNumber *index = [obj objectForKey:@"index"];
        NSNumber *type = [obj objectForKey:@"type"];
        
        CGRect rect = CGRectMake((index.intValue+1)*unitWidth-self.barWidth, initPoint.y-self.barWidth, self.barWidth, self.barWidth);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        switch (type.intValue) {
            case 1:
                imageView.image = [UIImage imageNamed:@"wuduoshi"];
                break;
            case 2:
                imageView.image = [UIImage imageNamed:@"youcuoshi"];
                break;
            case 3:
                imageView.image = [UIImage imageNamed:@"biyunyao"];
                break;
            default:
                break;
        }
        [self.barGraph addSubview:imageView];
    }
    
}

@end
