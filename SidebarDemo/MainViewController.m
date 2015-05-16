//
//  MainViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "WaterViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *modalView;


@end

@implementation MainViewController


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"拖动开始");
    NSLog(@"%f",self.myScrollView.contentOffset.y);
    [self.refreshView isScrollViewStartDragging:scrollView];
}
// 拖动过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
        NSLog(@"拖动过程");
    [self.refreshView isScrollViewDragging:scrollView_];
}
// 拖动结束后
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView_ willDecelerate:(BOOL)decelerate {
            NSLog(@"拖动结束");
    [self.refreshView isScrollViewEndDragging:scrollView_];
}

-(void)initScroll{
    NSArray *nils = [[NSBundle mainBundle]loadNibNamed:@"Empty" owner:self options:nil];
    self.refreshView =[nils objectAtIndex:0];
    self.refreshView.frame = CGRectMake(0, -50, 320, 50);
    //refreshView.backgroundColor = [UIColor redColor];
    [self.myScrollView addSubview:self.refreshView];
    self.myScrollView.contentSize = CGSizeMake(320, 548);
    self.myScrollView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
}

- (IBAction)checkButtonPressed:(id)sender {
    //http://www.jianshu.com/p/bf3325111fe5
    
    NSLog(@"button pressed!");
    
    WaterViewController * testVC = [[WaterViewController alloc]init];
    
    self.definesPresentationContext = YES; //self is presenting view controller
    testVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    testVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:testVC animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScroll];
    
    self.modalView.alpha = 0;
    self.title = @"News";

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
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
