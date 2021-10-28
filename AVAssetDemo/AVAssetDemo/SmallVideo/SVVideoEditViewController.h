//
//  SVVideoEditViewController.h
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/25.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SVVideoEditViewController;


NS_ASSUME_NONNULL_BEGIN
@protocol SVVideoEditViewControllerDelegate <NSObject>
- (void)resetRecordVideo:(SVVideoEditViewController *)videoEditVC;

@end



@interface SVVideoEditViewController : UIViewController
@property (weak, nonatomic) id<SVVideoEditViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
