//
//  YLFitbitManager+Authorization.m
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/12.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import "YLFitbitManager+Authorization.h"
#import "YLFitbitManager+File.h"
#import "YLFitbitNetwork.h"

//撤销权限url
static NSString *revokeUrl = @"https://api.fitbit.com/oauth2/revoke";
//请求tokenurl
static NSString *accessTokenUrl = @"https://api.fitbit.com/oauth2/token";
//获取用户信息
static NSString *getUserInfoUrl = @"https://api.fitbit.com/1/user";
//刷新accessToken
static NSString *refreshAccessTokenUrl = @"https://api.fitbit.com/oauth2/token";
//上传数据
static NSString *uploadDatatUrl = @"https://api.fitbit.com/1/user";


@implementation YLFitbitManager (Authorization)

#pragma mark - ==================== 权限 ====================
/** 用户是否存在过授权信息 */
- (BOOL)isEexistAuthorizationUserWith:(NSString *)userId {
    YLFitbitModel *model = [self getFitbitModel];
    if ([model.loginUserId isEqualToString:userId]) {
        return YES;
    }
    return NO;
}

/** 授权状态 */
- (BOOL)isAuthorizationWithUserId:(NSString *)userId {
    if ([self isEexistAuthorizationUserWith:userId]) {
        YLFitbitModel *model = [self getFitbitModel];
        return model.authorizateSuccess;
    }
    return NO;
}

/** 获取token和用户信息 */
- (void)getAccessToken:(NSString *)code loginUserId:(NSString *)loginUserId gender:(NSString *)gender birthday:(NSString *)birthday height:(float)height {
    
    NSString *args = [NSString stringWithFormat:@"client_id=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",self.clientId,self.redirectRUI,code];
    __weak typeof(self) weakSelf = self;
    [YLFitbitNetwork networkWithServerConfig:^(YLFitbitNetworkConfig * _Nonnull config) {
        config.url = accessTokenUrl;
        config.requestType = YLRequestTypePOST;
        config.authorization = weakSelf.refreshAuthorization;
        config.bodyArgs = args;
    } response:^(NSURLResponse * _Nullable response, NSDictionary * _Nullable results, NSError * _Nullable error) {
        
        if (![results.allKeys containsObject:@"errors"]) {
            NSMutableDictionary *authDic = [weakSelf getFitbitData];
            for (NSString *oneKey in results.allKeys) {
                [authDic setObject:results[oneKey] forKey:oneKey];
            }
            [authDic setObject:loginUserId forKey:YLLoginUserId];
            [authDic setObject:@"1" forKey:YLAuthorizateSuccess];
            [weakSelf saveFitbitData:authDic];
            //同步用户数据
            [weakSelf synUserInfoWithUserId:loginUserId gender:gender birthday:birthday height:height];
//            YLOtherLoggerLog(@"*****获取用户信息已经刷新token成功****\n token = %@",authDic[@"access_token"]);
        }else {
            [weakSelf handleErroeLog:results prefix:@"fitbit授权过程:获取用户信息token"];
        }
        
    }];
}

/** 刷新令牌 */
- (void)refreshAccessTokenWithBlock:(void (^)(BOOL))block {
    YLFitbitModel *model = [self getFitbitModel];
    if (model.refreshToken == nil || [model.refreshToken isEqualToString:@""]) {
        return;
    }
    
    NSString *args = [NSString stringWithFormat:@"client_id=%@&grant_type=refresh_token&redirect_uri=%@&refresh_token=%@",self.clientId,self.redirectRUI,model.refreshToken];

    __weak typeof(self) weakSelf = self;
    [YLFitbitNetwork networkWithServerConfig:^(YLFitbitNetworkConfig * _Nonnull config) {
        config.url = refreshAccessTokenUrl;
        config.requestType = YLRequestTypePOST;
        config.authorization = weakSelf.refreshAuthorization;
        config.bodyArgs = args;
    } response:^(NSURLResponse * _Nullable response, NSDictionary * _Nullable results, NSError * _Nullable error) {

        if (![results.allKeys containsObject:@"errors"]) {
            NSMutableDictionary *authDic = [weakSelf getFitbitData];
            for (NSString *oneKey in results.allKeys) {
                [authDic setObject:results[oneKey] forKey:oneKey];
            }
            [weakSelf saveFitbitData:authDic];
            block(YES);
//            YLOtherLoggerLog(@"\n********刷新令牌成功********\n token = %@",authDic[@"access_token"]);
        }else{
            [weakSelf handleErroeLog:results prefix:@"fitbit授权过程 -- 刷新令牌失败"];
            block(NO);
        }
    }];
}


