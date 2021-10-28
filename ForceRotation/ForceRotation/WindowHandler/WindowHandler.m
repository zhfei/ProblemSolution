//
//  WindowHandler.m
//  ForceRotation
//
//  Created by 周飞 on 2020/8/12.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "WindowHandler.h"
#import "WindowViewController.h"

@interface WindowHandler()
@property (strong, nonatomic) NSMutableArray *windowsArray;

@end

@implementation WindowHandler
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.windowsArray = @[].mutableCopy;
    }
    return self;
}

- (void)showToast:(NSString *)title {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.windowLevel = UIWindowLevelAlert + 1 + self.windowsArray.count;
    window.backgroundColor = [UIColor blackColor];
    window.alpha = 0.2 + self.windowsArray.count * 0.1;
    
    WindowViewController *rootVC = [[WindowViewController alloc] initWithNibName:@"WindowViewController" bundle:nil];
    rootVC.content.text = title;
    window.rootViewController = rootVC;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestures:)];
    [window addGestureRecognizer:tap];
    
    //makeKey:接收键盘输入和非触摸事件
    //Visible: hide = NO
    [window makeKeyAndVisible];
    
    [self.windowsArray addObject:window];
}

- (void)handleTapGestures:(UITapGestureRecognizer *)gestureRecognizer {
    NSLog(@"收到点击事件：%@",gestureRecognizer);
    
    [[UIApplication sharedApplication].windows[0] makeKeyAndVisible];
}


@end
