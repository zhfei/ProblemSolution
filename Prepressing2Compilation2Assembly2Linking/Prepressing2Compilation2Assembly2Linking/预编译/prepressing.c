//
//  prepressing.c
//  Prepressing2Compilation2Assembly2Linking
//
//  Created by 周飞 on 2020/6/29.
//  Copyright © 2020 zhf. All rights reserved.
//
//  预编译

/*
 gcc编译器：
     gcc -E prepressing.c -o prepressing.i
 cpp编译器：
     cpp prepressing.c > prepressing.i
 */

#include <stdio.h>

#define kAdd(x,y) x+y

int main(int argc, const char *argv[]) {
    printf("这里是 预编译 的验证过程\n");
    
    int result = kAdd(1, 2);
    printf("这是两个数的和：%d\n",result);
}
