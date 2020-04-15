//
//  AppDelegate.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/16.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <YLFitbitHeader.h>
#import "AppDelegate+message.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self FCMApplication:application didFinishLaunchingWithOptions:launchOptions];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 跳转本应用
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSString *fitbitRedirectUri = @"test://fitbit";
    if (fitbitRedirectUri == nil || fitbitRedirectUri.length == 0) {
        return  YES;
    }
    NSString *scheme = [fitbitRedirectUri componentsSeparatedByString:@":"].firstObject;
    if (![[url.scheme lowercaseString] hasPrefix:scheme]) {
        return YES;
    }
    
//    if ([[url.scheme lowercaseString] hasPrefix:scheme]) {
    NSString *relativeString = url.relativeString;
    if (![relativeString containsString:@"error_description"] && ![relativeString containsString:@"error=access_denied"]) {
        NSString *query = url.query;
        NSArray *urlAll = [query componentsSeparatedByString:@"="];
        if (urlAll.count == 2) {
            NSString *genderStr = @"FEMALE";
            
            [[YLFitbitManager sharedFitbitManager] getAccessToken:urlAll.lastObject loginUserId:@"123456" gender:genderStr birthday:@"1994-12-1" height:158];
            //                [[FitbitTool sharedFitbitTool] requestAccessToken:urlAll.lastObject withAuthorizationUserId:loginUser.userId withGender:genderStr withBirthday:loginUser.birthday withHeight:loginUser.height];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FitBitAuthorizationNotication" object:nil userInfo:@{@"AuthorizationStatus":@"1"}];
    }
//    }
    return YES;
}
@end
