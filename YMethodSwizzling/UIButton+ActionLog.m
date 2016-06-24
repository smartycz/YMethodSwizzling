//
//  UIButton+ActionLog.m
//  YMethodSwizzling
//
//  Created by Stone.Yu on 16/6/15.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "UIButton+ActionLog.h"
#import "YSwizzlingTool.h"
#import "ViewController.h"
#import "ActionLogManager.h"

@implementation UIButton (ActionLog)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [YSwizzlingTool swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

#pragma mark - Method Swizzling
- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    [self swiz_sendAction:action to:target forEvent:event];
    
    //插入埋点代码
    [self performUserStastisticsAction:action to:target forEvent:event];
}

- (void)performUserStastisticsAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    ViewController *vc = (ViewController *)target;

    NSString *eventID = [self getEventIDWtihAction:action target:target];
    
    NSLog(@"\nhook success.\n[1]action:%@\n[2]target:%@ \n[3]event:%ld \n[4]parameter:%@ \n[4]eventID:%@", NSStringFromSelector(action), target, (long)event, vc.logDic, eventID);
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents eventID:(NSString *)eventID;
{
    [self addTarget:target action:action forControlEvents:controlEvents];
    
    [self setEventIDWtihAction:action target:target eventID:eventID];
}

- (void)setEventIDWtihAction:(SEL)action target:(id)target eventID:(NSString *)eventID
{
    NSString *actionString = NSStringFromSelector(action);
    NSString *targetName = NSStringFromClass([target class]);
    
    [ActionLogManager setEventIDWtihActionName:actionString targetName:targetName eventID:eventID];
}

- (NSString *)getEventIDWtihAction:(SEL)action target:(id)target
{
    NSString *eventID = @"";
    
    NSString *actionString = NSStringFromSelector(action);
    NSString *targetName = NSStringFromClass([target class]);
    
    eventID = [ActionLogManager getEventIDWtihActionName:actionString targetName:targetName];
    
    return eventID;
}

@end
