//
//  YSwizzlingTool.m
//  YMethodSwizzling
//
//  Created by Stone.Yu on 16/6/15.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "YSwizzlingTool.h"

@implementation YSwizzlingTool

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Class class = cls;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzlingMethod:(Method)originalMethod swizzledSelector:(Method)swizzledMethod
{
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end
