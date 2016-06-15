//
//  imageviewcontroller.h
//  Drawing
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageviewcontroller : UIViewController
@property (nonatomic, strong) UIImage *iamge;
@property (weak, nonatomic) IBOutlet UIImageView *mainimage;

@end
