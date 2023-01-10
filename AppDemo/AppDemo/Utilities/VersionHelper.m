//
//  VersionHelper.m
//  AppDemo
//
//  Created by zhoufei on 2022/11/1.
//

#import "VersionHelper.h"

@implementation VersionHelper
/// 版本号对比
/// @param v1 版本号1
/// @param v2 版本号2
+ (NSInteger)compareVersion1:(NSString *)v1 version2:(NSString *)v2 {
    //异常处理
    if (![self checkVersionStr:v1] || ![self checkVersionStr:v2]) {
        return -2;
    }
    
    //逻辑处理
    
    NSArray *v1Array = [v1 componentsSeparatedByString:@"."];
    NSArray *v2Array = [v2 componentsSeparatedByString:@"."];
    NSInteger minCount = MIN(v1Array.count, v2Array.count);
    
    //从左->右，相同下标位置数据逐个比较
    for (NSInteger i = 0; i < minCount; i++) {
        NSInteger v1NumValue = [v1Array[i] integerValue];
        NSInteger v2NumValue = [v2Array[i] integerValue];
        
        if (v1NumValue > v2NumValue) {
            return 1;
        } else if (v1NumValue < v2NumValue) {
            return -1;
        } 
    }
    
    ////从左->右，超出相同下标位置数时，多余部分判断
    NSArray *otherArray = nil;
    if (v1Array.count > minCount) {
        otherArray = v1Array;
    } else if (v2Array.count > minCount) {
        otherArray = v2Array;
    }
    
    if (otherArray) {
        for (NSInteger j = minCount; j < otherArray.count; j++) {
            NSInteger otherNumValue = [otherArray[j] integerValue];
            if (otherNumValue > 0) {
                return otherArray == v1Array ? 1 : -1;
            }
        }
    }
    
    return 0;
}


#pragma mark - other
+ (BOOL)checkVersionStr:(NSString *)str {
//    if (!str || str.length <= 0 || ![str isKindOfClass:[NSString class]] || [self textRegex:str]) {
//        return NO;
//    }
    if (!str || str.length <= 0 || ![str isKindOfClass:[NSString class]]) {
        return NO;
    }

    return YES;
}

/// 字符串是否只包含数字和.
/// @param targetStr 目标字符串
+ (BOOL)textRegex:(NSString *)targetStr {
    NSString *check = @"^[0-9]([0-9]|\\.)[0-9]*$";
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"self matches %@",check];
    BOOL result = [predice evaluateWithObject:targetStr];
    return !result;
}

@end
