//
//  AVPlayerController.m
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/16.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "AVPlayerController.h"
#import <AVKit/AVKit.h>

@interface AVPlayerController ()
@property (strong, nonatomic) AVAsset *urlAsset;      //资源
@property (strong, nonatomic) AVPlayerItem *playerItem;//资源管理
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@property (weak, nonatomic) IBOutlet UIView *playerContainer;
- (IBAction)btnClick:(UIButton *)sender;




@end

@implementation AVPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.playerContainer.layer addSublayer:self.playerLayer];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (self.playerItem == object) {
        NSLog(@"change:%@",change);
    }
}


#pragma mark - getter, setter

- (AVAsset *)urlAsset {
    if (!_urlAsset) {
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"top" withExtension:@"mp4"];
        NSURL *url = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
        
        //AVURLAssetPreferPreciseDurationAndTimingKey: 精准时间控制，视频合成时传入
    //    NSDictionary *opt = @{AVURLAssetPreferPreciseDurationAndTimingKey: @(YES)};
        AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:url options:nil];
        NSLog(@"urlAsset:%@",urlAsset);
        _urlAsset = urlAsset;
    }
    return _urlAsset;;
}

- (AVPlayerItem *)playerItem {
    if (!_playerItem) {
        _playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
        [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return _playerItem;
}

- (AVPlayer *)avPlayer {
    if (!_avPlayer) {
        _avPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    }
    return _avPlayer;
}

- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        _playerLayer.frame = self.playerContainer.bounds;
    }
    return _playerLayer;
}

- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:{
            //快退
            if ([self.playerItem canPlayFastReverse]) {
                self.avPlayer.rate = -1;
            }
        }
            break;
        case 20:{
           //播放
            [self.avPlayer play];
        }
            break;
        case 30:{
           //暂停
            [self.avPlayer pause];
        }
            break;
        case 40:{
           //快进
            if ([self.playerItem canPlayFastForward]) {
                self.avPlayer.rate = 2;
            }
        }
            break;
            
        default:
            break;
    }
}
@end
