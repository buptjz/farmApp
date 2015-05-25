//
//  SecondViewController.m
//  SidebarDemo
//
//  Created by wangjz on 15/5/10.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "SecondViewController.h"
#import "Helper.h"
#import "Constant.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySeg;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong,nonatomic) UIImageView *iv;
@end

@implementation SecondViewController

-(void)onSegValChanged:(UISegmentedControl *) sender{
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            NSLog(@"0 clicked.");
            self.iv.image = [UIImage imageNamed:TH_SEG1_IMAGE];
            break;
        case 1:
            self.iv.image = [UIImage imageNamed:TH_SEG2_IMAGE];
            NSLog(@"1 clicked.");
            break;
        case 2:
            self.iv.image = [UIImage imageNamed:TH_SEG3_IMAGE];
            NSLog(@"2 clicked.");
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Helper initNavigationView:self];
    UIImage *img = [UIImage imageNamed:TH_SEG1_IMAGE];
    self.iv = [[UIImageView alloc]initWithImage:img];
    [self.myScrollView addSubview:self.iv];
    [self.myScrollView setContentSize:img.size];
    [self.mySeg addTarget:self action:@selector(onSegValChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
