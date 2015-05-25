//
//  DetailViewController.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/24.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "DetailViewController.h"
#import "Constant.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *lineImageVIew;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong,nonatomic) UIImageView *iv;
@end

@implementation DetailViewController

- (IBAction)leftPressed:(id)sender {
    self.lineImageVIew.image = [UIImage imageNamed:@"xq_选中1.png"];
    [self.myScrollView setUserInteractionEnabled:NO];
    [self.myScrollView setAlpha:0];
}

- (IBAction)rightPressed:(id)sender {
    self.lineImageVIew.image = [UIImage imageNamed:@"xq_选中2.png"];
    [self.myScrollView setAlpha:1];
    [self.myScrollView setUserInteractionEnabled:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.image_view.image = self.image;
    self.title = self.type;
    NSLog(@"Now in %@",self.type);
    
    UIImage *img;
    if ([self.type isEqualToString: TYPE2]) {
        img = [UIImage imageNamed:TYPE_2_IMAGE];
    }else if([self.type isEqualToString: TYPE3]){
        img = [UIImage imageNamed:TYPE_3_IMAGE];
    }else if([self.type isEqualToString: TYPE4]){
        img = [UIImage imageNamed:TYPE_4_IMAGE];
    }

    self.iv = [[UIImageView alloc]initWithImage:img];
    [self.myScrollView addSubview:self.iv];
    [self.myScrollView setContentSize:img.size];
    [self.myScrollView setUserInteractionEnabled:NO];
    [self.myScrollView setAlpha:0];
    
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
