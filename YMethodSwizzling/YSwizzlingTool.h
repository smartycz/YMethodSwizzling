//
//  YSwizzlingTool.h
//  YMethodSwizzling
//
//  Created by Stone.Yu on 16/6/15.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface YSwizzlingTool : NSObject

+ (void)swizzlingMethod:(Method)originalMethod swizzledSelector:(Method)swizzledMethod;

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
