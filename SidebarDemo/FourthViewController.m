//
//  FourthViewController.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/16.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "FourthViewController.h"
#import "Helper.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Helper initNavigationView:self];
    self.title = @"我的菜篮";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
