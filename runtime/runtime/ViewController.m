//
//  ViewController.m
//  runtime
//
//  Created by zhoufei on 2022/4/3.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <TestFramework/StaticLibManager.h>

@interface Person: NSObject

@end

@implementation Person
- (void)foo {
    NSLog(@"Doing foo");//Person的foo函数
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //执行foo函数
    [self performSelector:@selector(foo)];
    
    [StaticLibManager testClass];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;//返回YES，进入下一步转发
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(foo)) {
        Person *p = [Person new];
        return p;
    }
    return [super forwardingTargetForSelector:aSelector];//返回nil，进入下一步转发
}


@end
