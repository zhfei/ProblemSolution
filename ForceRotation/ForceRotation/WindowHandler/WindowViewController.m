//
//  WindowViewController.m
//  ForceRotation
//
//  Created by 周飞 on 2020/8/12.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "WindowViewController.h"

@interface WindowViewController ()

@end

@implementation WindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)leftSetting:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self changeOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        [self changeOrientation:UIInterfaceOrientationPortrait];
    }
    
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

@end
