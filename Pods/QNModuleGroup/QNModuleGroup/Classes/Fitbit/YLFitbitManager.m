//
//  YLFitbitManager.m
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/3/11.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//

#import "YLFitbitManager.h"
#import "YLFitbitManager+File.h"
#import "YLFitbitManager+Authorization.h"

static NSString *fitbitFileName = @"fitbitData.plist";

@interface YLFitbitManager ()

@end

@implementation YLFitbitManager

#pragma mark - 初始化
static YLFitbitManager *_fitbitManager;
+ (YLFitbitManager *)sharedFitbitManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _fitbitManager = [[YLFitbitManager alloc] init];
    });
    return _fitbitManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _fitbitManager = [[super allocWithZone:zone] init];
    });
    return _fitbitManager;
}

- (instancetype)init {
    if (self = [super init]) {
        if (_fitbitPath == nil) {
            _fileManager = [[NSFileManager alloc] init];
            NSString *docPath = [self getDocumentPath];
            _fitbitPath = [docPath stringByAppendingPathComponent:fitbitFileName];
        }
    }
    return self;
}



#pragma mark - token & 用户信息





#pragma mark - 同步数据




@end
