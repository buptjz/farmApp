//
//  ThirdViewController.h
//  SidebarDemo
//
//  Created by WangJZ on 15/5/16.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ThirdViewController : UIViewController<UIScrollViewDelegate>{
    UIImageView *navBarHairlineImageView;
}

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

//@property (strong, nonatomic) NSArray *list;

@end
