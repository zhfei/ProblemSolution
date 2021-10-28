//
//  AppDelegate.h
//  CoreData
//
//  Created by zhoufei on 2020/8/23.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

