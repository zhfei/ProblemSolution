//
//  MenuiOS13Button.m
//  CollectionViewMenu
//
//  Created by zhoufei on 2020/11/7.
//

#import "MenuiOS13Button.h"

@implementation MenuiOS13Button

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

@end
