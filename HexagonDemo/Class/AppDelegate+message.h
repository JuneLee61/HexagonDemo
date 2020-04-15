//
//  AppDelegate+message.h
//  HexagonDemo
//
//  Created by JuneLee on 2020/2/27.
//  Copyright © 2020 JuneLee. All rights reserved.
//

#import "AppDelegate.h"
#import <Firebase.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (message)<FIRMessagingDelegate,UNUserNotificationCenterDelegate>

- (void)FCMApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@end

NS_ASSUME_NONNULL_END
