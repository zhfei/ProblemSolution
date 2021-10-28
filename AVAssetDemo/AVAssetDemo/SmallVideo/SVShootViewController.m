//
//  SVShootViewController.m
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/25.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "SVShootViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SVVideoEditViewController.h"
#import "SVProgress.h"

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

//超过此时间为录制视频，小于此时间为拍照
NSInteger kShootLimitTime = 1;

@interface SVShootViewController ()<AVCaptureFileOutputRecordingDelegate, SVVideoEditViewControllerDelegate, SVProgressDelegate>
@property (weak, nonatomic) IBOutlet UILabel *shootHit;
@property (weak, nonatomic) IBOutlet UIButton *goBackBtn;
@property (weak, nonatomic) IBOutlet UIImageView *focusCursor; //聚焦光标
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cursorCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cursorCenterY;
@property (strong, nonatomic) IBOutlet SVProgress *svProgress;


@property (strong, nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput; //视频输出流
@property (strong, nonatomic) AVCaptureStillImageOutput *captureStillImageOutput; //照片输出流
@property (strong, nonatomic) AVCaptureDeviceInput *captureDeviceInput; //负责从AVCaptureDevice获取输入数据
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundTaskIdentifier; //后台任务标识
@property (assign, nonatomic) UIBackgroundTaskIdentifier lastBackgroundTaskIdentifier; //最新的后台任务标识
@property (strong, nonatomic) AVCaptureSession *session; //负责输入输出设备之间的数据传递

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer; //图像预览层，实时显示捕获的图像
@property (assign, nonatomic) NSTimeInterval recordSeconds; //记录录制时间
@property (strong, nonatomic) NSURL *needSavedVideoUrl; //需要保持的视频URL
@property (assign, nonatomic) BOOL isFocus; //是否对焦
@property (assign, nonatomic) BOOL isVideo; //YES:视频录制， NO:照片



@end

@implementation SVShootViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    

    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupUI];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.session stopRunning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Private Method

- (void)setupUI {
    self.svProgress.svDelegate = self;
    
    [self performSelector:@selector(hideShootHit) withObject:nil afterDelay:4];
    [self buildCamera];
    [self.session startRunning];
}

- (void)reSetupUI {
    if (self.isVideo) {
        self.isVideo = NO;
    }
    self.shootHit.hidden = NO;
    [self performSelector:@selector(hideShootHit) withObject:nil afterDelay:4];
    self.cursorCenterX.constant = 0;
    self.cursorCenterY.constant = 0;
    [self.session startRunning];
}


- (void)setupData {
    
}

- (void)buildCamera {
    self.session = [[AVCaptureSession alloc] init];
    
    //设置高分辨率
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        self.session.sessionPreset = AVCaptureSessionPresetHigh;
    }
    
    //获取后置摄像头
    AVCaptureDevice *backDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
    //获取音频录入设备
    AVCaptureDevice *audioDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    //初始化输入设备(摄像头)
    NSError *error;
    self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:backDevice error:&error];
    if (error) {
        NSLog(@"输入设备初始化失败，原因：%@",error.localizedDescription);
        return;
    }
    
    //创建音频输入设备
    error = nil;
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:&error];
    if (error) {
        NSLog(@"输入设备初始化失败，原因：%@",error.localizedDescription);
        return;
    }
    
    
    //输出对象(视频输出)
    self.captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    //添加输入设备到会话
    if ([self.session canAddInput:self.captureDeviceInput]) {
        [self.session addInput:self.captureDeviceInput];
        [self.session addInput:audioInput];
        
        //设置视频防抖
        AVCaptureConnection *connection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([connection isVideoStabilizationSupported]) {
            connection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeCinematic;
        }
    }
    
    //添加输出设备到会话(刚开始，输出对象是照片)
    if ([self.session canAddOutput:self.captureMovieFileOutput]) {
        [self.session addOutput:self.captureMovieFileOutput];
    }
    
    //创建视频预览层，实时展示摄像头状态
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = self.view.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    [self addNotificationToCaptureDevice:backDevice];
    [self addGenstureRecognizer];
}

//获取指定位置的摄像头
- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)devicePosition {
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in cameras) {
        if (device.position == devicePosition) {
            return device;
        }
    }
    return nil;
}