/** 撤销授权 */
- (void)revokeAuthorizateWithBlock:(void (^)(BOOL))block {
    
    YLFitbitModel *model = [self getFitbitModel];
    if (![self checkUserIsValid:model]) {
        block(NO);
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [YLFitbitNetwork networkWithServerConfig:^(YLFitbitNetworkConfig * _Nonnull config) {
        config.url = revokeUrl;
        config.requestType = YLRequestTypePOST;
        config.authorization = [NSString stringWithFormat:@"%@ %@",model.tokenType,model.accessToken];
        config.bodyArgs = [NSString stringWithFormat:@"token=%@",model.accessToken];
    } response:^(NSURLResponse * _Nullable response, NSDictionary * _Nullable results, NSError * _Nullable error) {
        
        if (![results.allKeys containsObject:@"errors"]) {
//            YLOtherLoggerLog(@"\n********取消授权成功********\n token = %@",model.accessToken);
            block(YES);
        }else {
            [weakSelf handleErroeLog:results prefix:@"fitbit撤销用户授权过程"];
            block(YES);
        }
        [weakSelf resetFitbitDataAuthorizationFlag:0];
        [weakSelf clearFitbitData];
    }];
}

#pragma mark - ==================== 同步用户信息 ====================
- (void)synUserInfoWithUserId:(NSString *)userId gender:(NSString *)gender birthday:(NSString *)birthday height:(float)height {
    [self getUserInfoWithUserId:userId gender:gender birthday:birthday height:height];
}

- (void)getUserInfoWithUserId:(NSString *)userId gender:(NSString *)gender birthday:(NSString *)birthday height:(float)height {
    
    if (![self isEexistAuthorizationUserWith:userId]) {
        return;
    }
    
    YLFitbitModel *model = [self getFitbitModel];
    __weak typeof(self) weakSelf = self;
    [YLFitbitNetwork networkWithServerConfig:^(YLFitbitNetworkConfig * _Nonnull config) {
        config.url = [NSString stringWithFormat:@"%@/%@/profile.json",getUserInfoUrl,model.userId];
        config.requestType = YLRequestTypeGET;
        config.redirectUri = weakSelf.redirectRUI;
        config.authorization = [NSString stringWithFormat:@"%@ %@",model.tokenType,model.accessToken];
    } response:^(NSURLResponse * _Nullable response, NSDictionary * _Nullable results, NSError * _Nullable error) {
        
        if (![results.allKeys containsObject:@"errors"]) {
            NSDictionary *userDic = [results valueForKey:@"user"];
            NSMutableDictionary *unitDic = [NSMutableDictionary dictionary];
            if (userDic[@"weightUnit"]) {
                [unitDic setObject:userDic[@"weightUnit"] forKey:@"weightUnit"];
            }
            if (userDic[@"heightUnit"]) {
                [unitDic setObject:userDic[@"heightUnit"] forKey:@"heightUnit"];
            }
            if (userDic[@"waterUnit"]) {
                [unitDic setObject:userDic[@"waterUnit"] forKey:@"waterUnit"];
            }
            if (userDic[@"glucoseUnit"]) {
                [unitDic setObject:userDic[@"glucoseUnit"] forKey:@"glucoseUnit"];
            }
            
            [weakSelf synUserInfoToFitbitWith:userId gender:gender birthday:birthday height:height unitDic:unitDic];
        }else {
            [weakSelf handleErroeLog:results prefix:@"fitbit授权过程 用户数据同步失败"];
        }
    }];
}

- (void)synUserInfoToFitbitWith:(NSString *)userId gender:(NSString *)gender birthday:(NSString *)birthday height:(float)height unitDic:(NSDictionary *)unitDic {
    if (![self isEexistAuthorizationUserWith:userId]) {
        return;
    }
    
    YLFitbitModel *model = [self getFitbitModel];
    NSString *args = [NSString stringWithFormat:@"gender=%@&birthday=%@&height=%.2f",gender,birthday,height];
    for (NSString *key in unitDic.allKeys) {
        args = [NSString stringWithFormat:@"%@&%@=%@",args,key,unitDic[key]];
    }
    __weak typeof(self) weakSelf = self;
    [YLFitbitNetwork networkWithServerConfig:^(YLFitbitNetworkConfig * _Nonnull config) {
        config.url = [NSString stringWithFormat:@"%@/%@/profile.json",getUserInfoUrl,model.userId];
        config.requestType = YLRequestTypePOST;
        config.redirectUri = weakSelf.redirectRUI;
        config.authorization = [NSString stringWithFormat:@"%@ %@",model.tokenType,model.accessToken];
        config.bodyArgs = args;
    } response:^(NSURLResponse * _Nullable response, NSDictionary * _Nullable results, NSError * _Nullable error) {
        
        if (![results.allKeys containsObject:@"errors"]) {
            NSMutableDictionary *authDic = [self getFitbitData];
            
            [authDic setObject:gender forKey:YLUserGender];
            [authDic setObject:birthday forKey:YLUserBirthday];
            [authDic setObject:[NSString stringWithFormat:@"%.2f",height] forKey:YLUserHeight];
            [weakSelf saveFitbitData:authDic];
            
        }else{
            [weakSelf handleErroeLog:results prefix:@"fitbit授权过程 -- 用户数据同步失败"];
        }
    }];
}

#pragma mark - ==================== 数据 ====================
#pragma mark - 上传食物数据
- (void)synchronizeFoodData:(YLFoodModel *)foodModel callBack:(void (^)(BOOL))callBlock {
    
    NSMutableDictionary *authorizationDic = [self getFitbitData];
    NSString *userId = authorizationDic[YLUserId];
    NSString *accessToken = authorizationDic[YLAccessToken];
    NSString *tokenType = authorizationDic[YLTokenType];
    NSString *areaStr = @"";

    if (userId == nil || [userId isEqualToString:@""]
        || accessToken == nil || [accessToken isEqualToString:@""]
        || tokenType == nil || [tokenType isEqualToString:@""]) {
        return;
    }
    NSString *urlStr = [NSString stringWithFormat:@"https://api.fitbit.com/1/user/%@/foods/log.json",userId];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 15;
    [request setValue:self.redirectRUI forHTTPHeaderField:@"redirect_uri"];
    [request setValue:areaStr forHTTPHeaderField:@"Accept-Language"];
    [request setValue:[NSString stringWithFormat:@"%@ %@",tokenType,accessToken] forHTTPHeaderField:@"Authorization"];
    

    NSMutableString *nurStr = [[NSMutableString alloc] init];
    if (foodModel.calories > 0) {
        [nurStr appendString:[NSString stringWithFormat:@"&calories=%d",foodModel.calories]];
    }
    if (foodModel.carbs > 0) {
        [nurStr appendString:[NSString stringWithFormat:@"&carbs=%d",foodModel.carbs]];
    }
    if (foodModel.fat > 0) {
        [nurStr appendString:[NSString stringWithFormat:@"&fat=%.2f",foodModel.fat]];
    }
    if (foodModel.fiber > 0) {
        [nurStr appendString:[NSString stringWithFormat:@"&fiber=%d",foodModel.fiber]];
    }
    if (foodModel.protein > 0) {
        [nurStr appendString:[NSString stringWithFormat:@"&protein=%d",foodModel.protein]];
    }
    if (foodModel.sodium > 0) {
        [nurStr appendString:[NSString stringWithFormat:@"&sodium=%d",foodModel.sodium]];
    }
    
    NSString *args = [NSString stringWithFormat:@"date=%@&foodName=%@&mealTypeId=%ld&amount=1.0&unitId=304%@",foodModel.date,foodModel.foodName,foodModel.mealType,nurStr];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (![dic.allKeys containsObject:@"errors"]) {
                NSLog(@"同步食物数据成功：%@",dic);
                callBlock(YES);
            }else {
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                if ([httpResponse statusCode] == 401) {
                    NSArray *errors = dic[@"errors"];
                    if (errors.count) {
                        [weakSelf refreshAccessTokenWithBlock:^(BOOL success) {
                            if (success) {
                                [weakSelf synchronizeFoodData:foodModel callBack:^(BOOL successFlag) {
                                    
                                }];
                            }
                        }];
                    }
                }
                callBlock(NO);
            }
        }else {
            callBlock(NO);
        }
    }];
    [sessionDataTask resume];
}

