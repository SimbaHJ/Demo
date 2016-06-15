//
//  CircleView.h
//  test
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCD/GCD.h"
#import "YXEasing.h"
@interface CircleView : UIView
@property (nonatomic, strong) GCDTimer    *timer;
@property (nonatomic        ) CGFloat        lineWidth;
@property (nonatomic, strong) UIColor        *lineColor;
@property (nonatomic        ) BOOL           clockWise;
@property (nonatomic        ) CGFloat        startAngle;
@property (nonatomic, strong) UIBezierPath *circlePath;

- (void)buildView;

- (void)startAnmimation;
- (void)stopAnimating:(BOOL)state;

+ (instancetype)cileViewWithFrame:(CGRect)frame
                      lineWithdth:(CGFloat)width
                        lineColor:(UIColor *)color
                        clockWise:(BOOL)clockWise
                       startAngle:(CGFloat)angle;

- (void)performBlock:(void(^)())block
          afterDelay:(NSTimeInterval)delay;

- (void)strokeStart:(CGFloat)value
      animationType:(AHEasingFunction)func
           animated:(BOOL)animated
           duration:(CGFloat)duration;

- (void)strokeEnd:(CGFloat)value
    animationType:(AHEasingFunction)func
         animated:(BOOL)animated
         duration:(CGFloat)duration;
@end
