//
//  ViewController.m
//  PerformanceCheck
//
//  Created by zhoufei on 2023/1/10.
//

#import "ViewController.h"
#import "CPUCheckTool.h"
#import "MemoryCheckTool.h"

// iOS图像渲染技术栈
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (nonatomic, strong)UIView *contentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.contentView];

    //移动：position
    //移动：transform.translation.y
    //旋转：transform.rotation.z
    //缩放：transform.scale
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    base.fromValue = [NSNumber numberWithInteger:60];
    base.toValue = [NSNumber numberWithInteger:200];
    base.repeatCount = NSIntegerMax;
    base.autoreverses = YES;//依动画的方式返回原位置
    base.duration = 1;
    base.removedOnCompletion = NO;
    [self.contentView.layer addAnimation:base forKey:@"move"];
}

- (UIView *)contentView {
    
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.backgroundColor = [UIColor blueColor];
        _contentView.userInteractionEnabled = YES;
        _contentView.alpha = 1;
    }
    return _contentView;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [CPUCheckTool sharedInstance];
    [MemoryCheckTool sharedInstance];
}

@end
