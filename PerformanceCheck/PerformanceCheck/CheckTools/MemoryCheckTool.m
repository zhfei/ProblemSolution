//
//  MemoryCheckTool.m
//  PerformanceCheck
//
//  Created by zhoufei on 2023/1/10.
//

#import "MemoryCheckTool.h"
#import <mach/mach.h>

@interface MemoryCheckTool() 
@property (nonatomic, strong) NSTimer *activationDelayTimer;
@property (nonatomic, assign) NSInteger activationDelay;

@end

@implementation MemoryCheckTool
+ (instancetype)sharedInstance {
    static MemoryCheckTool *shareObj;
    static dispatch_once_t onceKey;
    dispatch_once(&onceKey, ^{
        shareObj = [[super allocWithZone:nil] init];
        shareObj.activationDelay = 1;
        [shareObj startActivationDelayTimer];
    });
    return shareObj;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return self;
}


- (void)dealloc {
    [_activationDelayTimer invalidate];
}

- (void)startActivationDelayTimer {
    [self.activationDelayTimer invalidate];
    self.activationDelayTimer = [NSTimer
                                 timerWithTimeInterval:self.activationDelay target:self selector:@selector(activationDelayTimerFired) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.activationDelayTimer forMode:NSRunLoopCommonModes];
}

- (void)activationDelayTimerFired {
    NSLog(@"内存使用率：%lu",(unsigned long)[self useMemoryForApp]);
}


//当前app消耗的内存
- (NSUInteger)useMemoryForApp{
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS)
    {
        int64_t memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
        return memoryUsageInByte/1024/1024;
    }
    else
    {
        return -1;
    }
}
 
//设备总的内存
- (NSUInteger)totalMemoryForDevice{
    return [NSProcessInfo processInfo].physicalMemory/1024/1024;
}



@end
