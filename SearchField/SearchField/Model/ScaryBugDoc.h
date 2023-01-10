//
//  ScaryBugDoc.h
//  SearchField
//
//  Created by zhoufei on 2022/1/4.
//

#import <Foundation/Foundation.h>
#import "ScaryBugData.h"
NS_ASSUME_NONNULL_BEGIN

@interface ScaryBugDoc : NSObject
@property (nonatomic, strong) ScaryBugData *data;
@property (nonatomic, strong) NSImage *thumbImage;
@property (nonatomic, strong) NSImage *fullImage;

- (instancetype)initWithTitle:(NSString *)title rating:(CGFloat)rating thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage;
@end

NS_ASSUME_NONNULL_END
