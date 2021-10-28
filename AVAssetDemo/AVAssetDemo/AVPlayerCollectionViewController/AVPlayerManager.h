//
//  AVPlayerManager.h
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/19.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

typedef void(^AVPlayItemInfoBlock)();

@interface AVPlayerManager : NSObject
@property (strong, nonatomic, readonly) NSString *urlStr;
@property (assign, nonatomic, readonly) Float64 durationsSec;
@property (assign, nonatomic, readonly) NSString * durationsStr;
@property (strong, nonatomic, readonly) UIImage *thumbi;
@property (strong, nonatomic, readonly) AVPlayerLayer *playerLayer;

- (instancetype)initWithPlayItemInfoBlock:(AVPlayItemInfoBlock)itemInfoBlock;
- (void)configUrlString:(NSString *)urlStr;

- (void)clearCache;
- (void)canclePlayCache;
- (void)safePause;
- (void)safePlay ;
@end


