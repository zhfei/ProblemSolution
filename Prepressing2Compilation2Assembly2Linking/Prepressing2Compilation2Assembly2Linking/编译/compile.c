//
//  prepressing.c
//  Prepressing2Compilation2Assembly2Linking
//
//  Created by 周飞 on 2020/6/29.
//  Copyright © 2020 zhf. All rights reserved.
//
//  编译过程：从预编译后的 预编译文件compile.i -> 到编译后的 汇编文件compile.s

/*
 编译过程：
    gcc -S compile.i -o compile.s
 或者也可以通过.c文件直接编译成汇编文件
    gcc -S compile.c -o compile.s
 
 cc1编译器内部包含了预编译和编译过程，但是Mac OS没有找到这个工具。只发现了cc工具，但是使用cc工具将.c文件编译出来的是cpp文件
 */

#include <stdio.h>

#define kAdd(x,y) x+y

int main(int argc, const char *argv[]) {
    printf("这里是 编译 的验证过程\n");
    
    int result = kAdd(1, 2);
    printf("这是两个数的和：%d\n",result);
}
