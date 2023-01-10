//
//  ViewController.m
//  PerformanceCheck
//
//  Created by zhoufei on 2023/1/10.
//

#import "ViewController.h"
#import "CPUCheckTool.h"
#import "MemoryCheckTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [CPUCheckTool sharedInstance];
    [MemoryCheckTool sharedInstance];
}

@end
