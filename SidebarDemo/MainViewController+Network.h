//
//  MainViewController+Network.h
//  SidebarDemo
//
//  Created by WangJZ on 15/5/23.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (Network)

-(void)getControlEvents;
-(void)postControlEvents:(NSString *)control_name value:(NSString *)control_value;
-(void)getDataEvents;
-(void)login:(NSString *)usermail password:(NSString *)pwd;
-(void)getMyAppKits;
@end
