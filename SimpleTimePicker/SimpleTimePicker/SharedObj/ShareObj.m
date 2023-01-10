//
//  ShareObj.m
//  SimpleTimePicker
//
//  Created by zhoufei on 2022/9/16.
//

#import "ShareObj.h"

@implementation ShareObj

+ (instancetype)sharedInstance{
    static ShareObj *shareObj;
    static dispatch_once_t onceKey;
    dispatch_once(&onceKey, ^{
        shareObj = [[super allocWithZone:nil] init];
    });
    return shareObj;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return self;
}

@end
