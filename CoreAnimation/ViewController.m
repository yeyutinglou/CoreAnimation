//
//  ViewController.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/23.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CALayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIImageView *hour;
@property (weak, nonatomic) IBOutlet UIImageView *minute;
@property (weak, nonatomic) IBOutlet UIImageView *second;

/** blueLayer */
@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CALayer *blueLayer = [[CALayer alloc] init];
    blueLayer.frame = CGRectMake(0, 0, 50, 50);
    blueLayer.delegate = self;
    blueLayer.backgroundColor = UIColor.blueColor.CGColor;
    [self.layerView.layer addSublayer:blueLayer];
    self.blueLayer = blueLayer;
    
    [blueLayer display];
    
//    UIImage *image = [UIImage imageNamed:@"image.png"];
//    self.layerView.layer.contents = (__bridge id _Nullable)(image.CGImage);
//    self.layerView.layer.contentsGravity = kCAGravityCenter;
//    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
//    self.layerView.layer.masksToBounds = YES;
    
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 =  -1.0 / 500;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    self.layerView.layer.transform = transform;
    
    self.hour.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.minute.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.second.layer.anchorPoint = CGPointMake(0.5, 0.9);
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
   
    
    
    
    
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSetLineWidth(ctx, 5.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}


- (void)tick {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hourAngle = (components.hour / 12.0 ) * M_PI * 2;
     CGFloat minuteAngle = (components.minute / 60.0 ) * M_PI * 2;
     CGFloat secondAngle = (components.second / 60.0 ) * M_PI * 2;
    
    self.hour.transform = CGAffineTransformMakeRotation(hourAngle);
    self.minute.transform = CGAffineTransformMakeRotation(minuteAngle);
    self.second.transform = CGAffineTransformMakeRotation(secondAngle);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.layerView.layer containsPoint:point]) {
        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
        if ([self.blueLayer containsPoint:point]) {
            NSLog(@"blueLayer click");
        } else {
            NSLog(@"layerView click");
        }
    }
}


@end
