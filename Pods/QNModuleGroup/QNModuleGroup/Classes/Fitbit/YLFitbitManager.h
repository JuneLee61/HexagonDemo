//
//  YLFitbitManager.h
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/11.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLFitbitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLFitbitManager : NSObject

#pragma mark - 配置项
@property (nonatomic, strong) NSString *clientId;

@property (nonatomic, strong) NSString *clientSecret;

@property (nonatomic, strong) NSString *refreshAuthorization;

@property (nonatomic, strong) NSString *redirectRUI;

@property (nonatomic, strong) NSString *area;

#pragma mark -
/** 文件操作 */
@property (nonatomic, strong) NSFileManager *fileManager;
/** 保存路径 */
@property (nonatomic, strong) NSString *fitbitPath;
/** 授权保存信息 */
@property (nonatomic,nullable,strong) NSMutableDictionary *authorizationDic;
/** 中断上传标志 */
@property (nonatomic, assign) BOOL breakUpLoadFlag;

+ (YLFitbitManager *)sharedFitbitManager;

@end

NS_ASSUME_NONNULL_END


/*
 fitbit饮食记录文档：https://dev.fitbit.com/build/reference/web-api/food-logging/
 
 */
