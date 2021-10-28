//
//  AVPlayerManager.m
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/19.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "AVPlayerManager.h"
#import <YYKit/YYMemoryCache.h>
#import <YYKit/YYDiskCache.h>

static YYMemoryCache *playerMemoryCache;
static YYDiskCache *playerDiskCache;

@interface AVPlayerManager ()
@property (strong, nonatomic) AVAsset *urlAsset;      //资源
@property (strong, nonatomic) AVPlayerItem *playerItem;//资源管理
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;


@property (strong, nonatomic, readwrite) NSString *urlStr;
@property (copy, nonatomic) AVPlayItemInfoBlock itemInfoBlock;

@property (assign, nonatomic) Float64 durationsSec;
@property (strong, nonatomic, readwrite) UIImage *thumbi;
@end

@implementation AVPlayerManager
+ (void)initialize {
    if (!playerMemoryCache) {
        playerMemoryCache = [YYMemoryCache new];
        playerMemoryCache.countLimit = 100; //最多保存1000个
        playerMemoryCache.costLimit = 1024*1024*10; //10M
        playerMemoryCache.ageLimit = 60*60*24; //一天
        playerMemoryCache.autoTrimInterval = 60*60;
    }
    
    if (!playerDiskCache) {
        NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [documentDir stringByAppendingString:@"/playerDiskCache/playerCache"];
        [[NSFileManager defaultManager] createDirectoryAtURL:[NSURL fileURLWithPath:path] withIntermediateDirectories:YES attributes:nil error:nil];
        playerDiskCache = [[YYDiskCache alloc] initWithPath:path];
        playerDiskCache.costLimit = NSUIntegerMax;
        playerDiskCache.countLimit = NSUIntegerMax;
        playerDiskCache.ageLimit = 60*60*24*7; //一周
        playerDiskCache.autoTrimInterval = 60*60*24;
    }
}

- (instancetype)initWithPlayItemInfoBlock:(AVPlayItemInfoBlock)itemInfoBlock
{
    self = [super init];
    if (self) {
        self.itemInfoBlock = itemInfoBlock;
    }
    return self;
}

- (void)configUrlString:(NSString *)urlStr {
    self.urlStr = urlStr;
    self.urlAsset = nil;

    NSNumber *durNum = [self stringFromCache:[self durationKey]];
    if (!durNum || [durNum floatValue] < 0.1 || ![self imageFromCache:[self imageKey]]) {
        [self locationAssetUsing];
    } else {
        self.durationsSec = [[self stringFromCache:[self durationKey]] floatValue];
        self.thumbi = [self imageFromCache:[self imageKey]];
    }
}

- (void)clearCache {
    [playerMemoryCache removeAllObjects];
    [playerDiskCache removeAllObjects];
}

- (void)canclePlayCache {
    [self.avPlayer replaceCurrentItemWithPlayerItem:nil];
    self.playerItem = nil;
    self.avPlayer = nil;
    self.playerLayer = nil;
}


- (void)safePause {
    if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
        [self.avPlayer pause];
    }
}

- (void)safePlay {
    if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPaused) {
        if (CMTimeCompare([self.playerItem currentTime], [self.playerItem duration]) == 0) {
            [self.playerItem seekToTime:kCMTimeZero];
        }
        [self.avPlayer play];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([object isKindOfClass:[AVPlayerItem class]]) {
        if([keyPath isEqualToString:@"status"]) {
            switch(_playerItem.status) {
                case AVPlayerItemStatusReadyToPlay://推荐将视频播放放这里
                    NSLog(@"AVPlayerItemStatusReadyToPlay");
                    break;
                case AVPlayerItemStatusUnknown:
                    NSLog(@"AVPlayerItemStatusUnknown");
                    break;
                case AVPlayerItemStatusFailed:
                    NSLog(@"AVPlayerItemStatusFailed");
                    break;
                default:break;
            }
    
        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            NSArray<NSValue *> *ltr = self.playerItem.loadedTimeRanges;
            //本次缓存的时间范围
            CMTimeRange timeRange = [ltr.firstObject CMTimeRangeValue];
            //缓存的总长度
            CMTime totalTime = CMTimeAdd(timeRange.start, timeRange.duration);
            Float64 sec = CMTimeGetSeconds(totalTime);
            NSLog(@"缓存的总长度: %lf",sec);
  
        } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
            NSLog(@"缓存充足，可进行播放");
        } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
            NSLog(@"缓存用完，无法进行播放");
        }
    }
}

