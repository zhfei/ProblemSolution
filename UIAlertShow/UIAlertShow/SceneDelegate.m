//
//  SceneDelegate.m
//  UIAlertShow
//
//  Created by zhoufei on 2021/6/3.
//

#import "SceneDelegate.h"
#import "Window1ViewController.h"
#import "Window2ViewController.h"
#import "AlertShowViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    [self alertWindow];
    [self topWindow];
    
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AlertShowViewController *myVC = [storyboard instantiateViewControllerWithIdentifier:@"AlertShowViewController"];
    
    self.window.rootViewController = myVC;
    [self.window makeKeyAndVisible];
    

}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


- (UIWindow *)alertWindow {
    if (!_alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithWindowScene:self.window.windowScene];
        _alertWindow.frame = [UIScreen mainScreen].bounds;
        _alertWindow.windowLevel = UIWindowLevelAlert+1;
        _alertWindow.autoresizingMask = UIViewAutoresizingNone;
        _alertWindow.backgroundColor = [UIColor clearColor];

//        UIView *bgView = [[UIView alloc] initWithFrame:_alertWindow.bounds];
//        [_alertWindow addSubview:bgView];
//        bgView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f];
//        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverTap:)]];
        
        Window1ViewController *w1v = [[Window1ViewController alloc] initWithNibName:@"Window1ViewController" bundle:nil];
        _alertWindow.rootViewController = w1v;
        [_alertWindow makeKeyAndVisible];
        _alertWindow.hidden = YES;
    }
    return _alertWindow;
}

- (UIWindow *)topWindow {
    if (!_topWindow) {
        _topWindow = [[UIWindow alloc] initWithWindowScene:self.window.windowScene];
        _topWindow.frame = [UIScreen mainScreen].bounds;
        _topWindow.windowLevel = UIWindowLevelAlert+2;
        _topWindow.autoresizingMask = UIViewAutoresizingNone;
        _topWindow.backgroundColor = [UIColor clearColor];

//        UIView *bgView = [[UIView alloc] initWithFrame:_topWindow.bounds];
//        [_topWindow addSubview:bgView];
//        bgView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f];
//        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverTap:)]];
        
        Window2ViewController *w2v = [[Window2ViewController alloc] initWithNibName:@"Window2ViewController" bundle:nil];
        _topWindow.rootViewController = w2v;
        [_topWindow makeKeyAndVisible];
        _topWindow.hidden = YES;
    }
    return _topWindow;
}

- (UIWindow *)currentActivityWindow {
    UIWindow *currentWindow = nil;
    for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            // 只获取前台活动的窗口场景
            currentWindow = scene.windows.firstObject;
            break; // 找到第一个活动窗口后停止循环
        }
    }
    return currentWindow;
}

@end
