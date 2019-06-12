//
//  ViewController.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/16.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"
#import "LJButton.h"
#import "UIImage+Addition.h"

@interface ViewController ()

@property (nonatomic, strong) MainView *mainView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//
//    LJButton *btn = [[LJButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [btn setImage:[UIImage imageNamed:@"left"] forState:(UIControlStateNormal)];
////    [btn setBackgroundImage:[UIImage imageNamed:@"content"] forState:(UIControlStateNormal)];
//
//    [btn setBackgroundColor:[[[UIImage imageNamed:@"left"] mostColor] colorWithAlphaComponent:0.2]];
//    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
//    [btn setDefualtParam];
//    [self.view addSubview:btn];
    
    
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
    
    
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
   UIColor *color = [UIColor colorWithRed:0.0/255.0 green:140/255.0 blue:225/255.0 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = color;
//    CGFloat height = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    _mainView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_mainView];
    self.view.layer.masksToBounds = YES;
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
@end