#pragma mark - privite
- (void)locationAssetUsing {
    NSArray *keys = @[@"duration",@"tracks"];
    [self.urlAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus stracksState = [self.urlAsset statusOfValueForKey:@"duration" error:&error];
        switch (stracksState) {
            case AVKeyValueStatusLoaded:
                NSLog(@"信息加载成功：%@",(AVURLAsset *)self.urlAsset);
                break;
            case AVKeyValueStatusFailed:
                NSLog(@"信息加载失败：%@",(AVURLAsset *)self.urlAsset);
                break;
            case AVKeyValueStatusCancelled:
                NSLog(@"取消信息加载：%@",(AVURLAsset *)self.urlAsset);
                break;
            default:
                break;
        }
        
        
        //缓存时间
        self.durationsSec = CMTimeGetSeconds([self.urlAsset duration]);
        [self saveToCache:@(self.durationsSec) keyStr:[self durationKey]];
        //缓存首帧图片
        [self getImageFromVideo:self.urlAsset];
    }];

}

// 导出单个时间点的图片
- (void)getImageFromVideo:(AVURLAsset *)asset {
    //asset 中是否包含视频轨迹
    if ([[asset tracksWithMediaType:AVMediaTypeVideo] count] > 0) {
        AVAssetImageGenerator *imageGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        imageGen.appliesPreferredTrackTransform = YES;
        
        Float64 durationsSec = CMTimeGetSeconds([asset duration]);
        CMTime midpoint = CMTimeMakeWithSeconds(durationsSec/2, 600);
        
        NSError *error;
        CMTime actualTime;
        CGImageRef halfWayImage = [imageGen copyCGImageAtTime:midpoint actualTime:&actualTime error:&error];

        if (halfWayImage != NULL) {
            NSString *reqTimeStr = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, midpoint));
            NSString *actTimeStr = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));

            UIImage *image = [UIImage imageWithCGImage:halfWayImage];

            NSLog(@"导出指定时间帧图片: 期望时间 %@, 时间时间 %@", reqTimeStr, actTimeStr);
            CFRelease(halfWayImage);

            self.thumbi = image;
            [self saveToCache:image keyStr:[self imageKey]];
            [self performBlock];
        }
    }
}

- (void)performBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.itemInfoBlock) {
            self.itemInfoBlock();
        }
    });
}

- (NSString *)durationKey {
    return [self.urlStr.uppercaseString stringByAppendingString:@"_du"];
}

- (NSString *)imageKey {
    return [self.urlStr.uppercaseString stringByAppendingString:@"_im"];
}

- (NSNumber *)stringFromCache:(NSString *)keyStr {
    NSNumber *memStr = [playerMemoryCache objectForKey:keyStr];
    if (!memStr) {
        memStr = [playerDiskCache objectForKey:keyStr];
    }
    return memStr;
}

- (UIImage *)imageFromCache:(NSString *)keyStr {
    UIImage *memStr = [playerMemoryCache objectForKey:keyStr];
    if (!memStr) {
        memStr = [playerDiskCache objectForKey:keyStr];
    }
    return memStr;
}

- (void)saveToCache:(NSObject *)obj keyStr:(NSString *)keyStr {
    [playerMemoryCache setObject:obj forKey:keyStr];
    [playerDiskCache setObject:obj forKey:keyStr];
}


#pragma mark - getter, setter
- (AVAsset *)urlAsset {
    if (!_urlAsset) {
        NSURL *url = [NSURL URLWithString:self.urlStr];
        
        //添加请求头认证，防止盗链
        NSMutableDictionary* headers = [NSMutableDictionary dictionary];
        [headers setObject:@"iOS_d"forKey:@"User-Agent"];
        
        //AVURLAssetPreferPreciseDurationAndTimingKey: 精准时间控制，视频合成时传入
    //    NSDictionary *opt = @{AVURLAssetPreferPreciseDurationAndTimingKey: @(YES)};
        AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:url options:@{@"AVURLAssetHTTPHeaderFieldsKey": headers}];
        NSLog(@"urlAsset:%@",(AVURLAsset *)urlAsset.URL);
        _urlAsset = urlAsset;
    }
    return _urlAsset;;
}

- (AVPlayerItem *)playerItem {
    if (!_playerItem) {
        _playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
        [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        //监听缓存情况
        [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        //监听缓存充足，可以进行播放
        [_playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
        //缓存为空，无法进行播放
        [_playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _playerItem;
}

- (AVPlayer *)avPlayer {
    if (!_avPlayer) {
        _avPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
        //每隔一秒 在主队列刷新一次
        __weak typeof(self)weakSelf=self;
        [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
            CMTime currentTime = weakSelf.playerItem.currentTime;
            CGFloat cct = currentTime.value/currentTime.timescale;
            NSLog(@"当前播放时间：%lf, 当前播放进度: %.2lf",cct, cct / weakSelf.durationsSec);
        }];
    }
    return _avPlayer;
}

- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        _playerLayer.frame = CGRectMake(0, 0, 100, 100);
    }
    return _playerLayer;
}

- (NSString *)durationsStr {
    return [NSString stringWithFormat:@"总时长：%.lf",self.durationsSec];
}

- (void)setThumbi:(UIImage *)thumbi {
    _thumbi = thumbi;
}

- (void)setDurationsSec:(Float64)durationsSec {
    _durationsSec = durationsSec;
}

@end
