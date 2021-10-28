//
//  AVPlayerWindow.m
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/17.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "AVPlayerWindow.h"
#import <Masonry.h>

static AVPlayerWindow *playerWindow;

@implementation AVPlayerWindow


+ (instancetype)playerWindow {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 13.0, *)) {
            NSSet<UIScene *> *connectedScenes = [[UIApplication sharedApplication] connectedScenes];
            
            NSPredicate *predice =[NSPredicate predicateWithFormat:@"activationState == %d",UISceneActivationStateForegroundActive];
            UIWindowScene *foregroundScene = (UIWindowScene *)[[connectedScenes filteredSetUsingPredicate:predice] anyObject];
            playerWindow = [[AVPlayerWindow alloc] initWithWindowScene:foregroundScene];
        } else {
            playerWindow = [[AVPlayerWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
        
        playerWindow.windowLevel = UIWindowLevelAlert+1;
        playerWindow.rootViewController = [[UIViewController alloc] init];
        playerWindow.backgroundColor = [UIColor blueColor];
    });
    
    return playerWindow;
}

+ (void)addFullScreenView:(UIView *)subView {
    UIViewController *rootVC = playerWindow.rootViewController;
    [rootVC.view addSubview:subView];
    [subView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

+ (UIView *)rootVCView {
    return playerWindow.rootViewController.view;
}

@end
