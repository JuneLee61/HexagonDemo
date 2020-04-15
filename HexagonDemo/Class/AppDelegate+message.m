//
//  AppDelegate+message.m
//  HexagonDemo
//
//  Created by JuneLee on 2020/2/27.
//  Copyright © 2020 JuneLee. All rights reserved.
//

#import "AppDelegate+message.h"

@implementation AppDelegate (message)

- (void)FCMApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    [FIRMessaging messaging].delegate = self;

    if (@available(iOS 10.0, *)) {
      [UNUserNotificationCenter currentNotificationCenter].delegate = self;
      UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
          UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
      [[UNUserNotificationCenter currentNotificationCenter]
          requestAuthorizationWithOptions:authOptions
          completionHandler:^(BOOL granted, NSError * _Nullable error) {
            // ...
          }];
    } else {
      UIUserNotificationType allNotificationTypes =
      (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
      UIUserNotificationSettings *settings =
      [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
      [application registerUserNotificationSettings:settings];
    }
    
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    [self handleFCMMessage:remoteNotification];
    
    [application registerForRemoteNotifications];
}
- (void)networkDidReceiveMessage:(NSNotification *)notif {
    NSDictionary *userInfo = [notif userInfo];
    [self handleFCMMessage:userInfo];
}

#pragma mark - FIRMessagingDelegate
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    
    NSLog(@"FCM registration token: %@", fcmToken);
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
}

- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    NSLog(@"Received data message: %@", remoteMessage.appData);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //firebase
    [FIRMessaging messaging].APNSToken = deviceToken;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}


//app在后台
//iOS 6及以下
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    [self handleFCMMessage:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
    fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    [self handleFCMMessage:userInfo];

    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark - UNUserNotificationCenterDelegate
// app处在前台收到推送消息执行的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)) {
  NSDictionary *userInfo = notification.request.content.userInfo;

  [self handleFCMMessage:userInfo];

  completionHandler(UNNotificationPresentationOptionNone);
}

// ios 10以后系统，app处在后台，点击通知栏 app执行的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
   
    NSDictionary *userInfo = response.notification.request.content.userInfo;
       
    [self handleFCMMessage:userInfo];

    completionHandler();
}

- (void)handleFCMMessage:(NSDictionary *)userInfo {
    if (userInfo == nil) {
        return;
    }
    NSLog(@"----------------------%@=======================", userInfo);

    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
}

@end
