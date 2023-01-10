//
//  ViewController.m
//  HotReload
//
//  Created by zhoufei on 2022/4/29.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"我是热重载";
}

- (void)injected {
    self.titleLabel.text = @"我是热重载2r  s";
}


@end
