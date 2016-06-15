//
//  CircleView.m
//  test
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CircleView.h"
#import "YXEasing.h"
// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)

// 将弧度转换为度数
#define   DEGREES(radian)  ((radian) * 180.f / M_PI)

@interface CircleView ()
{
    BOOL _animating;
}
@property (nonatomic, strong) CABasicAnimation *spinAnimation;
/**
 *  圆形layer
 */
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation CircleView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createCircleLayer];
    }
    return self;
}

-(void)createCircleLayer
{
    self.circleLayer       = [CAShapeLayer layer];
    self.circleLayer.frame = self.bounds;
    [self.layer addSublayer:self.circleLayer];
}


- (void)buildView
{
    CGFloat lineWidth  = (self.lineWidth <= 0?1:self.lineWidth);
    UIColor *linColor  = (self.lineColor == nil?[UIColor blackColor]:self.lineColor);
    CGSize size        = self.bounds.size;
    CGFloat radius     = size.width/2.f - lineWidth/2.f;
    BOOL clockWise     = self.clockWise;
    CGFloat startAngle = 0;
    CGFloat endAngle   = 0;
    
    
    if (clockWise == YES) {
        startAngle = -RADIAN(180 - self.startAngle);
        endAngle   = RADIAN(180 + self.startAngle);

    }else{
        startAngle = RADIAN(180 - self.startAngle);
        endAngle   = -RADIAN(180 + self.startAngle);
    }
    
    
    self.circlePath     = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.height/2.f, size.width/2.f)
                                                                  radius:radius
                                                              startAngle:startAngle
                                                                endAngle:endAngle
                                                               clockwise:clockWise];
    self.circleLayer.path        = self.circlePath.CGPath;
    self.circleLayer.strokeColor = linColor.CGColor;
    self.circleLayer.fillColor   = [[UIColor clearColor] CGColor];
    self.circleLayer.lineWidth   = lineWidth;
    self.circleLayer.strokeEnd   = 0.95f;

}
- (void)strokeEnd:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration layer:(CAShapeLayer *)layer {
    
    // 过滤掉不合理的值
    if (value <= 0) {
        
        value = 0;
        
    } else if (value >= 1) {
        
        value = 1.f;
    }
    
    if (animated) {
        
        // 关键帧动画
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeEnd";
        keyAnimation.duration             = duration;
        keyAnimation.values               = \
        [YXEasing calculateFrameFromValue:layer.strokeEnd
                                  toValue:value
                                     func:func
                               frameCount:duration * 60];
        
        // 执行动画
       layer.strokeEnd = value;
        [layer addAnimation:keyAnimation forKey:nil];
        
    } else {
        // 关闭动画
        [CATransaction setDisableActions:YES];
        layer.strokeEnd = value;
        [CATransaction setDisableActions:NO];
    }
}
- (void)startAnmimation
{
    if (_animating) {
        return;
    }
    _animating = YES;
    
    [self addAnimation];
}


- (void)stopAnimating:(BOOL)state
{
    if (!_animating) {
        return;
    }
    _animating = NO;
    [self removeAnimation:state];
}


- (void)addAnimation{
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.repeatCount = HUGE_VAL;
    animation.toValue = @(2*M_PI);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.circleLayer addAnimation:animation forKey:@"rotate-layer"];
}


- (void)removeAnimation:(BOOL)state
{
   
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.repeatCount = 1;
    animation.toValue = @(2*M_PI);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.circleLayer removeAnimationForKey:@"retate-layer"];
    [self.circleLayer addAnimation:animation forKey:@"rotate-layer2"];
    
    [self strokeStart:0.95 animationType:CircularEaseInOut animated:YES duration:1 layer:self.circleLayer];
    
    dispatch_time_t poptimer = dispatch_time(DISPATCH_TIME_NOW, (int64_t) 1.8*NSEC_PER_SEC);
    dispatch_after(poptimer,  dispatch_get_main_queue(), ^{
        [self addCompleteAnimation:state];
    });
}



