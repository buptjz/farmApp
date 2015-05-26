//
//  DadaManager.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/17.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "DadaManager.h"
#import "AppDelegate.h"

@implementation DadaManager




+(NSMutableDictionary *)LoadData{
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"sensor_states.plist"];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:filename]) {
        // If it doesn't, copy it from the default file in the Bundle
        NSString *boundlePath = [[NSBundle mainBundle] pathForResource:@"sensor_states" ofType:@"plist"];
        [fm copyItemAtPath:boundlePath toPath:filename error:nil];
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"[R DB]%@", data);//直接打印数据
    return data;
}

+(void) SavaData:(NSDictionary *)dic{
    NSLog(@"[W DB] %@",dic);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"sensor_states.plist"];
    //输入写入
    [dic writeToFile:filename atomically:YES];
}

@end
