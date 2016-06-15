//
//  loadingBall.m
//  loading
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "loadingBall.h"
#import "loadingView.h"
@implementation loadingBall

+(void)loadingBallWithTager:(id)tager
{
    loadingView *loadview = [[loadingView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:loadview];
}

+(void)hiddenBall
{
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[loadingView class]]) {
            [window removeFromSuperview];
        }
    }
    
}

@end
