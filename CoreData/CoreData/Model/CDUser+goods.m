//
//  CDUser+goods.m
//  CoreData
//
//  Created by zhoufei on 2020/11/3.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "CDUser+goods.h"
#import <objc/runtime.h>

static void *kGoodsName = &kGoodsName;

@implementation CDUser (goods)
@dynamic goods;
 
- (void)setGoods:(NSString *)goods {
    objc_setAssociatedObject(self, kGoodsName, goods, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)goods {
    return objc_getAssociatedObject(self, kGoodsName);
}

@end
