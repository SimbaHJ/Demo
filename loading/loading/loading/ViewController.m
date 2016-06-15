//
//  ViewController.m
//  loading
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "loadingBall.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

        [loadingBall loadingBallWithTager:self];
    
//    [self performSelector:@selector(hiden) withObject:nil afterDelay:15];
    
}
-(void)hiden{
    [loadingBall hiddenBall];
    self.view.backgroundColor = [UIColor yellowColor];
    NSLog(@"删除成功");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
