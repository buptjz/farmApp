//
//  SecondViewController.m
//  SidebarDemo
//
//  Created by wangjz on 15/5/10.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "SecondViewController.h"
#import "Helper.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Helper initNavigationView:self];
    UIImage *img = [UIImage imageNamed:@"社区bg.png"];
    UIImageView *iv = [[UIImageView alloc]initWithImage:img];
    [self.myScrollView addSubview:iv];
    [self.myScrollView setContentSize:img.size];

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
