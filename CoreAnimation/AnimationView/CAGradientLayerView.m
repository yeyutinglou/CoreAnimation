//
//  CAGradientLayerView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/23.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "CAGradientLayerView.h"

@implementation CAGradientLayerView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupGradientLayer];
    }
    return self;
}

- (void)setupGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
    
    gradientLayer.colors =  @[(__bridge id)UIColor.redColor.CGColor, (__bridge id)UIColor.orangeColor.CGColor, (__bridge id)UIColor.greenColor.CGColor];
    
    gradientLayer.locations = @[@0.0, @0.5, @0.75];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
};

@end
