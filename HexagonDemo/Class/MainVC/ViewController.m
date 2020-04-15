//
//  ViewController.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/16.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "ViewController.h"

@import Firebase;
@import FirebaseAnalytics;

#define FitBitClientId @"22DP2L"
#define FitBitClientSecret @"867d343509f9a0592483330e0468fe07"

#define FitBitAuthorizationNotication @"fitBitAuthorizationNotication"

#define FitBitRefreshAuthorization @"Basic MjJEUDJMOjg2N2QzNDM1MDlmOWEwNTkyNDgzMzMwZTA0NjhmZTA3"
#define FitBitRedirectRUI @"test://fitbit"

#define FitBitSafariVcURL  ([NSString stringWithFormat:@"https://www.fitbit.com/oauth2/authorize?response_type=code&client_id=%@&redirect_uri=%@&scope=%@&expires_in=31536000",FitBitClientId,FitBitRedirectRUI,@"profile%20settings%20nutrition"])

@interface ViewController ()<YolandaSafariViewControllerDelegate>
{
    UISwitch *switchBtn;
}
@property (nonatomic, strong) MainView *mainView;

@end

@implementation ViewController

- (RACSubject *)clickSubject {
    if (!_clickSubject) {
        _clickSubject = [RACSubject subject];
    }
    return _clickSubject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测试-test";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    if (@available(iOS 11.0, *)) {
//        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
   UIColor *color = [UIColor colorWithRed:0.0/255.0 green:140/255.0 blue:225/255.0 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = color;
//    CGFloat height = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    _mainView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_mainView];
    self.view.layer.masksToBounds = YES;
    
//    CGFloat calorie =  (((49.5 * 25000) - (1363636 / 4)) / 50 * 200000 / 500 * 693) / 10  + 495 * 200000;
//    CGFloat activiCalorie = (calorie + 50000) / 100000;
//
//    NSLog(@"%.0f",activiCalorie);
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(displayFCMToken:)
//    name:@"FCMToken"
//    object:nil];
    
    
//    return;
//    [FIRAnalytics logEventWithName:kFIREventTutorialBegin
//    parameters:@{
//                 kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
//                 kFIRParameterItemName:self.title,
//                 }];
//    
//    
//    [FIRAnalytics logEventWithName:@"sign_event" parameters:@{@"number": @"aabbcc"}];
//    
//    
//    [[FIRCrashlytics crashlytics] log:@"View loaded"];
//
//    [[FIRCrashlytics crashlytics] setCustomValue:@3 forKey:@"current_level"];
//    [[FIRCrashlytics crashlytics] setCustomValue:@"logged_in" forKey:@"last_UI_action"];
//    [[FIRCrashlytics crashlytics] setUserID:@"123456789"];
//
//    NSDictionary *userInfo = @{
//                               NSLocalizedDescriptionKey: NSLocalizedString(@"The request failed.", nil),
//                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The response returned a 404.", nil),
//                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Does this page exist?", nil),
//                               @"ProductID": @"123456",
//                               @"UserID": @"Jane Smith"
//                               };
//    NSError *error = [NSError errorWithDomain:NSURLErrorDomain
//                                         code:-1001
//                                     userInfo:userInfo];
//    [[FIRCrashlytics crashlytics] recordError:error];
//    [self testCrash];
}

//- (void)displayFCMToken:(NSNotification *) notification {
//  NSString *message =
//    [NSString stringWithFormat:@"Received FCM token: %@", notification.userInfo[@"token"]];
//}

- (void)testCrash {
    

//    [[FIRCrashlytics crashlytics] log:@"Cause Crash dic nil"];
//
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:nil forKey:@"name"];
    
}

- (void)testFitbit {
    //    YLFitbitManager *manager = [YLFitbitManager sharedFitbitManager];
    //
    //    manager.clientId = @"22DP2L";
    //    manager.clientSecret = @"867d343509f9a0592483330e0468fe07";
    //    manager.refreshAuthorization = @"Basic MjJEUDJMOjg2N2QzNDM1MDlmOWEwNTkyNDgzMzMwZTA0NjhmZTA3";
    //    manager.redirectRUI = @"test://fitbit";
    //
    //    switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(50, 100, 50, 31)];
    //    switchBtn.onTintColor = [UIColor greenColor];
    //    [switchBtn addTarget:self action:@selector(switchBtn:) forControlEvents:UIControlEventValueChanged];
    //    [self.view addSubview:switchBtn];
    //
    //    if ([manager isAuthorizationWithUserId:@"123456"]) {
    //        switchBtn.on = YES;
    //    }else{
    //        switchBtn.on = NO;
    //    }
}

- (void)testHexagon {
    //
    //    LJButton *btn = [[LJButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    //    [btn setImage:[UIImage imageNamed:@"left"] forState:(UIControlStateNormal)];
    ////    [btn setBackgroundImage:[UIImage imageNamed:@"content"] forState:(UIControlStateNormal)];
    //
    //    [btn setBackgroundColor:[[[UIImage imageNamed:@"left"] mostColor] colorWithAlphaComponent:0.2]];
    //    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    //    [btn setDefualtParam];
    //    [self.view addSubview:btn];
    //
    //
    //    UIImageView *showImageView = [[UIImageView alloc]init];
    //    showImageView.image = [UIImage imageNamed:@"measure_1"];
    //    showImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, showImageView.image.size.height);
    //    [self.view addSubview:showImageView];
    //
    //    UIView *view = [[UIView alloc] initWithFrame:showImageView.frame];
    //    view.backgroundColor = [UIColor cyanColor];
    //    [self addGradientlayer:view];
    //    [self.view addSubview:view];
    //    return;
}

- (void)addGradientlayer:(UIView *)view {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = view.bounds;
        gradientLayer.locations  = @[@(0.1), @(1.0)];
    gradientLayer.frame = view.bounds;
    CGColorRef startColor = [UIColor cyanColor].CGColor;
    CGColorRef endColor = [[UIColor cyanColor] colorWithAlphaComponent:0.1].CGColor;
    gradientLayer.colors = @[(__bridge id)startColor,(__bridge id)endColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    view.layer.mask = gradientLayer;
}

- (void)click {
    NSLog(@"=====================点击");
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    YLFoodModel *food = [[YLFoodModel alloc] init];
    food.date = @"2019-7-19";
    food.foodName = @"汉堡";
    food.mealType = YLMealTypeLunch;
    food.calories = 370;
    food.carbs = 47;
    food.fat = 23.0;
    food.protein = 5;
    food.fiber = 5;
    food.sodium = 325;
    [[YLFitbitManager sharedFitbitManager] synchronizeFoodData:food callBack:^(BOOL successFlag) {
        
    }];
    
}

- (void)switchBtn:(UISwitch *)sender{
    if (sender.on == YES) {
        sender.on = NO;
        NSString *urlStr = FitBitSafariVcURL;
        YolandaSafariViewController *yolandaSafariVc = [[YolandaSafariViewController alloc] initWithURL:[NSURL URLWithString:urlStr]];
        yolandaSafariVc.yolandaSafariViewDelegate = self;
        [self presentViewController:yolandaSafariVc animated:YES completion:nil];
    }else{
        if ([[YLFitbitManager sharedFitbitManager] isAuthorizationWithUserId:@"123456"]) {
            [[YLFitbitManager sharedFitbitManager] revokeAuthorizateWithBlock:^(BOOL success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success == NO) {
                        sender.on = YES;
                    }
                });
            }];
        }
    }
}


- (void)yolandaSafariViewControllerPopSwitchOn:(BOOL)switchStatus{
    switchBtn.on = switchStatus;
}

@end
