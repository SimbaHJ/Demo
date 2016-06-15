//
//  ViewController.m
//  Drawing
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "TouchDrawView.h"
#import "imageviewcontroller.h"
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *pointaray;
@property (nonatomic, strong) TouchDrawView *drewArea;
@property (nonatomic, strong) imageviewcontroller *imagecontroller;
@end


@implementation ViewController

@synthesize drewArea;


-(void)loadView
{
    drewArea = [[TouchDrawView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50)];
    drewArea.backgroundColor = [UIColor whiteColor];
    self.view = drewArea;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, CGRectGetMaxY(drewArea.frame),  [UIScreen mainScreen].bounds.size.width/3, 50);
    [button setTitle:@"撤销" forState:UIControlStateNormal];
    
    UIButton *queding = [UIButton buttonWithType:UIButtonTypeSystem];
    queding.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/3, CGRectGetMaxY(drewArea.frame), [UIScreen mainScreen].bounds.size.width/3, 50);
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    UIButton *chongzuo = [UIButton buttonWithType:UIButtonTypeSystem];
    chongzuo.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/3*2, CGRectGetMaxY(drewArea.frame),  [UIScreen mainScreen].bounds.size.width/3, 50);
    [chongzuo setTitle:@"重做" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    [self.view addSubview:queding];
    [self.view addSubview:chongzuo];
    [button addTarget:self action:@selector(chexiao:) forControlEvents:UIControlEventTouchUpInside];
    [queding addTarget:self action:@selector(queding:) forControlEvents:UIControlEventTouchUpInside];
    [chongzuo addTarget:self action:@selector(chongzuo:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)chexiao:(UIButton *)sneder
{
    [drewArea undo];
}

-(void)queding:(UIButton *)sneder
{
    self.imagecontroller = [[imageviewcontroller alloc] init];
    self.imagecontroller.iamge = [drewArea getImage:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50)];
    
//    [self.navigationController pushViewController:self.imagecontroller animated:YES];
    [self presentViewController:self.imagecontroller animated:YES completion:nil];
    NSLog(@" 截屏");
}
-(void)chongzuo:(UIButton *)sender
{
    [drewArea redo];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
