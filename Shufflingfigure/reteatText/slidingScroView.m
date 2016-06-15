//
//  slidingScroView.m
//  reteatText
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "slidingScroView.h"
#import <CoreImage/CoreImage.h>

#define Main_Screen_Width [UIScreen mainScreen].bounds.size.width
#define Main_Screen_Height [UIScreen mainScreen].bounds.size.height
#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
@interface slidingScroView()
<
UIGestureRecognizerDelegate,
UIScrollViewDelegate
>
{
    int isShowIndex;
    int imageIndex;
    CGFloat firstX;
    CGFloat firstY;
}
/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray *dataScoure;
/**
 *  背景
 */
@property (nonatomic, strong) UIImageView *backgImageView;
/**
 *  前一张
 */
@property (nonatomic, strong) UIImageView *beforeImageView;
/**
 *  后一张
 */
@property (nonatomic, strong) UIImageView *afterImageView;
/**
 *  正在显示
 */
@property (nonatomic, strong) UIImageView *isShowImageView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation slidingScroView

-(instancetype)initWithDataScoure:(NSMutableArray *)dataScoure
{
        self.dataScoure = dataScoure;
    CGRect frame = CGRectMake(0,0 ,Main_Screen_Width, Main_Screen_Height);
    if (self = [super initWithFrame:frame]) {
        [self createView];
        
    }
    return self;
    
}


-(void)createView
{
    self.backgImageView = [[UIImageView alloc] initWithFrame:self.frame];
    self.backgImageView.image = [UIImage imageNamed:self.dataScoure[0]];
    self.backgImageView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = self.backgImageView.bounds;
    [self.backgImageView addSubview:visualEffectView];
    [self addSubview:self.backgImageView];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollView.contentSize = CGSizeMake(3*Main_Screen_Width, 0);
    [self.scrollView setContentOffset:CGPointMake(Main_Screen_Width, 0) animated:NO];
    
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    [self addSubview:self.scrollView];
    
    
    self.isShowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height)];
    self.isShowImageView.image = [UIImage imageNamed:self.dataScoure[0]];
    
    self.isShowImageView.layer.masksToBounds = YES;
    self.isShowImageView.layer.cornerRadius = 10;
    self.isShowImageView.layer.masksToBounds = NO;
    self.isShowImageView.layer.shadowOffset = CGSizeMake(0.0, 5.0);
    self.isShowImageView.layer.shadowOpacity = 0.7;
    self.isShowImageView.layer.shadowRadius = 5.0f;
    
    
    [self.scrollView addSubview:self.isShowImageView];
    
    self.beforeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, Main_Screen_Width, Main_Screen_Height)];
    
    
    self.afterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Width*2,0, Main_Screen_Width, Main_Screen_Height)];
    
    isShowIndex = 0;
    
    self.beforeImageView.layer.masksToBounds = YES;
    self.beforeImageView.layer.cornerRadius = 10;
    self.beforeImageView.layer.masksToBounds = NO;
    self.beforeImageView.layer.shadowOpacity = 0.7f;
    self.beforeImageView.layer.shadowOffset = CGSizeMake(0.0, 5.0);
    self.beforeImageView.layer.shadowRadius = 5.0f;
    isShowIndex = 0;
    imageIndex = (int)self.dataScoure.count;
    
    
    self.afterImageView.layer.masksToBounds = YES;
    self.afterImageView.layer.cornerRadius = 10;
    self.afterImageView.layer.masksToBounds = NO;
    self.afterImageView.layer.shadowOpacity = 0.7f;
    self.afterImageView.layer.shadowOffset = CGSizeMake(0.0, 5.0);
    self.afterImageView.layer.shadowRadius = 5.0f;
    
    self.beforeImageView.image = [UIImage imageNamed:[self.dataScoure lastObject]];
    self.afterImageView.image = [UIImage imageNamed:self.dataScoure[1]];
    
    [self.scrollView addSubview:self.beforeImageView];
    [self.scrollView addSubview:self.afterImageView];
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
  CGFloat _factor =MAX(0, (ABS(scrollView.contentOffset.x) / scrollView.frame.size.width));
    NSLog(@"%f",_factor);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
    [self.scrollView setContentOffset:CGPointMake(Main_Screen_Width, 0) animated:NO];
}

-(void)reloadImage
{
    int leftImageIndex,rightImageIndex;
    CGPoint offset = [self.scrollView contentOffset];
    //取余数
    if (offset.x > Main_Screen_Width) {
        isShowIndex = (isShowIndex+1)%imageIndex;
    }else if(offset.x < Main_Screen_Width){
        isShowIndex = (isShowIndex + imageIndex-1)%imageIndex;
    }
    leftImageIndex=(isShowIndex+imageIndex-1)%imageIndex;
    rightImageIndex=(isShowIndex+1)%imageIndex;
    self.isShowImageView.image = [UIImage imageNamed:self.dataScoure[isShowIndex]];
    self.beforeImageView.image = [UIImage imageNamed:self.dataScoure[leftImageIndex]];
    self.afterImageView.image = [UIImage imageNamed:self.dataScoure[rightImageIndex]];
    
    self.backgImageView.image = self.isShowImageView.image;
    
    
    
}



-(void)pageChanged
{
}








//原始point
-(void)poiht
{
    self.isShowImageView.center = self.center;
    self.beforeImageView.center = CGPointMake(-Main_Screen_Width/2, self.backgImageView.center.y);
    self.afterImageView.center = CGPointMake(Main_Screen_Width/2+Main_Screen_Width, self.backgImageView.center.y);

}



-(void)chageImageWith:(CGFloat)x
{
    x = x/20;
   CGPoint point =  self.isShowImageView.center;
    CGPoint pointBefore = self.beforeImageView.center;
    CGPoint pointAfter = self.afterImageView.center;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.isShowImageView.center = CGPointMake(point.x+x, point.y);
        self.beforeImageView.center = CGPointMake(pointBefore.x+x, pointBefore.y);
        self.afterImageView.center = CGPointMake(pointAfter.x+x, pointAfter.y);
    }];
    
    
}

/**
 *  获取图片
 */

-(UIImage *)getImageWith:(NSInteger)show
{
    UIImage *image = [UIImage imageNamed:self.dataScoure[show]];
    return image;
}



- (NSMutableArray *)dataScoure
{
    if (!_dataScoure) {
        _dataScoure = [NSMutableArray array];
    }
    return _dataScoure;
}






@end