///MARK: 通知监听
- (void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice {
    //添加监听“区域变化捕获”(场景变化了，如果光线变亮等)通知前，需要先将设备的属性打开，允许捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled = YES;
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subjectAreaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

- (void)removeNotificationForCaptureDevice:(AVCaptureDevice *)captureDevice {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

- (void)removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//改变设备属性统一操作方法
- (void)changeDeviceProperty:(PropertyChangeBlock)changeBlock {
    AVCaptureDevice *captureDevice = [self.captureDeviceInput device];
    NSError *error;
    //修改设备属性前，需要先锁定lockForConfiguration。修改完后在解锁
    if ([captureDevice lockForConfiguration:&error]) {
        //自动白平衡
        if ([captureDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
            captureDevice.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
        }
        //根据环境，自动开启闪光灯
        if ([captureDevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
            captureDevice.flashMode = AVCaptureFlashModeAuto;
        }
        
        changeBlock(captureDevice);
        
        [captureDevice unlockForConfiguration];
    } else {
        NSLog(@"设置设备属性错误：%@",error.localizedDescription);
    }
}

// MARK: overwrite
- (void)hideShootHit {
    self.shootHit.hidden = YES;
}

- (void)subjectAreaChange:(NSNotification *)notification {
    NSLog(@"捕获场景 主题 发生改变");
}

- (void)addGenstureRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreenAction:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapScreenAction:(UITapGestureRecognizer *)tapGesture {
    if ([self.session isRunning]) {
        CGPoint point = [tapGesture locationInView:self.view];
        
        //将UI坐标转换成摄像头坐标
        CGPoint cameraPoint = [self.previewLayer captureDevicePointOfInterestForPoint:point];
        //闪烁聚焦光标
        [self setFocusCursorWithPoint:cameraPoint];
        //设置曝光，聚焦
        [self focusWithMode:AVCaptureFocusModeAutoFocus exposureModel:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
        
    }
}

//设置聚焦光标位置
- (void)setFocusCursorWithPoint:(CGPoint)point {
    if (!self.isFocus) {
        self.isFocus = YES;
        
        self.cursorCenterX.constant = point.x;
        self.cursorCenterY.constant = point.y;
        
        self.focusCursor.transform = CGAffineTransformMakeScale(1.25, 1.25);
        self.focusCursor.alpha = 1.0;
        [UIView animateWithDuration:0.5 animations:^{
            self.focusCursor.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(hideFocusCurSor) withObject:nil afterDelay:0.5];
        }];
    }
}

- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureModel:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point {
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            captureDevice.exposureMode = exposureMode;
        }
        
        if ([captureDevice isFocusModeSupported:focusMode]) {
            captureDevice.focusMode = focusMode;
        }
    }];
}

- (void)hideFocusCurSor {
    self.focusCursor.alpha = 0;
    self.isFocus = NO;
}

- (void)endVideoRecord {
    [self.captureMovieFileOutput stopRecording];
}



#pragma mark - Public Method

#pragma mark - Event

- (IBAction)goBackAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)switchCaptureDevice:(UIButton *)sender {
    NSLog(@"切换摄像头");
    AVCaptureDevice *currentDevice = [self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition = [currentDevice position];
    [self removeNotificationForCaptureDevice:currentDevice];
    
    
    AVCaptureDevicePosition toPosition = AVCaptureDevicePositionFront;
    if (currentPosition == AVCaptureDevicePositionFront || currentPosition == AVCaptureDevicePositionUnspecified) {
        toPosition = AVCaptureDevicePositionBack;
    }
    AVCaptureDevice *toDevice = [self getCameraDeviceWithPosition:toPosition];
    [self addNotificationToCaptureDevice:toDevice];
    
    //在session中调整设备输入对象
    NSError *error;
    //创建新设备输入对象
    AVCaptureDeviceInput *toDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:toDevice error:&error];
    
    //修改会话配置前，要先开启配置
    [self.session beginConfiguration];
    //移旧，加新
    [self.session removeInput:self.captureDeviceInput];
    if ([self.session canAddInput:toDeviceInput]) {
        [self.session addInput:toDeviceInput];
        self.captureDeviceInput = toDeviceInput;
    }
    //提交
    [self.session commitConfiguration];
}


#pragma mark - Delegate

//MARK: AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error {
    
}

//MARK: SVVideoEditViewControllerDelegate
- (void)resetRecordVideo:(SVVideoEditViewController *)videoEditVC {
    [self reSetupUI];
}

//MARK: SVProgressDelegate
- (void)beganLongPress:(SVProgress *)progress {
    //获取输出设备的 连接
    AVCaptureConnection *connect = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeAudio];
    
    //根据连接，获取设备输出的数据
    if (![self.captureMovieFileOutput isRecording]) {
        if ([[UIDevice currentDevice] isMultitaskingSupported]) {
            self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
            if (self.needSavedVideoUrl) {
                [[NSFileManager defaultManager] removeItemAtURL:self.needSavedVideoUrl error:nil];
            }
        }
        
        //设置预览图层和视频方向保存一致
        connect.videoOrientation = [self.previewLayer connection].videoOrientation;
        NSString *outputFP = [NSTemporaryDirectory() stringByAppendingString:@"myMove.mov"];
        NSLog(@"move save at: %@",outputFP);
        NSURL *outputUrl = [NSURL fileURLWithPath:outputFP];
        [self.captureMovieFileOutput startRecordingToOutputFileURL:outputUrl recordingDelegate:self];
    } else {
        [self.captureMovieFileOutput stopRecording];
    }
}

- (void)endedLongPress:(SVProgress *)progress {
    NSLog(@"结束录制");
    if (!self.isVideo) {
        [self performSelector:@selector(endVideoRecord) withObject:nil afterDelay:0.3];
    } else {
        [self endVideoRecord];
    }
    
    SVVideoEditViewController *videoEdit = [[SVVideoEditViewController alloc] initWithNibName:@"SVVideoEditViewController" bundle:nil];
    videoEdit.delegate = self;
    [self presentViewController:videoEdit animated:YES completion:nil];
}

#pragma mark - Getter, Setter


#pragma mark - NSCopying

#pragma mark - NSObject


@end
