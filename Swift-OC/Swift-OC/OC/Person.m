//
//  Person.m
//  Swift-OC
//
//  Created by zhoufei on 2023/3/30.
//

#import "Person.h"

@implementation Person
- (void)say {
    NSLog(@"Hello,%@-%ld",self.name,self.age);
}

- (void)play {
    NSLog(@"Play,%@-%ld",self.myCar.name,self.myCar.speed);
    
    self.myCar.run();
}
@end
