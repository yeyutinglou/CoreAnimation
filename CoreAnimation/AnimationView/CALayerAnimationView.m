//
//  CALayerAnimationView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/25.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "CALayerAnimationView.h"

@interface CALayerAnimationView () <CAAnimationDelegate>

/** colorLayer */
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation CALayerAnimationView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = self.bounds;
    self.colorLayer.backgroundColor = UIColor.blueColor.CGColor;
    [self.layer addSublayer:self.colorLayer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture)];
    [self addGestureRecognizer:tap];
}

- (void)handleGesture
{
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:1.0];
//
//    [CATransaction setCompletionBlock:^{
//        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI_2);
//        self.colorLayer.affineTransform = transform;
//    }];
    
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
   UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
//    [CATransaction commit];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    animation.delegate = self;
    [self.colorLayer addAnimation:animation forKey:nil];
   
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef _Nullable)(anim.toValue);
    [CATransaction commit];
}

@end
