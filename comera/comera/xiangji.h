//
//  xiangji.h
//  comera
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^xiangjifanhui)(NSData *data,UIImage *image);


@interface xiangji : UIViewController
//界面控件
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *paizhao;


//avfoundation

@property(nonatomic)dispatch_queue_t sessionQueue;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, assign) CGFloat beginGestureScale;
@property (nonatomic, assign) CGFloat effectiveScale;
@property (nonatomic, copy) xiangjifanhui xiangjiHUI;
@end
