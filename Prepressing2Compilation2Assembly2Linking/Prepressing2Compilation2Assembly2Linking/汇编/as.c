//
//  as.c
//  Prepressing2Compilation2Assembly2Linking
//
//  Created by 周飞 on 2020/7/4.
//  Copyright © 2020 zhf. All rights reserved.
//
//  汇编过程: 是将.s汇编文件 翻译成 .o目标文件

/*
汇编过程：
    gcc编译器：通过gcc直接从.c源文件转化成.o目标文件
        gcc -c as.c -o as3.o
 
    as汇编器：通过as汇编器直接从.s汇编文件转化成.o目标文件
        as as.s -o as2.o
*/



#include <stdio.h>

#define kAdd(x,y) x+y

int main(int argc, const char *argv[]) {
    printf("这里是 汇编 的验证过程\n");
    
    int result = kAdd(1, 2);
    printf("这是两个数的和：%d\n",result);
}
