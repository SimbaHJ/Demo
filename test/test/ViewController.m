//
//  ViewController.m
//  test
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "GCD/GCD.h"
#import "CircleView.h"
@interface ViewController ()
@property (nonatomic, assign) BOOL  result;
@property (nonatomic, strong) GCDTimer    *timer;
@property (nonatomic, strong) CircleView *cleView;

@end

@implementation ViewController
- (IBAction)bigin:(id)sender {
    [self.cleView.layer removeFromSuperlayer];
    self.cleView =  [CircleView cileViewWithFrame:CGRectMake(0, 0, 100, 100)
                                      lineWithdth:2
                                        lineColor:[UIColor blackColor]
                                        clockWise:YES
                                       startAngle:180/3];
    [self.view addSubview:self.cleView ];
    self.cleView .center = self.view.center;
    [self.cleView startAnmimation];
}
- (IBAction)action:(id)sender {
    self.result = !self.result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cleView =  [CircleView cileViewWithFrame:CGRectMake(0, 0, 100, 100)
                                          lineWithdth:2
                                            lineColor:[UIColor blackColor]
                                            clockWise:YES
                                           startAngle:180/3];
    [self.view addSubview:self.cleView ];
    self.cleView .center = self.view.center;
    [self.cleView startAnmimation];

}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.cleView stopAnimating:self.result];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
