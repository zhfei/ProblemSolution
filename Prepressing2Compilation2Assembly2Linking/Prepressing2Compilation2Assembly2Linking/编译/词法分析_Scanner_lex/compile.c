//
//  prepressing.c
//  Prepressing2Compilation2Assembly2Linking
//
//  Created by 周飞 on 2020/6/29.
//  Copyright © 2020 zhf. All rights reserved.
//
//  词法分析器，词法扫描的过程：将源文件输入到词法扫描器lex，将源代码字符 输出为一系列的关键词Token,并将字符Token添加到字符表，常量，字面量添加到文字表
//                         以备后面的链接使用。

/*
 词法扫描过程：
    lex
 */

#include <stdio.h>


int main(int argc, const char *argv[]) {
    char *array;
    int index = 2;
    array[index] = (index + 4) * (2 + 6);
    return 0;
    
}
