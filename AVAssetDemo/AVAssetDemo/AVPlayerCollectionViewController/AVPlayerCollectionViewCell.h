//
//  AVPlayerCollectionViewCell.h
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/19.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
@class AVPlayerCollectionViewCell;

NS_ASSUME_NONNULL_BEGIN

@protocol AVPlayerCollectionViewCellDelegate <NSObject>
- (void)playerCollectionViewCellSetDataComplete:(AVPlayerCollectionViewCell *)cell;

@end

@interface AVPlayerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) id<AVPlayerCollectionViewCellDelegate> delegate;
@property (strong, nonatomic, readonly) AVPlayer *avPlayer;
- (void)configUrlString:(NSString *)urlStr;
- (UIView *)getPlayerContainer;
- (void)clearCache;

- (void)canclePlayCache;
- (void)safePause;
- (void)safePlay ;
@end

NS_ASSUME_NONNULL_END
