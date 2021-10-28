//
//  AVPlayerWindow.h
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/17.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVPlayerWindow : UIWindow
+ (instancetype)playerWindow;
+ (void)addFullScreenView:(UIView *)subView;
+ (UIView *)rootVCView;
@end

NS_ASSUME_NONNULL_END
