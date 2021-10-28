//
//  ViewController.m
//  ForceRotation
//
//  Created by 周飞 on 2020/8/11.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "InsertCoreDataViewController.h"
#import "WindowHandler.h"

@interface InsertCoreDataViewController ()
@property (strong, nonatomic) WindowHandler *windowHandler;

@end

@implementation InsertCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //接收屏幕选择通知

    
    //UIDeviceOrientationDidChangeNotification: 监听物理设备旋转，会收到陀螺仪触发的通知
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationHandler:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //UIApplicationDidChangeStatusBarOrientationNotification: 监听UI页面变化，只有当页面变化时才收到通知。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationHandler:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    self.windowHandler = [WindowHandler new];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)dealloc {
//    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)leftSetting:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self changeOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        [self changeOrientation:UIInterfaceOrientationPortrait];
    }
    
}

- (IBAction)rightSetting:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self changeOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        [self changeOrientation:UIInterfaceOrientationPortrait];
    }
}

- (IBAction)portraitSetting:(UIButton *)sender {
    [self.windowHandler showToast:@"window 层级 01"];
    [self.windowHandler showToast:@"window 层级 02"];
//    [self changeOrientation:UIInterfaceOrientationPortrait];
}



#pragma mark - tool
- (void)changeOrientation:(UIInterfaceOrientation)orientation
{
    NSInteger val = orientation;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)orientationHandler:(NSNotification *)notification {
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSLog(@"屏幕旋转了...%ld---%@",orientation,self.view);
}


@end
