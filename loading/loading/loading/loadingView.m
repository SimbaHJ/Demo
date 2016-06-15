//
//  loadingView.m
//  loading
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "loadingView.h"

#import <pop/POP.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#define Main_width [UIScreen mainScreen].bounds.size.width
#define Main_height [UIScreen mainScreen].bounds.size.height

@interface whiteBall : UIView

@property (nonatomic, assign) CGFloat Y;
@property (nonatomic, strong) UIColor* backColor;
@end
@implementation whiteBall
@synthesize Y;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        Y = 0;
    }
    return self;
}
-(void)gaibianyansewith:(UIColor *)color
{
    self.backColor = color;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat offset = width/3.6;
    CGPoint pointA = CGPointMake(width/2, 0+Y);
    CGPoint pointB = CGPointMake(width, height/2);
    CGPoint pointC = CGPointMake(width/2, height-Y);
    CGPoint pointD = CGPointMake(0, height/2);
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, pointB.y - offset);
    CGPoint c3 = CGPointMake(pointB.x, pointB.y + offset);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, pointD.y + offset);
    CGPoint c7 = CGPointMake(pointD.x, pointD.y - offset);
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint:pointA];
    [ovalPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [ovalPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [ovalPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [ovalPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [ovalPath closePath];
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetFillColorWithColor(ctx, _backColor.CGColor);
    CGContextFillPath(ctx);

}


@end

@interface loadingView()

@property (nonatomic, assign) CGFloat Y;
@property (nonatomic, strong) whiteBall *whiteballview;
@property (nonatomic, strong) whiteBall *blackView;
@end

@implementation loadingView

//@synthesize whiteBall;
@synthesize blackView;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor lightGrayColor];
        self.alpha = 0.8;
        [self createview];
        [self performSelector:@selector(point) withObject:nil/*可传任意类型参数*/ afterDelay:1.0];
//        [self point];
    }
    return self;
}


-(void)createview
{
    self.whiteballview = [[whiteBall alloc] initWithFrame:CGRectMake(Main_width/2-10, -100, 20, 20)];
    self.whiteballview.backColor = [UIColor redColor];
    blackView = [[whiteBall alloc] initWithFrame:CGRectMake(Main_width/2-25, Main_height+100, 50, 50)];
    blackView.backColor = [UIColor blackColor];
    blackView.alpha = 1;
    self.whiteballview.alpha = 1;
    [self addSubview:self.whiteballview];
    [self addSubview:blackView];
    self.whiteballview.clipsToBounds = YES;
    blackView.clipsToBounds = YES;
}

-(void)point
{
    [self popView:self.whiteballview panduan:^(CGPoint toPoint) {
        
    }];
    [self shangshengView:blackView panduan:^(CGPoint toPoint) {
        
    }];
    [self performSelector:@selector(wanchegn) withObject:nil/*可传任意类型参数*/ afterDelay:5.2];
    
    
}

-(void)wanchegn
{
    [self wancheng:blackView with:self.whiteballview];

}

-(void)popView:(UIView *)view panduan:(void(^)(CGPoint toPoint)) panduan
{
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(Main_width/2, Main_height/2)];
    anim.beginTime = CACurrentMediaTime()+1.0f;
    anim.springBounciness = 10.0f;
    [view pop_addAnimation:anim forKey:@"center"];
    
}

-(void)shangshengView:(UIView *)view panduan:(void(^)(CGPoint toPoint)) panduan
{
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(Main_width/2, Main_height-100)];
    anim.springBounciness = 15;
    [view pop_addAnimation:anim forKey:@"center"];
}


-(void)wancheng:(whiteBall *)view with:(whiteBall *)whiteView
{
    
//    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(Main_width/2, Main_height/2)];
//    anim.springBounciness = 15;
//    anim.springSpeed = 5;
//    anim.dynamicsMass = 0.5;
//    [view pop_addAnimation:anim forKey:@"center"];
//    
//    
//    
//    POPSpringAnimation *whiteanim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    whiteanim.toValue = [NSValue valueWithCGPoint:CGPointMake(Main_width/2, Main_height/2)];
//    whiteanim.springBounciness = 15;
//    whiteanim.springSpeed = 5;
//    whiteanim.dynamicsMass = 0.5;
//    [whiteView pop_addAnimation:whiteanim forKey:@"center"];
//    
//    
//    POPSpringAnimation *whiteanim2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
//    whiteanim2.toValue = [NSValue valueWithCGPoint:CGPointMake(Main_width*2, Main_height*2)];
//    whiteanim2.springBounciness = 5;
//    whiteanim2.springSpeed = 5;
//    whiteanim2.dynamicsMass = 20;
//    [view pop_addAnimation:whiteanim2 forKey:@"size"];
//    [view gaibianyansewith:[UIColor whiteColor]];
}



@end



