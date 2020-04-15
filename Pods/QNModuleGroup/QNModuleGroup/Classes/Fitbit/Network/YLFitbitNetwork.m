//
//  YLFitbitNetwork.m
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/14.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import "YLFitbitNetwork.h"

@implementation YLFitbitNetwork

+ (void)networkWithServerConfig:(void (^)(YLFitbitNetworkConfig * _Nonnull))configBlock response:(nullable void (^)(NSURLResponse * _Nullable, NSDictionary * _Nullable, NSError * _Nullable))responseBlock {
    
    YLFitbitNetworkConfig *config = [[YLFitbitNetworkConfig alloc] init];
    config.timeoutInterval = 15;
    configBlock(config);
    
    NSURL *url = [NSURL URLWithString:config.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (config.requestType == YLRequestTypeGET) {
        request.HTTPMethod = @"GET";
    }else {
        request.HTTPMethod = @"POST";
    }
    request.timeoutInterval = config.timeoutInterval;
    
    if (config.authorization) {
        [request setValue:config.authorization forHTTPHeaderField:@"Authorization"];
    }
    if (config.redirectUri) {
        [request setValue:config.redirectUri forHTTPHeaderField:@"redirect_uri"];
    }
    if (config.acceptLanguage) {
        [request setValue:config.acceptLanguage forHTTPHeaderField:@"Accept-Language"];
    }
    if (config.bodyArgs) {
        request.HTTPBody = [config.bodyArgs dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            responseBlock(response,dic,error);
        }else {
            responseBlock(response,nil,error);
//            YLOtherLoggerLog(@"%@", [NSString stringWithFormat:@"请求的url：%@ ---- data为nil",config.url]);
        }
    }];
    [sessionTask resume];
}

@end
