//
//  SVVideoEditViewController.m
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/25.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "SVVideoEditViewController.h"

@interface SVVideoEditViewController ()

@end

@implementation SVVideoEditViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    [self setupData];
}

#pragma mark - Private Method

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)setupData {
    
}

///!!!: 重新录制
- (void)reVideoRecored {
    
}

// MARK: overwrite

#pragma mark - Public Method

#pragma mark - Event

- (IBAction)sendAction:(UIButton *)sender {
    
}

- (IBAction)cupAction:(UIButton *)sender {
    
}

- (IBAction)goBackAction:(UIButton *)sender {
    //停止播放
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(resetRecordVideo:)]) {
            [self.delegate resetRecordVideo:self];
        }
    }];
}

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end
