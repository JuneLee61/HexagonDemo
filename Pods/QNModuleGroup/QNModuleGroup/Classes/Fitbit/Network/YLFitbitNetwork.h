//
//  YLFitbitNetwork.h
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/14.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLFitbitNetworkConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLFitbitNetwork : NSObject


/**
 请求网络

 @param configBlock 请求参数配置block
 @param responseBlock 返回参数block
 */
+ (void)networkWithServerConfig:(void (^)(YLFitbitNetworkConfig *config))configBlock response:(nullable void (^)(NSURLResponse * _Nullable response,NSDictionary *_Nullable results, NSError *_Nullable error))responseBlock;

@end

NS_ASSUME_NONNULL_END
