//
//  MenuiOS13Label.m
//  CollectionViewMenu
//
//  Created by zhoufei on 2020/11/7.
//

#import "MenuiOS13Label.h"

@implementation MenuiOS13Label
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)]];
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    //只有成为第一响应者，才能将UIMenuController 显示在上面
    [self becomeFirstResponder];
    
    //设置显示的位置，坐标系的参照物
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

#pragma mark - override
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(cut:) ||
        action == @selector(copy:) ||
        action == @selector(paste:)) {
        return YES;
    }
    return NO;
}

- (void)cut:(id)sender {
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
    self.text = nil;
}

@end
