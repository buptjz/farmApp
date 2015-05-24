//
//  NewSideController.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/24.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "NewSideController.h"
#import "DadaManager.h"
#import "AppDelegate.h"
#import "Helper.h"
#import "Constant.h"
#import "SWRevealViewController.h"

@interface NewSideController ()

@property (weak, nonatomic) IBOutlet UIImageView *waterImageView;
@property (nonatomic) BOOL lackWater;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;

@end

@implementation NewSideController

-(void)setLackWater:(BOOL)lackWater{
    if (_lackWater == lackWater)
        return;
    _lackWater = lackWater;
    if (lackWater == true) {
        [self lackWaterTriggering];
    }else{
        [self nolackWaterTriggering];
    }
}

-(void)nolackWaterTriggering{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:ANIMATION_DURATION animations:^(void){
            self.waterImageView.alpha = 0.0;
        }completion:^(BOOL finished){
        }];
    });
}

-(void)lackWaterTriggering{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:ANIMATION_DURATION animations:^(void){
            self.waterImageView.alpha = 1.0;
        }completion:^(BOOL finished){
        }];
    });
}


-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"Side Appear!");
    AppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    NSDictionary *dataModel = appDelegate.dataModel;
    self.lackWater = [Helper judgeLackWater:dataModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lackWater = false;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.toggleButton addTarget:revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// In a storyboard-based application, you will often want to do a little preparation before navigation

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
