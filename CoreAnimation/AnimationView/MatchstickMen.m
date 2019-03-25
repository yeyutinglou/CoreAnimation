//
//  MatchstickMen.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/23.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "MatchstickMen.h"

@implementation MatchstickMen

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupPath];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
          [self setupPath];
    }
    return self;
}

- (void)setupPath
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = UIColor.redColor.CGColor;
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
}

@end
