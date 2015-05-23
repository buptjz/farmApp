//
//  MainViewController+Network.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/23.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "MainViewController+Network.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "BVJSONString.h"
#import "SVPullToRefresh.h"

@implementation MainViewController (Network)

-(void)updateTheUI{
    //To Do : 检查是否缺水！
    [self.myScrollView.pullToRefreshView stopAnimating];
}

-(void)getMyAppKits{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:MY_APP_KITS]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request setValue:[self.dataModel valueForKey:AUTH_TOKEN_FIELD] forHTTPHeaderField:@"X-Auth-Token"];
    [request setValue:[self.dataModel valueForKey:USER_ID_FIELD] forHTTPHeaderField:@"X-User-Id"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = (NSArray *)responseObject;
        for (NSDictionary *app in arr) {
            if ([[app objectForKey:@"name"] isEqualToString:@"我的3D花园"]) {
                [self.dataModel setValue:[app objectForKey:@"_id"] forKey:APP_ID_FIELD];
                NSLog(@"我的3D花园 id = %@",[self.dataModel valueForKey:APP_ID_FIELD]);
                break;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    [op start];
}


-(void)login:(NSString *)usermail password:(NSString *)pwd{
    NSDictionary *dic = @{@"user":usermail,@"password":pwd};
    NSString *str = [dic bv_jsonStringWithPrettyPrint:NO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:LOGIN]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody: [str dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSDictionary *data = [dic objectForKey:@"data"];
        
        [self.dataModel setValue:[data objectForKey:@"authToken"] forKey:AUTH_TOKEN_FIELD];
        [self.dataModel setValue:[data objectForKey:@"userId"] forKey:USER_ID_FIELD];
        NSLog(@"login seccess %@!",data);
        [self getMyAppKits];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    [op start];
}

-(void)getDataEvents{
    NSString *url = [NSString stringWithFormat:@"%@/%@",DATA_EVENTS,[self.dataModel valueForKey:APP_ID_FIELD]];
    NSLog(@"[GET] = %@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request setValue:[self.dataModel valueForKey:AUTH_TOKEN_FIELD] forHTTPHeaderField:@"X-Auth-Token"];
    [request setValue:[self.dataModel valueForKey:USER_ID_FIELD] forHTTPHeaderField:@"X-User-Id"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        /*  解析数据  */
        NSDictionary *dic = (NSDictionary *)responseObject;
        [dic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *obj, BOOL *stop) {
            NSDictionary *cgq = [self.dataModel objectForKey:key];
            [cgq setValue:[obj valueForKey:@"value"] forKey:@"value"];
            [cgq setValue:[obj valueForKey:@"submit_time"] forKey:@"submit_time"];
        }];
        
        [self performSelector:@selector(updateTheUI) withObject:nil afterDelay:0.5f];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    [op start];
}

-(void)getControlEvents{
    NSString *url = [NSString stringWithFormat:@"%@/%@",CONTROL_EVENTS,[self.dataModel valueForKey:APP_ID_FIELD]];
    NSLog(@"[GET] = %@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request setValue:[self.dataModel valueForKey:AUTH_TOKEN_FIELD] forHTTPHeaderField:@"X-Auth-Token"];
    [request setValue:[self.dataModel valueForKey:USER_ID_FIELD] forHTTPHeaderField:@"X-User-Id"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"[READ] CONTROl %@",dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    [op start];
}

-(void)postControlEvents:(NSString *)control_name value:(NSString *)control_value{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:CONTROL_EVENTS]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:[self.dataModel valueForKey:AUTH_TOKEN_FIELD] forHTTPHeaderField:@"X-Auth-Token"];
    [request setValue:[self.dataModel valueForKey:USER_ID_FIELD] forHTTPHeaderField:@"X-User-Id"];
    
    NSDictionary *postData = @{@"my_app_kit_id":[self.dataModel valueForKey:APP_ID_FIELD],@"control_name":control_name,@"control_value":control_value};
    NSString *str = [postData bv_jsonStringWithPrettyPrint:NO];
    [request setHTTPBody: [str dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"[WRITE] CONTROl %@",dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    [op start];
}

@end
