//
//  CurveView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/25.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "CurveView.h"

@implementation CurveView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupCurve];
    }
    return self;
}

- (void)setupCurve {
    UIBezierPath *bezier = [[UIBezierPath alloc] init];
    [bezier moveToPoint:CGPointMake(0, 150)];
    [bezier addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezier.CGPath;
    pathLayer.fillColor = UIColor.clearColor.CGColor;
    pathLayer.strokeColor = UIColor.redColor.CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.layer addSublayer:pathLayer];
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
//    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"image.png"].CGImage;
    shipLayer.backgroundColor = UIColor.greenColor.CGColor;
    [self.layer addSublayer:shipLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 10.0;
    animation.path = bezier.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
//    [shipLayer addAnimation:animation forKey:nil];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"backgroundColor";
    basicAnimation.toValue = (__bridge id)UIColor.redColor.CGColor;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation, basicAnimation];
    group.duration = 10.0;
    
    [shipLayer addAnimation:group forKey:nil];
    
}

@end