- (void)addCompleteAnimation:(BOOL)state
{
    
    
    UIColor *linColor  = (self.lineColor == nil?[UIColor blackColor]:self.lineColor);
    CGFloat lineWidth  = (self.lineWidth <= 0?1:self.lineWidth);
    if (state) {
        
        CGPoint pointa = CGPointMake(self.bounds.size.width/12, self.bounds.size.height/4);
        CGPoint pointb = CGPointMake(self.bounds.size.width/4, self.bounds.size.height/2);
        CGPoint pointc = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/4*3);
        CGPoint pointd = CGPointMake(self.bounds.size.width/4*3, self.bounds.size.height/12*3);
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:pointd];
        [path addLineToPoint:pointc];
        [path addLineToPoint:pointb];
        [path addLineToPoint:pointa];
        self.circlePath = path;
        [path setLineWidth:self.lineWidth];
        
        self.circleLayer.path = path.CGPath;
        self.circleLayer.strokeColor = linColor.CGColor;
        self.circleLayer.fillColor   = [[UIColor clearColor] CGColor];
        self.circleLayer.strokeStart = 0;
        self.circleLayer.strokeEnd = 0.7;
        self.circleLayer.lineWidth   = lineWidth;
        
    }else{
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineWidth = lineWidth;
        [self.layer addSublayer:layer];
        CGPoint pointa = CGPointMake(self.bounds.size.width/6, self.bounds.size.height/6);
        CGPoint pointb = CGPointMake(self.bounds.size.width/6*5, self.bounds.size.height/6*5);
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:pointa];
        [path addLineToPoint:pointb];
        layer.path = path.CGPath;
        layer.strokeColor = linColor.CGColor;
        layer.strokeEnd = 0;
        [self strokeEnd:1 animationType:CircularEaseInOut animated:YES duration:1 layer:layer];
        
        CAShapeLayer *layer2 = [CAShapeLayer layer];
        layer2.frame = self.bounds;
        layer2.fillColor = [UIColor clearColor].CGColor;
        layer2.lineWidth = lineWidth;
        [self.layer addSublayer:layer2];
        CGPoint pointa2 = CGPointMake(self.bounds.size.width/6*5, self.bounds.size.height/6);
        CGPoint pointb2 = CGPointMake(self.bounds.size.width/6, self.bounds.size.height/6*5);
        
        UIBezierPath *path2 = [UIBezierPath bezierPath];
        [path2 moveToPoint:pointa2];
        [path2 addLineToPoint:pointb2];
        layer2.path = path2.CGPath;
        layer2.strokeColor = linColor.CGColor;
        layer2.strokeEnd = 0;
        [self strokeEnd:1 animationType:CircularEaseInOut animated:YES duration:1 layer:layer2];
        
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        [animation setDuration:0.08];
        animation.fromValue = @(-M_1_PI/2);
        animation.toValue = @(M_1_PI/2);
        
        animation.repeatCount = 10;
        
        animation.autoreverses = YES;
        self.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.layer addAnimation:animation forKey:@"rotain.z"];
        
    }
    
}






- (void)strokeStart:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration layer:(CAShapeLayer *)layer {
    
    // 过滤掉不合理的值
    if (value <= 0) {
        
        value = 0;
        
    } else if (value >= 1) {
        
        value = 1.f;
    }
    
    if (animated) {
        // 关键帧动画
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeStart";
        keyAnimation.duration             = duration;
        keyAnimation.values               = \
        [YXEasing calculateFrameFromValue:layer.strokeStart
                                  toValue:value
                                     func:func
                               frameCount:duration * 60];
        // 执行动画
       layer.strokeStart = value;
        [layer addAnimation:keyAnimation forKey:nil];
        
    } else {
        // 关闭动画
        [CATransaction setDisableActions:YES];
        layer.strokeStart = value;
        [CATransaction setDisableActions:NO];
    }
}

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}


+ (instancetype)cileViewWithFrame:(CGRect)frame
                      lineWithdth:(CGFloat)width
                        lineColor:(UIColor *)color
                        clockWise:(BOOL)clockWise
                       startAngle:(CGFloat)angle
{
    CircleView *circleView = [[CircleView alloc] initWithFrame:frame];
    circleView.lineWidth   = width;
    circleView.lineColor   = color;
    circleView.clockWise   = clockWise;
    circleView.startAngle  = angle;
    [circleView buildView];
    return circleView;
}


@end
