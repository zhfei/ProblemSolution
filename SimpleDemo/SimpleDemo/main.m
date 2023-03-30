//
//  main.m
//  SimpleDemo
//
//  Created by zhoufei on 2023/3/22.
//

#import <Foundation/Foundation.h>

int sum(int a, int b) {
    return a + b;
}

int main(int argc, const char * argv[]) {
    int c = sum(10, 20);
    id obj = [NSObject alloc];
    id obj1 = [obj init];
    id obj2 = [obj init];
    NSLog(@"%p - %p - %p",obj,obj1,obj2);
    NSLog(@"%d - %p",c,obj);
    return 0;
}



