//
//  CAReplicatorLayerView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/23.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "CAReplicatorLayerView.h"

@implementation CAReplicatorLayerView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        [self setupReplicatorLayer];
        [self setupReflection];
    }
    return self;
}

/** 转盘 */
- (void)setupReplicatorLayer {
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.bounds;
    [self.layer addSublayer:replicatorLayer];
    
    replicatorLayer.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 100, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -100, 0);
    replicatorLayer.instanceTransform = transform;
    
    replicatorLayer.instanceBlueOffset = -0.2;
    replicatorLayer.instanceGreenOffset = -0.1;
//    replicatorLayer.instanceRedOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = UIColor.whiteColor.CGColor;
    [replicatorLayer addSublayer:layer];
}


+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

/** 倒影 */
- (void)setupReflection {
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.frame = self.bounds;
    layer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, self.bounds.size.height + 2, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    
    layer.instanceAlphaOffset = -0.6;
}

@end
