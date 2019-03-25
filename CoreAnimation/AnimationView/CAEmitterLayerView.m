//
//  CAEmitterLayerView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/24.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "CAEmitterLayerView.h"

@implementation CAEmitterLayerView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupEmitterLayer];
    }
    return self;
}

/** 粒子引擎 */
- (void)setupEmitterLayer {
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.bounds;
    [self.layer addSublayer:emitter];
    
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(10, 10);
    
    //cell
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"snow"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5;
//    cell.color = [UIColor colorWithRed:0.5 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2;
    
    emitter.emitterCells = @[cell];
}
@end