#pragma mark - Private
//时间转换
- (NSString *)stringFromTimeStamp:(long)timeStamp timeZone:(NSString *)timeZone formatter:(NSString *)formatter {
    if (timeStamp >= 50000000000) {
        timeStamp = timeStamp / 1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *fat = [[NSDateFormatter alloc] init];
    [fat setTimeZone:[NSTimeZone systemTimeZone]];
    [fat setDateFormat:formatter];
    
    NSString *dateStr = [fat stringFromDate:date];
    return dateStr;
}

//处理错误log
- (void)handleErroeLog:(NSDictionary *)dic prefix:(NSString *)prefix {
    NSArray *errors = dic[@"errors"];
    if (errors.count) {
//        YLOtherLoggerLog(@"%@ -- 错误：errorType = %@   message = %@",prefix,errors[0][@"errorType"],errors[0][@"message"]);
    }
}

//重置授权标志
- (void)resetFitbitDataAuthorizationFlag:(int)flag {
    NSMutableDictionary *dic = [self getFitbitData];
    [dic setValue:[NSString stringWithFormat:@"%d",flag] forKey:YLAuthorizateSuccess];
    [self saveFitbitData:dic];
}

//判断用户有效性
- (BOOL)checkUserIsValid:(YLFitbitModel *)model {
    if (model.userId == nil || [model.userId isEqualToString:@""] ||
        model.accessToken == nil || [model.accessToken isEqualToString:@""] ||
        model.tokenType == nil || [model.tokenType isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (YLFitbitModel *)getFitbitModel {
    NSMutableDictionary *dic = [self getFitbitData];
    YLFitbitModel *model = [YLFitbitModel modelWithDic:dic];
    return model;
}

@end
