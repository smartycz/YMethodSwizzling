//
//  UIButton+ActionLog.h
//  YMethodSwizzling
//
//  Created by Stone.Yu on 16/6/15.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ActionLog)

- (void)setEventIDWtihAction:(SEL)action target:(id)target eventID:(NSString *)eventID;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents eventID:(NSString *)eventID;

@end
