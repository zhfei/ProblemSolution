//
//  CDUser.h
//  CoreData
//
//  Created by zhoufei on 2020/9/9.
//  Copyright © 2020 zhf. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDUser : NSManagedObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *frome;
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSNumber *sex;
@property (strong, nonatomic) NSNumber *height;



@end

NS_ASSUME_NONNULL_END
