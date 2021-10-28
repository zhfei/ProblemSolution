//
//  main.m
//  Libffi
//
//  Created by zhoufei on 2021/8/11.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include "libffi/ffi.h"
#import <dlfcn.h>

int testFunc(int m, int n) {
    return m + n;
}

int main(int argc, char * argv[]) {
    //dlopen 打开一个动态库，并返回句柄
    //dlsym 从打开的库中查找符号值
    //dlclose 关闭句柄
    //dlerror 返回最后一次调用的错误
    
    void *funcPtr = dlsym(RTLD_DEFAULT, "testFunc");
    
    //创建参数类型
    int argCount = 2;
    ffi_type **ffiArgTypes = alloca(sizeof(ffi_type *) *argCount);
    ffiArgTypes[0] = &ffi_type_sint;
    ffiArgTypes[1] = &ffi_type_sint;
    //创建参数值
    void **ffiArgs = alloca(sizeof(void *) *argCount);
    void *ffiArgPtr = alloca(ffiArgTypes[0]->size);
    int *argPtr = ffiArgPtr;
    *argPtr = 1;
    ffiArgs[0] = argPtr;
    
    void *ffiArgPtr2 = alloca(ffiArgTypes[1]->size);
    int *argPtr2 = ffiArgPtr2;
    *argPtr = 2;
    ffiArgs[1] = argPtr2;
    
    //生成函数模板
    ffi_cif cif;
    ffi_type *returnFfiType = &ffi_type_sint;
    ffi_status ffiPreStatus = ffi_prep_cif_var(&cif, FFI_DEFAULT_ABI, (unsigned int)0, (unsigned int)argCount, returnFfiType, ffiArgTypes);
    if (ffiPreStatus == FFI_OK) {
        //创建保存返回值的指针
        void *returnPtr = NULL;
        if (returnFfiType->size) {
            returnPtr = alloca(returnFfiType->size);
        }
        //函数调用：根据函数模板，函数指针，返回指针，参数
        ffi_call(&cif, funcPtr, returnPtr, ffiArgs);
        
        //得到返回结果
        int returnValue = *(int *)returnPtr;
        printf("ret:%d \n",returnValue);
    }
    
    
    return 1;
    
//    NSString * appDelegateClassName;
//    @autoreleasepool {
//        // Setup code that might create autoreleased objects goes here.
//        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//    }
//    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
