//
//  ScaryBugDoc.m
//  SearchField
//
//  Created by zhoufei on 2022/1/4.
//

#import "ScaryBugDoc.h"

@implementation ScaryBugDoc
- (instancetype)initWithTitle:(NSString *)title rating:(CGFloat)rating thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage {
    if (self = [super init]) {
        self.data = [[ScaryBugData alloc] initWithTitle:title rating:rating];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}
@end
