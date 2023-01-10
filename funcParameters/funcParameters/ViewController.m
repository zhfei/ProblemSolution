//
//  ViewController.m
//  funcParameters
//
//  Created by zhoufei on 2022/2/14.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test:@"hello,test", @"hello,testhello,testhello,testhello,test", @"hello,testhello,testhello,testhello,test", @"hello,testhello,testhello,testhello,test", @"hello,testhello,testhello,testhello,test", @"hello,testhello,testhello,testhello,test", @"hello,testhello,testhello,testhello,test", @"hello,testhello,testhello,testhello,test", @"hello,testhello,testhello,testhello,test", @"hello,testhello,testhello,testhello,test"];
}

- (void)test:(NSString *)fomater,... {
    for (int i = 0; i < 100; i++) {
        for (int j = 0; j < 100; j++) {
            va_list args;
            va_start(args, fomater);
            printf("%p",args);
            va_end(args);
        }
    }
}


@end
