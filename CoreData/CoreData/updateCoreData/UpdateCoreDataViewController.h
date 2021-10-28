//
//  UpdateCoreDataViewController.h
//  CoreData
//
//  Created by zhoufei on 2020/8/23.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateCoreDataViewController : UIViewController

@property (strong, nonatomic) NSManagedObject *coreModel;

@end

NS_ASSUME_NONNULL_END
