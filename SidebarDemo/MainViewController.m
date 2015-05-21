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

//"http://api.yeelink.net/v1.1/device/18975/sensor/33104/datapoints"
static NSString *BaseURLString = @"http://api.yeelink.net/v1.0/device/18975";

static NSString *myURLString  = @"http://api.yeelink.net/v1.0/device/18975/sensor/33034/datapoints";
//static NSString *rawdata = @"{\"timestamp\":\"2015-05-17T20:28:14\", \"value\":233 }";

@interface MainViewController ()

@property(nonatomic,retain) NSMutableDictionary *sensors;
@property (weak, nonatomic) IBOutlet UIImageView *lackWaterImage;

@end

@implementation MainViewController

-(void)nolackWaterTriggering{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:3 animations:^(void){
            self.lackWaterImage.alpha = 0.0;
        }completion:^(BOOL finished){
            //            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
            //            label.backgroundColor = [UIColor blackColor];
            //            [self.view addSubview:label];
        }];
    });
}

-(void)lackWaterTriggering{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:3 animations:^(void){
            self.lackWaterImage.alpha = 1;
        }completion:^(BOOL finished){
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
//            label.backgroundColor = [UIColor blackColor];
//            [self.view addSubview:label];
        }];
    });
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

-(void)postJsonDataToURL:(NSString *)urlString data:(NSString *) dataString{
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


//获取json数据
-(void)getJsonData{
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
        self.title = @"JSON Retrieved";
        NSLog(@"%@",data_dic);
        
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


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"拖动开始");
    self.myScrollView.showsPullToRefresh = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
//    NSLog(@"拖动过程");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView_ willDecelerate:(BOOL)decelerate {
    self.myScrollView.showsPullToRefresh = NO;
    NSString *data = [self assemblePostDataWithValue:@"333"];
    [self postJsonDataToURL:myURLString data:data];
}

-(void)initScroll{
//    NSArray *nils = [[NSBundle mainBundle]loadNibNamed:@"Empty" owner:self options:nil];
//    self.refreshView =[nils objectAtIndex:0];
//    self.refreshView.frame = CGRectMake(0, -50, 320, 50);
//    //refreshView.backgroundColor = [UIColor redColor];
//    [self.myScrollView addSubview:self.refreshView];
    self.myScrollView.contentSize = CGSizeMake(320, 498);
    self.myScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.myScrollView addPullToRefreshWithActionHandler:^{
        // prepend data to dataSource, insert cells at top of table view
        // call [tableView.pullToRefreshView stopAnimating] when done
    }];
}

- (IBAction)checkButtonPressed:(id)sender {
    //http://www.jianshu.com/p/bf3325111fe5
    
    NSLog(@"button pressed!");
    [self lackWaterTriggering];
//    WaterViewController * testVC = [[WaterViewController alloc]init];
//    self.definesPresentationContext = YES; //self is presenting view controller
//    testVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
//    testVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self presentViewController:testVC animated:YES completion:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [DadaManager SavaData:self.sensors];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScroll];
    self.title = FIRSTPAGETITLE;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.sensors = [DadaManager LoadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)shareButtonPressed:(id)sender {
    NSLog(@"shareButton pressed");
    NSString *texttoshare = @"分享"; //this is your text string to share
    UIImage *imagetoshare = [UIImage imageNamed:@"1.png"]; //this is your image to share
    
    NSArray *activityItems = @[texttoshare, imagetoshare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
    [self presentViewController:activityVC animated:TRUE completion:nil];
}


@end
