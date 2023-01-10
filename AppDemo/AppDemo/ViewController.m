//
//  ViewController.m
//  AppDemo
//
//  Created by zhoufei on 2022/11/1.
//

#import "ViewController.h"
#import "VersionHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSInteger result1 = [VersionHelper compareVersion1:@"1.1.2" version2:@"1.001"];
    NSLog(@"期望结果1，实际结果：%ld",result1);
    NSInteger result11 = [VersionHelper compareVersion1:@"1.1.2" version2:@"1.001.1"];
    NSLog(@"期望结果1，实际结果：%ld",result11);
    NSInteger result111 = [VersionHelper compareVersion1:@"1.1.2" version2:@"1.001.1.0"];
    NSLog(@"期望结果1，实际结果：%ld",result111);
    
    
    NSInteger result2 = [VersionHelper compareVersion1:@"1.1" version2:@"1.001"];
    NSLog(@"期望结果0，实际结果：%ld",result2);
    NSInteger result3 = [VersionHelper compareVersion1:@"1.1.2" version2:@"1.001.02"];
    NSLog(@"期望结果0，实际结果：%ld",result3);
    NSInteger result22 = [VersionHelper compareVersion1:@"1.1" version2:@"1.001.0"];
    NSLog(@"期望结果0，实际结果：%ld",result22);
    
    
    NSInteger result4 = [VersionHelper compareVersion1:@"1.1.2" version2:@"1.001.02.1"];
    NSLog(@"期望结果-1，实际结果：%ld",result4);
    NSInteger result44 = [VersionHelper compareVersion1:@"1.1.2" version2:@"1.002.02"];
    NSLog(@"期望结果-1，实际结果：%ld",result44);
    NSInteger result444 = [VersionHelper compareVersion1:@"1.1.2" version2:@"1.002.02.0"];
    NSLog(@"期望结果-1，实际结果：%ld",result444);
    
    NSInteger result5 = [VersionHelper compareVersion1:@"1.a.2" version2:@"1.001.02.1"];
    NSLog(@"期望结果-2，实际结果：%ld",result5);
    NSInteger result55 = [VersionHelper compareVersion1:@"1.1.2" version2:@"1.00a.02"];
    NSLog(@"期望结果-2，实际结果：%ld",result55);
    NSInteger result555 = [VersionHelper compareVersion1:@"1.1.2" version2:@"1.00a.02.0"];
    NSLog(@"期望结果-2，实际结果：%ld",result555);
}



@end
