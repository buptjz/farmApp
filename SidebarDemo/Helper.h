//
//  Helper.h
//  SidebarDemo
//
//  Created by WangJZ on 15/5/24.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject
+ (void)initNavigationView:(UIViewController *)viewController;
+(BOOL)judgeLackWater:(NSDictionary *)dic;
+(void)generateFakeData;
@end
