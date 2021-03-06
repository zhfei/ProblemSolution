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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setButtonMiddle:self.midBtn];
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
    
    

}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"%@",notification);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"%@",response);
}


- (void)setButtonMiddle:(UIButton *)btn {
    CGFloat space = 10;
    // 1. ??????imageView???titleLabel????????????
    CGFloat imageWith = btn.imageView.frame.size.width;
    CGFloat imageHeight = btn.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // ??????iOS8???titleLabel???size???0???????????????????????????
        labelWidth = btn.titleLabel.intrinsicContentSize.width;
        labelHeight = btn.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = btn.titleLabel.frame.size.width;
        labelHeight = btn.titleLabel.frame.size.height;
    }
    
    // 2. ???????????????imageEdgeInsets???labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. ??????style???space??????imageEdgeInsets???labelEdgeInsets??????
    imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2, 0, 0, -labelWidth);
    labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2, 0);
            
//    imageEdgeInsets = UIEdgeInsetsMake(0, 0, labelHeight+space,0);
//    labelEdgeInsets = UIEdgeInsetsMake(labelHeight+space, -imageWith, 0, 0);
    
    // 4. ??????
    btn.titleEdgeInsets = labelEdgeInsets;
    btn.imageEdgeInsets = imageEdgeInsets;
}

@end
