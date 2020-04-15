//
//  YLFitbitManager+File.h
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/12.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import "YLFitbitManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLFitbitManager (File)

/**
 获取沙盒路径

 @return 沙盒路径
 */
- (NSString *)getDocumentPath;


/**
 获取fitbit保存的数据

 @return 数据字典
 */
- (NSMutableDictionary *)getFitbitData;


/**
 保存fitbit数据信息

 @param dic 数据字典
 */
- (void)saveFitbitData:(NSMutableDictionary *)dic;

/**
 清除fitbit数据信息
 */
- (void)clearFitbitData;

@end

NS_ASSUME_NONNULL_END
