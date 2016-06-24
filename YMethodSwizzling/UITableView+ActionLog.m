//
//  UITableView+ActionLog.m
//  YMethodSwizzling
//
//  Created by Stone.Yu on 16/6/16.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "UITableView+ActionLog.h"
#import "YSwizzlingTool.h"
#import "ViewController.h"

@implementation UITableView (ActionLog)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(setDelegate:);
        SEL swizzledSelector = @selector(swiz_setDelegate:);
        [YSwizzlingTool swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

- (void)swiz_setDelegate:(id)delegate
{
    [self swiz_setDelegate:delegate];
    
    if (class_addMethod([delegate class], NSSelectorFromString(@"actionLog_didSelectRowAtIndexPath"), (IMP)actionLog_didSelectRowAtIndexPath, "v@:@@")) {
        
        Method dis_originalMethod = class_getInstanceMethod([delegate class], NSSelectorFromString(@"actionLog_didSelectRowAtIndexPath"));
        
        Method dis_swizzledMethod = class_getInstanceMethod([delegate class], @selector(tableView:didSelectRowAtIndexPath:));
        
        [YSwizzlingTool swizzlingMethod:dis_originalMethod swizzledSelector:dis_swizzledMethod];
    }
}

void actionLog_didSelectRowAtIndexPath(id self, SEL _cmd, id tableView, id indexpath)
{
    NSIndexPath *path = (NSIndexPath *)indexpath;
    UITableView *tab = (UITableView *)tableView;
    
    SEL selector = NSSelectorFromString(@"actionLog_didSelectRowAtIndexPath");
    
    ((void(*)(id, SEL,id, id))objc_msgSend)(self, selector, tableView, indexpath);
    
    NSLog(@"\n***hook success.\n[1]selector:%@ \n[2]indexpath:%@ \n[3]target:%@", NSStringFromSelector(@selector(tableView:didSelectRowAtIndexPath:)), @(path.row), NSStringFromClass([tab.delegate class]));
}

@end
