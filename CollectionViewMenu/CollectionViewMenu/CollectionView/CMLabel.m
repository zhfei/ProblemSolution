//
//  CMLabel.m
//  CollectionViewMenu
//
//  Created by zhoufei on 2020/11/4.
//

#import "CMLabel.h"

@implementation CMLabel
- (void)awakeFromNib {
    [super awakeFromNib];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.numberOfTapsRequired = 1;
    [self addGestureRecognizer:longPress];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}


- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    CGPoint location = [longPressGestureRecognizer locationInView:self];
    NSLog(@"%@",NSStringFromCGPoint(location));
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL inside = [super pointInside:point withEvent:event];
    return inside;
}

@end
