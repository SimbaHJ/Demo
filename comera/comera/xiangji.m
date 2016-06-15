//
//  xiangji.m
//  comera
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "xiangji.h"
#import "wanchengpaizhaoViewController.h"
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface xiangji ()
<
UIGestureRecognizerDelegate,
wanchengDelegate
>
@property (nonatomic, strong) wanchengpaizhaoViewController *WanchengVC;
@property (nonatomic, strong) NSData *iamgeData;
@property (nonatomic, strong) UIImage *dataImage;
@end

@implementation xiangji
{
    BOOL isUsingFrontFacingCamera;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAVCaptureSession];
    [self setUpGsture];
    isUsingFrontFacingCamera = NO;
    self.effectiveScale = self.beginGestureScale = 1.0f;
    // Do any additional setup after loading the view.
}

- (wanchengpaizhaoViewController *)WanchengVC
{
    if (!_WanchengVC) {
        _WanchengVC = [[wanchengpaizhaoViewController alloc] init];
        _WanchengVC.delegate = self;
    }
    return _WanchengVC;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (self.session) {
        [self.session startRunning];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.session) {
        [self.session stopRunning];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




-(void)initAVCaptureSession
{
    self.session = [[AVCaptureSession alloc] init];
    NSError *error;
    AVCaptureDevice *devie = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    [devie setFlashMode:AVCaptureFlashModeAuto];
    [devie unlockForConfiguration];
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:devie error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput: self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    NSLog(@"%f",kMainScreenWidth);
    self.previewLayer.frame = CGRectMake(0, 50, kMainScreenWidth, kMainScreenHeight-110);
    
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    self.backView.layer.masksToBounds = YES;
    
    self.paizhao = [UIButton buttonWithType:UIButtonTypeSystem];
    self.paizhao.frame = CGRectMake(kMainScreenWidth/2-25, CGRectGetMaxY(self.previewLayer.frame)+5, 50, 50);
    self.paizhao.layer.masksToBounds = YES;
    self.paizhao.layer.cornerRadius = 25;
    self.paizhao.backgroundColor = [UIColor whiteColor];
    self.paizhao.userInteractionEnabled = YES;
    self.backView.userInteractionEnabled = YES;
    [self.paizhao addTarget:self action:@selector(jietupaizhao:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.backView addSubview:self.paizhao];
    
    
    [self.view addSubview:self.backView];
    [self.backView.layer addSublayer:self.previewLayer];
    
}

-(AVCaptureVideoOrientation)avOrientationForDeviceOrientation:(UIDeviceOrientation)deiceOrientation
{
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation)deiceOrientation;
    if ( deiceOrientation == UIDeviceOrientationLandscapeLeft )
        result = AVCaptureVideoOrientationLandscapeRight;
    else if ( deiceOrientation == UIDeviceOrientationLandscapeRight )
        result = AVCaptureVideoOrientationLandscapeLeft;
    return result;
}



-(void)setUpGsture
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinch.delegate = self;
    [self.backView addGestureRecognizer:pinch];
}

#pragma mark gestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        self.beginGestureScale = self.effectiveScale;
    }
    return YES;
}
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer{
    
    BOOL allTouchesAreOnThePreviewLayer = YES;
    NSUInteger numTouches = [recognizer numberOfTouches], i;
    for ( i = 0; i < numTouches; ++i ) {
        CGPoint location = [recognizer locationOfTouch:i inView:self.backView];
        CGPoint convertedLocation = [self.previewLayer convertPoint:location fromLayer:self.previewLayer.superlayer];
        if ( ! [self.previewLayer containsPoint:convertedLocation] ) {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
    }
    
    if ( allTouchesAreOnThePreviewLayer ) {
        
        
        self.effectiveScale = self.beginGestureScale * recognizer.scale;
        if (self.effectiveScale < 1.0){
            self.effectiveScale = 1.0;
        }
        
        NSLog(@"%f-------------->%f------------recognizerScale%f",self.effectiveScale,self.beginGestureScale,recognizer.scale);
        
        CGFloat maxScaleAndCropFactor = [[self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
        
        NSLog(@"%f",maxScaleAndCropFactor);
        if (self.effectiveScale > maxScaleAndCropFactor)
            self.effectiveScale = maxScaleAndCropFactor;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:.025];
        [self.previewLayer setAffineTransform:CGAffineTransformMakeScale(self.effectiveScale, self.effectiveScale)];
        [CATransaction commit];
        
    }
    
}


-(void)jietupaizhao:(UIButton *)sender
{
    NSLog(@"拍照");
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    UIDeviceOrientation cuDeviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation avcaptureorientation = [self avOrientationForDeviceOrientation:cuDeviceOrientation];
    [stillImageConnection setVideoOrientation:avcaptureorientation];
    [stillImageConnection setVideoScaleAndCropFactor:self.effectiveScale];
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        UIImage *image = [UIImage imageWithData:jpegData];
        self.iamgeData = jpegData;
        self.dataImage = image;
        
        self.WanchengVC.image = image;
        
        
        [UIView animateWithDuration:0.2 animations:^{
            [self presentViewController:self.WanchengVC animated:NO completion:nil];
        }];
        
        
        
    }];
}


-(void)buttonwancheng:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.xiangjiHUI) {
        self.xiangjiHUI(self.iamgeData,self.dataImage);
    }
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
