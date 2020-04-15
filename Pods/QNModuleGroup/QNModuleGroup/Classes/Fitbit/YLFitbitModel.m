//
//  YLFitbitModel.m
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/12.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import "YLFitbitModel.h"

@implementation YLFitbitModel

+ (YLFitbitModel *)modelWithDic:(NSMutableDictionary *)dic {
    if (dic == nil) {
        return [[YLFitbitModel alloc] init];
    }
    YLFitbitModel *model = [[YLFitbitModel alloc] init];
    model.accessToken = dic[YLAccessToken];
    model.expiresIn = [dic[YLExpireIn] integerValue];
    model.refreshToken = dic[YLRefreshToken];
    model.scope = dic[YLScope];
    model.tokenType = dic[YLTokenType];
    model.userId = dic[YLUserId];

    model.loginUserId = dic[YLLoginUserId];
    model.birthday = dic[YLUserBirthday];
    model.gender = dic[YLUserGender];
    model.height = dic[YLUserHeight];
    model.authorizateSuccess = [dic[YLAuthorizateSuccess] intValue];
    return model;
}

+ (NSMutableDictionary *)dicWithFitbitModel:(YLFitbitModel *)model {
    if (model == nil) {
        return [NSMutableDictionary dictionary];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:model.accessToken forKey:YLAccessToken];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)model.expiresIn] forKey:YLExpireIn];
    [dic setObject:model.refreshToken forKey:YLRefreshToken];
    [dic setObject:model.scope forKey:YLScope];
    [dic setObject:model.tokenType forKey:YLTokenType];
    [dic setObject:model.userId forKey:YLUserId];

    [dic setObject:model.loginUserId forKey:YLLoginUserId];
    [dic setObject:model.birthday forKey:YLUserBirthday];
    [dic setObject:model.gender forKey:YLUserGender];
    [dic setObject:model.height forKey:YLUserHeight];
    [dic setObject:[NSString stringWithFormat:@"%d",model.authorizateSuccess] forKey:YLAuthorizateSuccess];
    return dic;
}
@end
