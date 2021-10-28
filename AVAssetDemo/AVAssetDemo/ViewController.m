//
//  ViewController.m
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/16.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "AVPlayerCollectionViewController.h"
#import "SVShootViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()
@property (strong, nonatomic) AVAsset *urlAsset;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)samllVideoAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self cmTimeUsing];
    [self locationAssetUsing];
    [self photoAssetUsing];
    [self cupAndTransVideo];
    
    UIImage *image = [UIImage imageNamed:@"cat.jpeg"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://kano.guahao.cn/InK344835005"] placeholderImage:image];
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"AVPlayerCollectionViewController"]) {
        AVPlayerCollectionViewController *plerVC = [[AVPlayerCollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewLayout new]];
        [self.navigationController pushViewController:plerVC animated:YES];
        
        return NO;
    }
    
    return YES;
}

- (void)cmTimeUsing {
//    CMTime time0 = CMTimeMake(分子, 分母);
    CMTime time0 = CMTimeMake(300, 3);
    CMTime time1 = CMTimeMake(400, 2);

    if (CMTimeCompare(time0, time1)) {
        NSLog(@"time1 and time2 are the same");
    }
}

// 加载mainBundle中的视频信息，并导出某个时间点的图片
- (void)locationAssetUsing {
    NSArray *keys = @[@"duration",@"playable"];
    [self.urlAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus stracksState = [self.urlAsset statusOfValueForKey:@"duration" error:&error];
        AVKeyValueStatus playState = [self.urlAsset statusOfValueForKey:@"playable" error:&error];
        switch (stracksState) {
            case AVKeyValueStatusLoaded:
                [self updateUIForDuration:self.urlAsset];
                break;
            case AVKeyValueStatusFailed:
                [self updateUIForDuration:self.urlAsset];
                break;
            case AVKeyValueStatusCancelled:
                [self updateUIForDuration:self.urlAsset];
                break;
            default:
                break;
        }
    }];
    
    [self getImagesFromVideo:self.urlAsset];
}

// 加载相册中的视频信息，并导出某个时间点的图片
- (void)photoAssetUsing {
    //访问用户相册中的视频资源
    ALAssetsLibrary *al = [[ALAssetsLibrary alloc] init];
    [al enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allVideos]];
        
        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:0 usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                ALAssetRepresentation *rep = [result defaultRepresentation];
                NSURL *url = [rep url];
                AVAsset *ava = [AVURLAsset URLAssetWithURL:url options:nil];
                
                [self getImageFromVideo:ava];
            }
        }];
        
    } failureBlock:^(NSError *error) {
        
    }];
    

//    PHPhotoLibrary *ph = [[PHPhotoLibrary alloc] init];

}

// 导出单个时间点的图片
- (void)getImageFromVideo:(AVAsset *)asset {
    //asset 中是否包含视频轨迹
    if ([[asset tracksWithMediaType:AVMediaTypeVideo] count] > 0) {
        AVAssetImageGenerator *imageGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        Float64 durationsSec = CMTimeGetSeconds([asset duration]);
        CMTime midpoint = CMTimeMakeWithSeconds(durationsSec/2, 600);
        NSError *error;
        CMTime actualTime;
        
        CGImageRef halfWayImage = [imageGen copyCGImageAtTime:midpoint actualTime:&actualTime error:&error];
        
        if (halfWayImage != NULL) {
            NSString *reqTimeStr = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, midpoint));
            NSString *actTimeStr = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));
            
            UIImage *image = [UIImage imageWithCGImage:halfWayImage];
            
            NSLog(@"Got halfWayImage: Asked for %@, got %@", reqTimeStr, actTimeStr);
            CFRelease(halfWayImage);

        }
    }
}

// 导出多个个时间点的图片
- (void)getImagesFromVideo:(AVAsset *)asset {
    //asset 中是否包含视频轨迹
    if ([[asset tracksWithMediaType:AVMediaTypeVideo] count] > 0) {
        AVAssetImageGenerator *imageGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        //生成多个时间点的图片
        Float64 durationsSec = CMTimeGetSeconds([asset duration]);
        CMTime firstThird = CMTimeMakeWithSeconds(durationsSec/3, 600);
        CMTime secondThird = CMTimeMakeWithSeconds(durationsSec*2/3, 600);
        CMTime end = CMTimeMakeWithSeconds(durationsSec, 600);
        NSError *error;
        CMTime actualTime;
        
        NSArray *times = @[[NSValue valueWithCMTime:kCMTimeZero],
                           [NSValue valueWithCMTime:firstThird],
                           [NSValue valueWithCMTime:secondThird],
                           [NSValue valueWithCMTime:end]];
        
        [imageGen generateCGImagesAsynchronouslyForTimes:times completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
            NSString *reqTimeStr = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, requestedTime));
            NSString *actTimeStr = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));
            NSLog(@"Got halfWayImage: Asked for %@, got %@", reqTimeStr, actTimeStr);
            if (AVAssetImageGeneratorSucceeded == result) {
                UIImage *imageU = [UIImage imageWithCGImage:image];
                
                NSLog(@"imageU: %@",imageU);
            }
            
            if (AVAssetImageGeneratorCancelled == result) {
                [imageGen cancelAllCGImageGeneration];
            }
            
        }];
    }
}

// 剪切和转码视频
- (void)cupAndTransVideo {
    NSArray *compPresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:self.urlAsset];
    if ([compPresets containsObject:AVAssetExportPresetLowQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:self.urlAsset presetName:AVAssetExportPresetLowQuality];
        
        NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        //如果将视频保存在“不存在的目录”下，会导出失败
        NSString *path = [documentDir stringByAppendingString:@"/top_1.mp4"];
        NSURL *pathUrl = [NSURL fileURLWithPath:path];
        exportSession.outputURL = pathUrl;
        exportSession.outputFileType = AVFileTypeQuickTimeMovie;
        CMTime start = CMTimeMakeWithSeconds(1.0, 600);
        CMTime duration = CMTimeMakeWithSeconds(3.0, 600);
        CMTimeRange range = CMTimeRangeMake(start, duration);
        //设置剪切范围
        exportSession.timeRange = range;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusCompleted:
                    NSLog(@"导出成功：%@",[exportSession outputURL]);
                    break;
                case AVAssetExportSessionStatusFailed:
                {
                    NSError *error = [exportSession error];
                    NSLog(@"导出失败：%@",error);
                }
                    break;
                case AVAssetExportSessionStatusCancelled:
                {
                    NSLog(@"取消导出");
                    [exportSession cancelExport];
                }
                    break;
                default:
                    break;
            }
        }];
    }
    
}

#pragma mark - tools
- (void)updateUIForDuration:(AVAsset *)asset {
    [self getImageFromVideo:asset];
}


#pragma mark - getter, setter

- (IBAction)samllVideoAction:(UIButton *)sender {
    SVShootViewController *shoot = [[SVShootViewController alloc] initWithNibName:@"SVShootViewController" bundle:nil];
    shoot.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:shoot animated:YES completion:nil];
}

- (AVAsset *)urlAsset {
    if (!_urlAsset) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"top" withExtension:@"mp4"];
        
        //AVURLAssetPreferPreciseDurationAndTimingKey: 精准时间控制，视频合成时传入
    //    NSDictionary *opt = @{AVURLAssetPreferPreciseDurationAndTimingKey: @(YES)};
        AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:url options:nil];
        NSLog(@"urlAsset:%@",urlAsset);
        _urlAsset = urlAsset;
    }
    return _urlAsset;;
}

@end
