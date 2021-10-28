//
//  SVProgress.h
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/30.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SVProgress;
NS_ASSUME_NONNULL_BEGIN

@protocol SVProgressDelegate <NSObject>
- (void)beganLongPress:(SVProgress *)progress;
- (void)endedLongPress:(SVProgress *)progress;
@end

@interface SVProgress : UIView
@property (weak, nonatomic) id<SVProgressDelegate> svDelegate;

@end

NS_ASSUME_NONNULL_END
