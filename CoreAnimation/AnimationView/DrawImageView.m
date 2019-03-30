//
//  DrawImageView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/29.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "DrawImageView.h"

@implementation DrawImageView

- (void)drawRect:(CGRect)rect
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    CGImageRef imageRef = image.CGImage;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    CGContextRestoreGState(context);
}

@end
