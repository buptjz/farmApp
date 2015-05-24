//
//  Helper.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/24.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "Helper.h"
#import "Constant.h"

@implementation Helper

+(BOOL)judgeLackWater:(NSDictionary *)dic{
//    srandom(time(0));
//    if(random() % 2 == 1){
//        NSLog(@"缺水！");
//        return true;
//    }
//    NSLog(@"不缺水！");
//    return false;
    
    NSString *h1Value = [(NSDictionary *)[dic valueForKey:H1] valueForKey:@"value"];
    if (h1Value.intValue == 22) {
        NSLog(@"缺！");
        return true;
    }else{
        NSLog(@"不缺！");
        return false;
    }
}

@end
