//
//  ActionLogManager.m
//  YMethodSwizzling
//
//  Created by Stone.Yu on 16/6/16.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "ActionLogManager.h"

@implementation ActionLogManager

+ (void)setEventIDWtihActionName:(NSString *)actionName targetName:(NSString *)targetName eventID:(NSString *)eventID
{
    NSString *filePath =[ActionLogManager filePahtWithFileName:targetName];
    NSMutableDictionary *configDic;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        configDic = [[[NSMutableDictionary alloc]initWithContentsOfFile:filePath]mutableCopy];
        if (!configDic) {
            configDic = [NSMutableDictionary dictionary];
        }
    } else {
        configDic = [NSMutableDictionary dictionary];
    }
    
    if (![configDic.allKeys containsObject:actionName]) {
        configDic[actionName] = eventID;
        
        BOOL isOK = [configDic writeToFile:filePath atomically:YES];
        
        if (!isOK) {
            NSLog(@"writeToFile is failure!!!");
        }
    }
}

+ (NSString *)getEventIDWtihActionName:(NSString *)actionName targetName:(NSString *)targetName
{
    NSString *eventID = @"";
    
    NSString *filePath = [ActionLogManager filePahtWithFileName:targetName];
    NSMutableDictionary *configDic;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        configDic = [[[NSMutableDictionary alloc]initWithContentsOfFile:filePath]mutableCopy];
        
        if (configDic) {
            eventID = configDic[actionName];
        }
    }
    
    return eventID;
}

+ (NSString *)filePahtWithFileName:(NSString *)name
{
    NSString *pilist = [NSString stringWithFormat:@"%@.plist", name];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = paths[0];
    NSString *filePath =[documentsDirectory stringByAppendingPathComponent:pilist];
    
    return filePath;
}

@end
