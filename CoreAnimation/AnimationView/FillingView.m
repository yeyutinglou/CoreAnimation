//
//  FillingView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/28.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "FillingView.h"

@implementation FillingView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 75, 10);
    CGContextAddLineToPoint(context, 10, 150);
    CGContextAddLineToPoint(context, 160, 150);
    CGContextClosePath(context);
    
    [[UIColor redColor] setFill];

    [[UIColor blackColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);

    
}

@end
