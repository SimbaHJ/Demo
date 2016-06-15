//
//  wanchengpaizhaoViewController.m
//  comera
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "wanchengpaizhaoViewController.h"
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface wanchengpaizhaoViewController ()

@end

@implementation wanchengpaizhaoViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor blackColor];
    self.imageview = [[UIImageView alloc] init];
    self.imageview.frame = CGRectMake(0, 50, kMainScreenWidth, kMainScreenHeight-150);
    
    self.imageview.backgroundColor = [UIColor redColor];
    self.imageview.image = self.image;
    
    [self.view addSubview:self.imageview];
    
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(kMainScreenWidth-100, CGRectGetMaxY(self.imageview.frame)+10, 100, 50);
    [self.button setTitle:@"使用照片" forState:UIControlStateNormal];
    self.button.tintColor = [UIColor whiteColor];
    
    [self.button addTarget:self action:@selector(wancheng:) forControlEvents:UIControlEventTouchUpInside];
    self.chongbai = [UIButton buttonWithType:UIButtonTypeSystem];
    self.chongbai.frame = CGRectMake(0, CGRectGetMaxY(self.imageview.frame)+10, 100, 50);
    [self.chongbai setTitle:@"重拍" forState:UIControlStateNormal];
    self.chongbai.tintColor = [UIColor whiteColor];
    [self.chongbai addTarget:self action:@selector(fanhi:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.chongbai];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)wancheng:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonwancheng:)]) {
        [self.delegate buttonwancheng:sender];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}



-(void)fanhi:(UIButton *)sener
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
