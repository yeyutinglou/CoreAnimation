//
//  CATextLayerView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/23.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "CATextLayerView.h"
#import <CoreText/CoreText.h>
@implementation CATextLayerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupTextLayer];
    }
    return self;
}

- (void)setupTextLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = UIColor.blackColor.CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15.0f];
    
    NSString *text = @"The true nobility is in being superior to your previous self.The 1896 Cedar Keys hurricane was a powerful tropical cyclone that devastated much of the East Coast of the United States, starting with Florida's Cedar Keys, near the end of September. The storm's rapid movement allowed it to maintain much of its intensity after landfall, becoming one of the costliest United States hurricanes at the time. The fourth tropical cyclone of the 1896 Atlantic hurricane season, it washed out the railroad connecting the Cedar Keys to the mainland with a 10.5 ft (3.2 m) storm surge, and submerged much of the island group (Cedar Key flooding pictured). The hurricane killed at least 70 people in mainland Florida, and razed 5,000 sq mi (13,000 km2) of dense pine forests in the northern part of the state. In Savannah, Georgia, fierce winds unroofed thousands of structures. In Washington, D.C., the White House grounds were left in disarray. Monuments at the Gettysburg Battlefield were damaged. Along the storm's path, it caused at least 202 deaths. (Full article...)";
   
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text];
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
       CGFloat fontSize = font.pointSize;
//    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
 
    NSDictionary *attribs = @{(id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor, (id)kCTFontAttributeName: (__bridge id)fontRef};
    
    [attributedStr setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
                                                                                    (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor, (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                                                                                    (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                                                                                    };
    [attributedStr setAttributes:attribs range:NSMakeRange(10, 20)];
    CFRelease(fontRef);
    
    
    textLayer.string = attributedStr;
}

@end
