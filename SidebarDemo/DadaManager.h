//
//  DadaManager.h
//  SidebarDemo
//
//  Created by WangJZ on 15/5/17.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DadaManager : NSObject

+(NSMutableDictionary *)LoadData;
+(void) SavaData:(NSDictionary *)array;

@end
