//
//  YLFitbitManager+File.m
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/12.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import "YLFitbitManager+File.h"

@implementation YLFitbitManager (File)

#pragma mark - 文件操作
- (NSString *)getDocumentPath {
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return docPath;
}

//获取
- (NSMutableDictionary *)getFitbitData {
    if (self.authorizationDic.allKeys > 0) {
        return self.authorizationDic;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:self.fitbitPath];
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
    }
    return dic;
}

//保存
- (void)saveFitbitData:(NSMutableDictionary *)dic {
    self.authorizationDic = dic;
    [dic writeToFile:self.fitbitPath atomically:YES];
}

//清除
- (void)clearFitbitData {
    self.authorizationDic = nil;
    if ([self.fileManager fileExistsAtPath:self.fitbitPath]) {
        if (self.fitbitPath) {
            NSError *error;
            BOOL deleteFlag = [self.fileManager removeItemAtPath:self.fitbitPath error:&error];
            if (deleteFlag) {
                NSLog(@"删除成功");
            }
        }
    }
}

@end
