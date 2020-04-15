//
//  YLFitbitNetworkConfig.h
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/14.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YLRequestType) {
    YLRequestTypeGET = 1,
    YLRequestTypePOST = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface YLFitbitNetworkConfig : NSObject
/** 请求类型 */
@property (nonatomic, assign) YLRequestType requestType;
/** 请求url */
@property (nonatomic, strong) NSString *url;
/** 请求头 redirectUri */
@property (nonatomic, strong) NSString *redirectUri;
/** 请求头 authorization */
@property (nonatomic, strong) NSString *authorization;
/** 请求头 地区语言 */
@property (nonatomic, strong) NSString *acceptLanguage;
/** httpBody 参数 */
@property (nonatomic, strong) NSString *bodyArgs;
/** 超时时间 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@end

NS_ASSUME_NONNULL_END
