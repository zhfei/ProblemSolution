//
//  VersionHelper.h
//  AppDemo
//
//  Created by zhoufei on 2022/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionHelper : NSObject
/// 版本号对比
/// @param v1 版本号1
/// @param v2 版本号2
+ (NSInteger)compareVersion1:(NSString *)v1 version2:(NSString *)v2;

@end

NS_ASSUME_NONNULL_END
