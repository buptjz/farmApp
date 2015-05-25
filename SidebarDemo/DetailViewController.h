//
//  DetailViewController.h
//  SidebarDemo
//
//  Created by WangJZ on 15/5/24.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *image_view;


@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) UIImage *image;
@end
