//
//  ActionLogManager.h
//  YMethodSwizzling
//
//  Created by Stone.Yu on 16/6/16.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionLogManager : NSObject

+ (void)setEventIDWtihActionName:(NSString *)actionName targetName:(NSString *)targetName eventID:(NSString *)eventID;

+ (NSString *)getEventIDWtihActionName:(NSString *)actionName targetName:(NSString *)targetName;

@end
