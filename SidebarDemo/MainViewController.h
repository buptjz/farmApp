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
@property(nonatomic,retain) NSDictionary *dataModel;

-(void)updateTheUI;
@end
