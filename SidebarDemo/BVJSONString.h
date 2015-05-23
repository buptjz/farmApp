//
//  BVJSONString.h
//  SidebarDemo
//
//  Created by WangJZ on 15/5/23.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BVJSONString)
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint;
@end

@interface NSArray (BVJSONString)
- (NSString *)bv_jsonStringWithPrettyPrint:(BOOL)prettyPrint;
@end