//
//  SVProgress.m
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/30.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "SVProgress.h"

int8_t kCircleRadius = 50;
int8_t kAnimationDuration = 30;

@interface SVProgress()
@property (strong, nonatomic) NSTimer *activationTimer;
@property (assign, nonatomic) NSInteger counter;
@end

@implementation SVProgress
#pragma mark - Life Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    
    [self addGestureRecognizer:longPress];
}

- (instancetype)initWithFrame:(CGRect)frame {
    CGRect defaultFrame = (CGRect){frame.origin, CGSizeMake(2*kCircleRadius, 2*kCircleRadius)};
    if (self = [super initWithFrame:defaultFrame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (void)dealloc {
    [_activationTimer invalidate];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    return [super pointInside:point withEvent:event];
}

#pragma mark - Private Method

- (void)startActivationTimer {
    [self.activationTimer invalidate];
    self.counter = 0;
    self.activationTimer = [NSTimer
                                 timerWithTimeInterval:1 target:self selector:@selector(activationTimerFired) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.activationTimer forMode:NSRunLoopCommonModes];
}

- (void)activationTimerFired {
    self.counter++;
    if (self.counter >= kAnimationDuration) {
        [self.activationTimer invalidate];
    } else {
        [self startCircleAnimation];
    }
}

- (void)startCircleAnimation {
    CAShapeLayer *circleLayer = [[CAShapeLayer alloc] init];
    
    circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kCircleRadius*2, kCircleRadius*2) cornerRadius:kCircleRadius].CGPath;
    circleLayer.position = CGPointMake(kCircleRadius, kCircleRadius);
    circleLayer.bounds = CGRectMake(0, 0, kCircleRadius*2, kCircleRadius*2);
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    circleLayer.lineWidth = 5;
    [self.layer addSublayer:circleLayer];
    
//    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    drawAnimation.duration = kAnimationDuration;
//    drawAnimation.repeatCount = 1;
//    drawAnimation.fromValue = [NSNumber numberWithInt:0];
//    drawAnimation.toValue = [NSNumber numberWithFloat:self.counter/kAnimationDuration];
//    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    [circleLayer addAnimation:drawAnimation forKey:@"draw"];
}


#pragma mark - Public Method

#pragma mark - Event
- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    switch (longPressGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self startActivationTimer];
            if ([self.svDelegate respondsToSelector:@selector(beganLongPress:)]) {
                [self.svDelegate beganLongPress:self];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.activationTimer invalidate];
            if ([self.svDelegate respondsToSelector:@selector(endedLongPress:)]) {
                [self.svDelegate endedLongPress:self];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getter, Setter

@end
