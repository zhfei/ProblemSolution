//
//  main.m
//  MemoryManage
//
//  Created by zhoufei on 2022/4/19.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Person : NSObject{
    @public
    int age;
}
@end
@implementation Person
@end

@interface Student : Person{
    @public
    int sex;
}
@end
@implementation Student
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Student *obj = [[Student alloc] init];
        obj->age = 10;
        obj->sex = 3;
        
        NSLog(@"InstanceSize:%zu",class_getInstanceSize([NSObject class]));
    }
    return 0;
}
