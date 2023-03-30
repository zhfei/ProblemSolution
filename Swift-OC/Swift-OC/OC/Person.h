//
//  Person.h
//  Swift-OC
//
//  Created by zhoufei on 2023/3/30.
//

#import <Foundation/Foundation.h>
#import "Swift_OC-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) Car *myCar;


- (void)say;
- (void)play;
@end

NS_ASSUME_NONNULL_END
