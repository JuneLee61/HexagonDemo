//
//  YolandaSafariViewController.m
//  YolandaOverSea
//
//  Created by DonYau on 2017/4/27.
//  Copyright © 2017年 Yolanda. All rights reserved.
//

#import "YolandaSafariViewController.h"

@interface YolandaSafariViewController (){

}

@end

@implementation YolandaSafariViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reviceAuthorizationNotification:) name:@"FitBitAuthorizationNotication" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)reviceAuthorizationNotification:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    BOOL switchStatus = NO;
    if ([[dic valueForKey:@"AuthorizationStatus"] isEqualToString:@"1"]) {
        switchStatus = YES;
    }
    if ([self.yolandaSafariViewDelegate respondsToSelector:@selector(yolandaSafariViewControllerPopSwitchOn:)]) {
        [self.yolandaSafariViewDelegate yolandaSafariViewControllerPopSwitchOn:switchStatus];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
