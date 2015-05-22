//
//  ThirdViewController.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/16.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "ThirdViewController.h"
#import "Constant.h"

@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySeg;

@end

@implementation ThirdViewController


-(void)onSegValChanged:(UISegmentedControl *) sender{
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            NSLog(@"0 clicked.");
            self.myImageView.image = [UIImage imageNamed:SEG1_IMAGE];
            break;
        case 1:
            self.myImageView.image = [UIImage imageNamed:SEG2_IMAGE];
            NSLog(@"1 clicked.");
        break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg128.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                                                                     NSForegroundColorAttributeName, nil]];
    self.myImageView.image = [UIImage imageNamed:@"2.png"];
    self.myScrollView.contentSize = CGSizeMake(320, SCROLLHEIGHT2);
    [self.mySeg addTarget:self action:@selector(onSegValChanged:) forControlEvents:UIControlEventValueChanged];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}

@end
