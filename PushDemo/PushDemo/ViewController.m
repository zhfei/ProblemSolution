//
//  ViewController.m
//  PushDemo
//
//  Created by zhoufei on 2021/10/8.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController () <UNUserNotificationCenterDelegate>
@property (weak, nonatomic) IBOutlet UIButton *midBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self setButtonMiddle:self.midBtn];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleLongPressGesture:)];
    longPress.allowableMovement = 40;
    [self.imageView addGestureRecognizer:longPress];
}


- (IBAction)localPushAction:(UIButton *)sender {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        UNMutableNotificationContent *content = [UNMutableNotificationContent new];
        content.title = [NSString localizedUserNotificationStringForKey:@"Hello,Key" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:@"Hello,body" arguments:nil];
        content.sound = [UNNotificationSound defaultSound];
        content.badge = [NSNumber numberWithInt:1];

    //    NSDateComponents *dateCom = [NSDateComponents new];
    //    dateCom.hour = 23;
    //    dateCom.minute = 20;
    //    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateCom repeats:NO];
    //    UNNotificationRequest *notReq = [UNNotificationRequest requestWithIdentifier:@"request1" content:content trigger:trigger];
    //    [center addNotificationRequest:notReq withCompletionHandler:^(NSError * _Nullable error) {
    //
    //    }];

        UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:YES];
        UNNotificationRequest *notReq2 = [UNNotificationRequest requestWithIdentifier:@"request2" content:content trigger:timeTrigger];
        [center addNotificationRequest:notReq2 withCompletionHandler:^(NSError * _Nullable error) {

        }];
        
    }];
    
    

    UIImage *image = [[UIImage imageNamed:@"icon_1_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView.tintColor = [UIColor redColor];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.image = image;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"%@",notification);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"%@",response);
}


- (void)setButtonMiddle:(UIButton *)btn {
    CGFloat space = 10;
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = btn.imageView.frame.size.width;
    CGFloat imageHeight = btn.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = btn.titleLabel.intrinsicContentSize.width;
        labelHeight = btn.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = btn.titleLabel.frame.size.width;
        labelHeight = btn.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2, 0, 0, -labelWidth);
    labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2, 0);
            
//    imageEdgeInsets = UIEdgeInsetsMake(0, 0, labelHeight+space,0);
//    labelEdgeInsets = UIEdgeInsetsMake(labelHeight+space, -imageWith, 0, 0);
    
    // 4. 赋值
    btn.titleEdgeInsets = labelEdgeInsets;
    btn.imageEdgeInsets = imageEdgeInsets;
}

- (void)jsq_handleLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Ended ---   Ended",longPress);
    } else if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Began ---   Began",longPress);
    } else {
        NSLog(@"longPress:%@",longPress);
    }
    CGPoint touchPt = [longPress locationInView:self.view];
    
}

@end
