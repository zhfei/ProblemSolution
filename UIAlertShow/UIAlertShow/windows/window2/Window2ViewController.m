//
//  Window2ViewController.m
//  UIAlertShow
//
//  Created by zhoufei on 2024/12/20.
//

#import "Window2ViewController.h"
#import "SceneDelegate.h"

@interface Window2ViewController ()

@end

@implementation Window2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)switchWindow:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)UIApplication.sharedApplication.connectedScenes.anyObject.delegate;
    [sceneDelegate.window makeKeyAndVisible];
    sceneDelegate.topWindow.hidden = YES;
    sceneDelegate.topWindow.rootViewController = nil;
}

@end
