//
//  main.c
//  Prepressing2Compilation2Assembly2Linking
//
//  Created by 周飞 on 2020/6/29.
//  Copyright © 2020 zhf. All rights reserved.
//
//  预编译，编译，汇编，链接

/*
 预编译指令：
     gcc编译器：
         gcc -E prepressing.c -o prepressing.i
     cpp编译器：
         cpp prepressing.c > prepressing.i
 
 编译指令：
    编译过程：
        gcc -S compile.i -o compile.s
     或者也可以通过.c文件直接编译成汇编文件
        gcc -S compile.c -o compile.s
 
 */



#include <stdio.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    return 0;
}
