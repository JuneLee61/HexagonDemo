//
//  YLFitbitModel.h
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/12.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//  授权信息model

#import <Foundation/Foundation.h>

#define YLAccessToken         @"access_token"
#define YLExpireIn            @"expires_in"
#define YLRefreshToken        @"refresh_token"
#define YLScope               @"scope"
#define YLTokenType           @"token_type"
#define YLUserId              @"user_id"

#define YLLoginUserId         @"login_user_id"
#define YLUserBirthday        @"user_birthday"
#define YLUserGender          @"user_gender"
#define YLUserHeight          @"user_height"
#define YLAuthorizateSuccess  @"authorizateSuccess"

NS_ASSUME_NONNULL_BEGIN

@interface YLFitbitModel : NSObject

#pragma mark - fitbit信息
//token
@property (nonatomic, strong) NSString *accessToken;
//过期时间
@property (nonatomic, assign) NSInteger expiresIn;
//刷新token
@property (nonatomic, strong) NSString *refreshToken;
//token类型
@property (nonatomic, strong) NSString *tokenType;
//用户Id
@property (nonatomic, strong) NSString *userId;
//
@property (nonatomic, strong) NSString *scope;

#pragma mark - app需要手动记录加入字段
//app登录用户Id
@property (nonatomic, strong) NSString *loginUserId;
//生日 字符串 yyyy-mm-dd
@property (nonatomic, strong) NSString *birthday;
//性别 FEMALE/MALE
@property (nonatomic, strong) NSString *gender;
//身高
@property (nonatomic, strong) NSString *height;
//是否授权成功
@property (nonatomic, assign) int authorizateSuccess;

+ (YLFitbitModel *)modelWithDic:(NSMutableDictionary *)dic;

+ (NSMutableDictionary *)dicWithFitbitModel:(YLFitbitModel *)model;

@end

NS_ASSUME_NONNULL_END
