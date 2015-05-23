//
//  ThirdViewController.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/16.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "ThirdViewController.h"
#import "Constant.h"
#import "JGActionSheet.h"

@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySeg;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation ThirdViewController

- (IBAction)messageButtonPressed:(id)sender {
    
//    NSString *title = NSLocalizedString(@"发布你的活动", nil);
//    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
//    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//    }];
//    
//    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//    }];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//
//    }];
//    
//    [alertController addAction:cancelAction];
//    [alertController addAction:otherAction];
//    [self presentViewController:alertController animated:YES completion:nil];
}

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
    self.myImageView.image = [UIImage imageNamed:SEG1_IMAGE];
    self.myScrollView.contentSize = CGSizeMake(320, SCROLLHEIGHT2);
    self.myScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
