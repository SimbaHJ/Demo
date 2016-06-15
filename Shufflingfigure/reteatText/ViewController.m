//
//  ViewController.m
//  reteatText
//
//  Created by apple on 16/4/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "slidingScroView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil];
    
    slidingScroView *scroView = [[slidingScroView alloc] initWithDataScoure:array];
    
    [self.view addSubview:scroView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
