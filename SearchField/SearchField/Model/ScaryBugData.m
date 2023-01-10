//
//  ScaryBugData.m
//  SearchField
//
//  Created by zhoufei on 2022/1/4.
//

#import "ScaryBugData.h"

@implementation ScaryBugData
- (instancetype)initWithTitle:(NSString *)title rating:(CGFloat)rating {
    if (self = [super init]) {
        self.title = title;
        self.rating = rating;
    }
    return self;
}
@end
