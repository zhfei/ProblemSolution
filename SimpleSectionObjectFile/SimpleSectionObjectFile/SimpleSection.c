//
//  SimpleSection.c
//  SimpleSectionObjectFile
//
//  Created by 周飞 on 2020/6/30.
//  Copyright © 2020 zhf. All rights reserved.
//

/*
 Linux:
    gcc -c SimpleSection.c
 */

#include "SimpleSection.h"

int printf( const char *format, ...);

int global_init_var = 84;
int global_uninit_var;

void func1(int i) {
    printf("%d \n",i);
}

int main(void) {
    static int static_var = 85;
}
