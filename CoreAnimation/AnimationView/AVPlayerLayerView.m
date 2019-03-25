//
//  AVPlayerLayerView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/25.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "AVPlayerLayerView.h"
#import <AVFoundation/AVFoundation.h>

@implementation AVPlayerLayerView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupPlayer];
    }
    return self;
}

- (void)setupPlayer {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"monkey" withExtension:@"mp4"];
    
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerLayer *palyerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    palyerLayer.frame = self.bounds;
    [self.layer addSublayer:palyerLayer];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 1);
    palyerLayer.transform = transform;
    
    palyerLayer.masksToBounds = YES;
    palyerLayer.cornerRadius = 20;
    palyerLayer.borderColor = UIColor.redColor.CGColor;
    palyerLayer.borderWidth = 2.0;
    
    [player play];
}

@end
