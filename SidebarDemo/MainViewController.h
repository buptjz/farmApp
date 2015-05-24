//
//  MainViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshView.h"

@interface MainViewController : UIViewController<UIScrollViewDelegate>{
    UIImageView *navBarHairlineImageView;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *photo2_img_view;
@property (weak, nonatomic) IBOutlet UIImageView *photo3_img_view;
@property (weak, nonatomic) IBOutlet UIImageView *photo4_img_view;
@property (weak, nonatomic) IBOutlet UIImageView *photo1_img_view;

-(void)updateTheUI;
@end
