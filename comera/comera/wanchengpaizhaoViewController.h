//
//  wanchengpaizhaoViewController.h
//  comera
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol wanchengDelegate <NSObject>

-(void)buttonwancheng:(UIButton *)sender;

@end


@interface wanchengpaizhaoViewController : UIViewController

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *chongbai;

@property (nonatomic, strong) UIImage *image;


@property (nonatomic, assign) id<wanchengDelegate>delegate;


@end
