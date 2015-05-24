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
#import "MainViewController+Network.h"
#import "AppDelegate.h"
#import "Helper.h"

//"http://api.yeelink.net/v1.1/device/18975/sensor/33104/datapoints"
static NSString *BaseURLString = @"http://api.yeelink.net/v1.0/device/18975";
static NSString *myURLString  = @"http://api.yeelink.net/v1.0/device/18975/sensor/33034/datapoints";
//static NSString *rawdata = @"{\"timestamp\":\"2015-05-17T20:28:14\", \"value\":233 }";

@interface MainViewController ()

@property (strong,nonatomic) UIButton *okButton;
@property (strong,nonatomic) JGActionSheet *sheet;
@property (strong,nonatomic) UIImageView *animation_image_view;
@property (strong,nonatomic) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *waterButton;
@property (nonatomic) BOOL lackWater;
@property (weak, nonatomic) IBOutlet UILabel *m1label;
@property (weak, nonatomic) IBOutlet UILabel *m2label;
@property (weak, nonatomic) IBOutlet UILabel *m3label;
@property (weak, nonatomic) IBOutlet UILabel *top_label;
@property (weak, nonatomic) IBOutlet UILabel *trsd1_label;
@property (weak, nonatomic) IBOutlet UILabel *trsd2_label;
@property (weak, nonatomic) IBOutlet UILabel *trsd3_label;
@property (weak, nonatomic) IBOutlet UILabel *trsd4_label;

@property (strong, nonatomic) NSMutableArray *ani_images;



@end

@implementation MainViewController

-(void)updateTheUI{
    //To Do : 检查是否缺水！
    [self.myScrollView.pullToRefreshView stopAnimating];
    AppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    NSDictionary *dataModel = appDelegate.dataModel;
    self.trsd1_label.text = [NSString stringWithFormat:@"%@%%",[(NSDictionary *)[dataModel valueForKey:H1] valueForKey:@"value"]];
    self.trsd2_label.text = [NSString stringWithFormat:@"%@%%",[(NSDictionary *)[dataModel valueForKey:H2] valueForKey:@"value"]];
    self.trsd3_label.text = [NSString stringWithFormat:@"%@%%",[(NSDictionary *)[dataModel valueForKey:H3] valueForKey:@"value"]];
    self.trsd4_label.text = [NSString stringWithFormat:@"%@%%",[(NSDictionary *)[dataModel valueForKey:H4] valueForKey:@"value"]];
    self.lackWater = [Helper judgeLackWater:dataModel];
}


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

-(void)dismissSheet{
    [self.sheet dismissAnimated:YES];
}

-(void)sheetOkButtonPressed{
    NSLog(@"Pressed sheet ok!");
    [self.sheet setUserInteractionEnabled:NO];
    [self.okButton setUserInteractionEnabled:NO];
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"田1.png"],
                         [UIImage imageNamed:@"田2.png"],
                         [UIImage imageNamed:@"田3.png"],
                         [UIImage imageNamed:@"田4.png"],nil];

    self.animation_image_view.animationImages = myImages;//将序列帧数组赋给UIImageView的animationImages属性
    self.animation_image_view.animationDuration = 0.25;//设置动画时间
    self.animation_image_view.animationRepeatCount = 1;//设置动画次数 0 表示无限
    [self.animation_image_view startAnimating];//开始播放动画
    [self performSelector:@selector(dismissSheet) withObject:nil afterDelay:1];
}

-(void)initSheetView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 290, 320)];
    UIImage *img = [UIImage imageNamed:@"幼苗期new.png"];
    self.animation_image_view = [[UIImageView alloc]initWithImage:img];
    [bgView addSubview:self.animation_image_view ];
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.frame = CGRectMake(0, 270, 290, 50);
    [okButton setImage:[UIImage imageNamed:@"bg128.png"] forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(sheetOkButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:okButton];
    
    JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"确定", @"取消",@"填充"] buttonStyle:
                                      JGActionSheetButtonStyleDefault];
    JGActionSheetSection *cus_sec = [[JGActionSheetSection alloc]initWithTitle:nil message:nil contentView:bgView];
    NSArray *sections = @[cus_sec,section1];
    
    self.sheet = [JGActionSheet actionSheetWithSections:sections];
    section1.alpha = 0;
    [self.sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
    }];
}

-(IBAction)waterButtonPressed:(id)sender {
    [self postControlEvents:@"Water" value:@"True"];
    [self.waterButton.imageView startAnimating];
//    [self initSheetView];
//    UIView *topView = [[[UIApplication sharedApplication] delegate] window];
//    [self.sheet showInView:topView animated:YES];

}

//-(void)viewDidDisappear:(BOOL)animated{
//    [DadaManager SavaData:self.dataModel];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.dataModel = [DadaManager LoadData];
    [self login:USERMAIL password:PWD];
    
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
    self.myScrollView.contentSize = CGSizeMake(320, SCROLLHEIGHT);
    [self.myScrollView addPullToRefreshWithActionHandler:^{
        [self getDataEvents];
    }];
    
    self.waterButton.enabled = NO;
    self.waterButton.alpha = 0.0;
    
    //设定定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERNAL target:self selector:@selector(updateAll) userInfo:nil repeats:YES];
    
    //初始化animation image
    self.ani_images = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < ANI_IMAGE_NUM; i++) {
        NSString *name = [NSString stringWithFormat:@"%@%02d.png",ANI_IMAGE_NAME,i];
        NSLog(@"%@",name);
        [self.ani_images addObject:[UIImage imageNamed:name]];
    }
    self.waterButton.imageView.animationImages = self.ani_images;//将序列帧数组赋给UIImageView的animationImages属性
    self.waterButton.imageView.animationDuration = ANI_DURATION;//设置动画时间
    self.waterButton.imageView.animationRepeatCount = ANI_REPEAT;//设置动画次数 0 表示无限
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
    [self.timer setFireDate:[NSDate distantPast]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
    [self.timer setFireDate:[NSDate distantFuture]];
}

@end
