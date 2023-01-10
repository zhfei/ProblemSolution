//
//  ScaryBugData.h
//  SearchField
//
//  Created by zhoufei on 2022/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScaryBugData : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat rating;

- (instancetype)initWithTitle:(NSString *)title rating:(CGFloat)rating;
@end

NS_ASSUME_NONNULL_END
