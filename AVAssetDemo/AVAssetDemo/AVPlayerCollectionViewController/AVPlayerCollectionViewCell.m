//
//  AVPlayerCollectionViewCell.m
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/19.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "AVPlayerCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "AVPlayerManager.h"

@interface AVPlayerCollectionViewCell()
@property (strong, nonatomic) UIView *container;
@property (strong, nonatomic) NSString *urlStr;
@property (strong, nonatomic) AVPlayerManager *playerManager;
@property (strong, nonatomic) UIImageView *thumbilImageView;

@property (strong, nonatomic) UILabel *dateLabel;

@end

@implementation AVPlayerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
}


- (void)configUrlString:(NSString *)urlStr {
    self.urlStr = urlStr;
    
    [self.playerManager configUrlString:urlStr];
    self.thumbilImageView.image = self.playerManager.thumbi;
    self.dateLabel.text = self.playerManager.durationsStr;
    
    
    if (!self.thumbilImageView.superview) {
        [self.contentView addSubview:self.thumbilImageView];
        [self.thumbilImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    
    if (!self.dateLabel.superview) {
        [self.contentView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
}

- (void)clearCache {
    [self.playerManager clearCache];
}

- (void)canclePlayCache {
    [self.playerManager canclePlayCache];
}

- (void)safePause {
    [self.playerManager safePause];
}

- (void)safePlay {
    [self.playerManager safePlay];
}

- (UIView *)getPlayerContainer {
    if (!self.playerManager.playerLayer.superlayer) {
        [self.container.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.container.layer addSublayer:self.playerManager.playerLayer];
    }
    self.container.frame = self.bounds;
    self.playerManager.playerLayer.frame = self.bounds;
    
    return self.container;
}


#pragma mark - getter, setter

- (UIImageView *)thumbilImageView {
    if (!_thumbilImageView) {
        _thumbilImageView = [UIImageView new];
        _thumbilImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _thumbilImageView;
}

- (UIView *)container {
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
    return _container;
}


- (AVPlayerManager *)playerManager {
    if (!_playerManager) {
        __weak typeof(self)weakSelf=self;
        _playerManager = [[AVPlayerManager alloc] initWithPlayItemInfoBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(playerCollectionViewCellSetDataComplete:)]) {
                [weakSelf.delegate playerCollectionViewCellSetDataComplete:weakSelf];
            }
        }];
    }
    return _playerManager;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.font = [UIFont systemFontOfSize:14];
    }
    return _dateLabel;
}

@end
