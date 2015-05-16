//
//  WaterViewController.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/17.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "WaterViewController.h"

@interface WaterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *AnimationView;

@end

@implementation WaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sequenceAnimation{
    
    NSArray *myImages = [NSArray arrayWithObjects:
                [UIImage imageNamed:@"1.png"],
                [UIImage imageNamed:@"2.png"],
                [UIImage imageNamed:@"3.png"],
                [UIImage imageNamed:@"4.png"],nil];
    
    self.AnimationView.animationImages = myImages;//将序列帧数组赋给UIImageView的animationImages属性
    self.AnimationView.animationDuration = 0.25;//设置动画时间
    self.AnimationView.animationRepeatCount = 1;//设置动画次数 0 表示无限
    [self.AnimationView startAnimating];//开始播放动画
    [self performSelector:@selector(dismissGo) withObject:NULL afterDelay:1];
}

-(void)dismissGo{
    [self dismissViewControllerAnimated:true completion:NULL];
}
- (IBAction)okPressed:(id)sender {
    [self sequenceAnimation];

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
