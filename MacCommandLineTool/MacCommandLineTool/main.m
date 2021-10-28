//
//  main.m
//  MacCommandLineTool
//
//  Created by zhoufei on 2021/8/13.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"你好，世界");
        
        //1.打印命令行工具传参
        printf("\n");
        for (int i = 0; i < argc; i++) {
            const char * argV = argv[i];
            printf("argV: %d - %s\n",i, argV);
        }
        printf("\n");
        
        //2.打印命令行工具传参
        NSProcessInfo *info = [NSProcessInfo processInfo];
        NSLog(@"info:%@",info.arguments);
    }
    return 0;
}
