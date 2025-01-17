//
//  ViewController.m
//  UIAlertShow
//
//  Created by zhoufei on 2021/6/3.
//

#import "AlertShowViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SceneDelegate.h"

@interface AlertShowViewController ()

@property (strong, nonatomic) UIWindow * currentActivityWindow;
@property (weak, nonatomic) IBOutlet UIView *flexContainer;

@end

@implementation AlertShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AVAsset *assert = [AVAsset assetWithURL:[NSURL URLWithString:@""]];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:assert];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
}


- (IBAction)showAlert:(UIButton *)sender {
        
    switch (sender.tag) {
        case 0:
        {
            [self alert];
        }
            break;
        case 1:
        {
            [self sheet];
        }
            break;
        case 2:
        {
            
            SceneDelegate *sceneDelegate = (SceneDelegate *)UIApplication.sharedApplication.connectedScenes.anyObject.delegate;
            [sceneDelegate.topWindow makeKeyAndVisible];
            sceneDelegate.window.hidden = YES;
            sceneDelegate.window.rootViewController = nil;
        }
            break;
        case 3:
        {
            [self sheet];
        }
            break;
            
        default:
            break;
    }
 

}

- (void)alert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"这是一些信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确认按钮");
    }];
    //2.2 取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    //2.2 取消按钮
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"销毁" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    //2.3 还可以添加文本框 通过 alert.textFields.firstObject 获得该文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请填写您的反馈信息";
    }];
    alert.message = @"请填写您的反馈信息\n请填写您的反馈信息";
    //3.将动作按钮 添加到控制器中
    [alert addAction:conform];
    [alert addAction:cancel];
    [alert addAction:destructive];
    //4.显示弹框
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sheet {
    //1.创建Controller
       UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"标题" message:@"一些信息" preferredStyle:UIAlertControllerStyleActionSheet];
       //2.添加按钮动作
       UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           NSLog(@"点击了项目1");
       }];
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"销毁" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
       UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           NSLog(@"点击了取消");
       }];
    UIAlertAction *cancel1 = [UIAlertAction actionWithTitle:@"默认取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
       //3.添加动作
       [alertSheet addAction:action1];
       [alertSheet addAction:destructive];
       [alertSheet addAction:cancel];
    [alertSheet addAction:cancel1];
       //4.显示sheet
       [self presentViewController:alertSheet animated:YES completion:nil];
 
}





- (UIWindowScene *)currentActivityScene {
    UIWindowScene *currentScene = nil;
    for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            // 只获取前台活动的窗口场景
            currentScene = scene;
            break; // 找到第一个活动窗口后停止循环
        }
    }
    return currentScene;
}

@end
