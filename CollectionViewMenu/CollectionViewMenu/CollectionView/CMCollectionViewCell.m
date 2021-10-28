//
//  CMCollectionViewCell.m
//  CollectionViewMenu
//
//  Created by zhoufei on 2020/11/4.
//

#import "CMCollectionViewCell.h"
#import "CMLabel.h"

@implementation CMCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    [self.nameTextField becomeFirstResponder]
//    [UIMenuController sharedMenuController];
    
    CMLabel *label = [CMLabel new];
    label.userInteractionEnabled = YES;
    label.frame = CGRectMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5, 100, 50);
    label.text = @"hello world";
    label.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:label];
    
    self.imageV.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.imageV addGestureRecognizer:longPress];
    
}


- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    CGPoint location = [longPressGestureRecognizer locationInView:self];
    NSLog(@"cell中的长按手势%@",NSStringFromCGPoint(location));
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *hitView = [super hitTest:point withEvent:event];
//    
//    return hitView;
//}
//
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return [super pointInside:point withEvent:event];;
//}

@end
