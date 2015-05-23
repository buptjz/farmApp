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
#import "AFNetworking.h"
#import "DadaManager.h"
#import "Constant.h"
#import "SVPullToRefresh.h"
#import "JGActionSheet.h"

//"http://api.yeelink.net/v1.1/device/18975/sensor/33104/datapoints"
static NSString *BaseURLString = @"http://api.yeelink.net/v1.0/device/18975";

static NSString *myURLString  = @"http://api.yeelink.net/v1.0/device/18975/sensor/33034/datapoints";
//static NSString *rawdata = @"{\"timestamp\":\"2015-05-17T20:28:14\", \"value\":233 }";

@interface MainViewController ()

@property(nonatomic,retain) NSDictionary *sensors;
@property (weak, nonatomic) IBOutlet UIButton *waterButton;
@property (nonatomic) BOOL lackWater;
@property (weak, nonatomic) IBOutlet UILabel *m1label;
@property (weak, nonatomic) IBOutlet UILabel *m2label;
@property (weak, nonatomic) IBOutlet UILabel *m3label;
@property (weak, nonatomic) IBOutlet UILabel *top_label;


@end

@implementation MainViewController

-(void)setLackWater:(BOOL)lackWater{
    if (_lackWater == lackWater)
        return;
    if (lackWater == true) {
        [self lackWaterTriggering];
    }else{
        [self nolackWaterTriggering];
    }
}

-(void)setSensors:(NSDictionary *)sensors{
    //随着sendor的改变，调整视图
    if ([[sensors valueForKey:@"value"] intValue] == 1) {
        self.lackWater = true;
    }else{
        self.lackWater = false;
    }
}

-(void)nolackWaterTriggering{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:ANIMATION_DURATION animations:^(void){
            self.waterButton.alpha = 0.0;
            self.waterButton.enabled = NO;
        }completion:^(BOOL finished){
        }];
    });
}

-(void)lackWaterTriggering{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:ANIMATION_DURATION animations:^(void){
            self.waterButton.alpha = 1.0;
            self.waterButton.enabled = YES;
        }completion:^(BOOL finished){
        }];
    });
}

-(IBAction)waterButtonPressed:(id)sender {
    //http://www.jianshu.com/p/bf3325111fe5
    WaterViewController * testVC = [[WaterViewController alloc]init];
    self.definesPresentationContext = YES; //self is presenting view controller
    testVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    testVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:testVC animated:YES completion:nil];
    
//    UIActionSheet *sheet = [[UIActionSheet alloc] init];
//    WaterViewController *testVC = [[WaterViewController alloc]initWithNibName:@"WaterViewController" bundle:[NSBundle mainBundle]];
//    [sheet addSubview:testVC.view];
//    [sheet showInView:self.view];
    
//    WaterViewController *vc = [[WaterViewController alloc] init];
//    
//    vc.view.frame = CGRectMake(0,0,320,300); //Your own CGRect
//    [self.view addSubview:vc.view]; //If you don't want to show inside a specific view
//    [self addChildViewController:vc];
//    [self didMoveToParentViewController:vc];
    //for someone, may need to do this.
    //[self.navigationController addChildViewController:vc];
    //[self.navigationController didMoveToParentViewController:vc];
}

-(void)viewDidDisappear:(BOOL)animated{
    [DadaManager SavaData:self.sensors];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.top_label.font = [UIFont fontWithName:FONT_CU size:18];
    self.m1label.font = [UIFont fontWithName:FONT_CU size:21];
    self.m2label.font = [UIFont fontWithName:FONT_CU size:21];
    self.m3label.font = [UIFont fontWithName:FONT_CU size:21];
    
    self.title = FIRSTPAGETITLE;
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg128.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                                                       NSForegroundColorAttributeName, nil]];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.sensors = [DadaManager LoadData];
    
    self.myScrollView.contentSize = CGSizeMake(320, SCROLLHEIGHT);
//    self.myScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.myScrollView addPullToRefreshWithActionHandler:^{
        [self get_data];
    }];
    
    self.waterButton.enabled = NO;
    self.waterButton.alpha = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)shareButtonPressed:(id)sender {
    NSLog(@"shareButton pressed");
    NSString *texttoshare = @"分享"; //this is your text string to share
    UIImage *imagetoshare = [UIImage imageNamed:@"bg128.png"]; //this is your image to share
    NSArray *activityItems = @[texttoshare, imagetoshare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
    [self presentViewController:activityVC animated:TRUE completion:nil];
}

-(void)send_data:(NSString *)urlString data:(NSString *) dataString{
    NSURL *myURL = [NSURL URLWithString:myURLString];
    NSLog(@"发送POST请求\n【url】=%@\n【raw_data】=%@",urlString,dataString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"f041c96ac09984620fb520ee9d439f9d" forHTTPHeaderField:@"U-ApiKey"];
    [request setHTTPBody: [dataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON responseObject: %@ ",responseObject);
        NSLog(@"upload data success!");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    [op start];
    
}


-(void)get_data{
    //http://stackoverflow.com/questions/19114623/request-failed-unacceptable-content-type-text-html-using-afnetworking-2-0
    NSString *sensor_id = @"33104";
    NSString *string = [NSString stringWithFormat:@"%@/sensor/%@/datapoints", BaseURLString,sensor_id];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"发起json请求 == %@",url);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data_dic = (NSDictionary *)responseObject;
        NSLog(@"%@",data_dic);
        self.sensors = data_dic;
        [self.myScrollView.pullToRefreshView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Json Get"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [operation start];
}

-(NSString *)assemblePostDataWithValue:(NSString *)value{
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//:"2015-03-11 16:13:14"
    NSString * na = [df stringFromDate:currentDate];
    NSString *retString = [NSString stringWithFormat: @"{\"timestamp\":\"%@\", \"value\":%@}",na,value];
    NSLog(@"%@",retString);
    return retString;
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
