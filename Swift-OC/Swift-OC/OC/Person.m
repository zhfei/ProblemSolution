//
//  Person.m
//  Swift-OC
//
//  Created by zhoufei on 2023/3/30.
//

#import "Person.h"

int sum(int a, int b) {
    return a+b;
}

@implementation Person
- (void)say {
    NSLog(@"Hello,%@-%ld",self.name,self.age);
}

- (void)play {
    NSLog(@"Play,%@-%ld",self.myCar.bigName,self.myCar.speed);
    
//    self.myCar.run();
}



@end
