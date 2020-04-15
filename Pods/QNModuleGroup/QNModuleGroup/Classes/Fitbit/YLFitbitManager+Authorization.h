//
//  YLFitbitManager+Authorization.h
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/12.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import "YLFitbitManager.h"
#import "YLFoodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLFitbitManager (Authorization)


/**
 用户是否存在过授权信息

 @param userId 用户id
 @return 存在/不存在 （YES/NO）
 */
- (BOOL)isEexistAuthorizationUserWith:(NSString *)userId;


/**
 授权状态

 @param userId 用户id
 @return 授权/未授权 （YES/NO）
 */
- (BOOL)isAuthorizationWithUserId:(NSString *)userId;


/**
 授权成功后获取accessToken和用户信息

 @param code code
 @param loginUserId app登录用户的userId
 @param gender 男 MALE 女 FEMALE
 @param birthday yyyy-MM-dd
 @param height 身高（cm）
 */
- (void)getAccessToken:(NSString *)code loginUserId:(NSString *)loginUserId gender:(NSString *)gender birthday:(NSString *)birthday height:(float)height;


/**
 刷新token

 @param block 刷新回调
 */
- (void)refreshAccessTokenWithBlock:(void (^)(BOOL success))block;


/**
 同步用户信息

 @param userId app登录的userId
 @param gender 男 MALE 女 FEMALE
 @param birthday yyyy-MM-dd
 @param height 身高（cm）
 */
- (void)synUserInfoWithUserId:(NSString *)userId gender:(NSString *)gender birthday:(NSString *)birthday height:(float)height;
/**
 撤销授权状态

 @param block 成功回调
 */
- (void)revokeAuthorizateWithBlock:(void (^)(BOOL success))block;


- (void)synchronizeFoodData:(YLFoodModel *)foodModel callBack:(void (^)(BOOL successFlag))callBlock;

@end

NS_ASSUME_NONNULL_END
