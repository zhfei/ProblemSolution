//
//  p93weakref.c
//  Programmer's_self-cultivation
//
//  Created by 周飞 on 2020/8/5.
//  Copyright © 2020 zhf. All rights reserved.
//
//  gcc编译器的编译声明：https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes


#include "p93weakref.h"

//__attribute__((weak)): 将符号在编译器中声明成弱符号
//__attribute__((weakref)): 将符号引用在编译器中声明成弱符号引用

//书中的方法：此方法编译报错
//__attribute__((weakref)) void foo();


//其他方法：
//1.报错
//int x1() __attribute__((weakref));
//int x1() __attribute__((weakref("mock")));
//int x1() __attribute__((alias("mock")));


//2.成功调用
//条件：1.必须带static,2.必须带备胎函数"mock"
static int x2() __attribute__((weakref("mock")));

//3.报错
//苹果操作系统darwin，不支持alias声明弱引用
//static int x3() __attribute__((alias("mock")));
//static int x3() __attribute__((weakref));



void mock() {
    printf("mock...\n");
}

int main(int argc, const char * argv[]) {
//    x1();
    x2();
//    x3();
}
