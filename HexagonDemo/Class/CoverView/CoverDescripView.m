//
//  CoverDescripView.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/24.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "CoverDescripView.h"

#pragma mark - 系统配置相关
#define iPhoneX (CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size))
#define iPhoneX_R (CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size))
#define iPhoneX_MAX (CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size))

#define SystemVersion  [NSString stringWithFormat:@"%.1f",[[UIDevice currentDevice].systemVersion doubleValue]]
#define AppVersion [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]
#define AppId @"ETEKCITY"
#define KPlatForm @"iphone"

#pragma mark - 屏幕的大小
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#define kNavigationBarHeight (iPhoneX ? 88 : 64)
#define kTabBarHeight (iPhoneX ? 83 : 49)
#define kTabBarSafetyZoneHeight (iPhoneX ? 34 : 0)
#define kNavigationBarStatusHeight (iPhoneX ? 44 : 20)

#define kGlobalFont(s) [UIFont systemFontOfSize:s]
#define kGetColor(r, g, b,a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:(a * 1.0)]

@interface YLCircleCodeView : UIImageView

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation YLCircleCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.shapeLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.shapeLayer];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(1.5, 1.5, 12, 12) cornerRadius:6];
        self.shapeLayer.path = path.CGPath;
        self.shapeLayer.lineWidth = 3.0f;
        self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    }
    return self;
}
@end


@interface CoverDescripView ()
{
    CGFloat y;
    CGFloat startX;
    CGFloat levelItemWidth;
    CGFloat cellHeight;
}
/** 临界值*/
@property (nonatomic, strong) NSMutableArray<UILabel *> *edgeLabelPool;
/** 区间段*/
@property (nonatomic, strong) NSMutableArray<UIView *> *levelViewPool;
/** 区间段标题*/
@property (nonatomic, strong) NSMutableArray<UILabel *> *levelTitleLabelPool;
/** 箭头*/
@property (nonatomic, strong) YLCircleCodeView *circleCodeView;
/** 描述*/
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation CoverDescripView

- (NSMutableArray<UILabel *> *)edgeLabelPool {
    if (_edgeLabelPool == nil) {
        _edgeLabelPool = [NSMutableArray<UILabel *> array];
    }
    return _edgeLabelPool;
}

- (NSMutableArray<UIView *> *)levelViewPool {
    if (_levelViewPool == nil) {
        _levelViewPool = [NSMutableArray<UIView *> array];
        for (int i = 0; i < 7; i ++) {
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            [_levelViewPool addObject:view];
        }
    }
    return _levelViewPool;
}

- (NSMutableArray<UILabel *> *)levelTitleLabelPool {
    if (_levelTitleLabelPool == nil) {
        _levelTitleLabelPool = [ NSMutableArray<UILabel *> array];
    }
    return _levelTitleLabelPool;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    
        if (self.circleCodeView == nil) {
            self.circleCodeView = [[YLCircleCodeView alloc] init];
            [self addSubview:self.circleCodeView];
        }
        
        if (self.detailLabel == nil) {
            self.detailLabel = [[UILabel alloc] init];
            self.detailLabel.numberOfLines = 0;
            [self addSubview:self.detailLabel];
        }
        [self reloadDataUI];
    }
    return self;
}

- (void)reloadDataUI {
    
    //方法里面代码量太多了
    for (UILabel *item in self.edgeLabelPool) {
        item.hidden = YES;
    }
    for (UIView *item in self.levelViewPool) {
        item.hidden = YES;
    }
    for (UILabel *item in self.levelTitleLabelPool) {
        item.hidden = YES;
    }
    
    self.circleCodeView.hidden = YES;
    self.circleCodeView.image = nil;
    self.circleCodeView.shapeLayer.hidden = YES;
    
    NSArray *edgeValues = @[@"12",@"23",@"34",@"45",@"56"];
    NSArray *colors = @[[UIColor blueColor],[UIColor orangeColor],[UIColor cyanColor],[UIColor redColor]];

    y = 45;
    levelItemWidth = (kScreenWidth - 40) / ((CGFloat)colors.count);
    startX = 20;
    cellHeight = 180;
    
    if (edgeValues.count <= 0) {
        self.detailLabel.frame = CGRectMake(15, y, kScreenWidth - 30, cellHeight - y);
        self.detailLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"这是一个描述这是一个描述这是一个描述"];
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
        [self bringSubviewToFront:self.circleCodeView];
        return;
    }
    [self handleEdgeValus];
    [self handleColors];
    [self handleNames];
    [self handleData];

}

- (void)handleEdgeValus {
    NSArray *edgeValues = @[@"12",@"23",@"34",@"45",@"56"];
    for (int i = 0; i < edgeValues.count - 2; i++) {
        if (self.edgeLabelPool.count <= i) {
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [self.edgeLabelPool addObject:label];
        }
        UILabel *label = self.edgeLabelPool[i];
        label.frame = CGRectMake(startX + levelItemWidth / 2.0 + levelItemWidth * i, y, levelItemWidth, 30);
        label.hidden = NO;
        label.font = kGlobalFont(11);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kGetColor(102, 102, 102, 1.0);
        label.text = edgeValues[i + 1];
    }
    y = y + 30;
}

- (void)handleColors {
    NSArray *colors = @[[UIColor blueColor],[UIColor orangeColor],[UIColor cyanColor],[UIColor redColor]];
    for (int i = 0; i < colors.count; i ++) {
        if (self.levelViewPool.count <= i) {
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            [self.levelViewPool addObject:view];
        }
        UIView *levelView = self.levelViewPool[i];
        levelView.hidden = NO;
        levelView.frame = CGRectMake(startX + levelItemWidth * i, y, levelItemWidth, 7);
        levelView.backgroundColor = colors[i];
        if (i == 0 || i == colors.count - 1) {

            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: levelView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(3.5,3.5)];
            if (i == colors.count - 1) {
                maskPath = [UIBezierPath bezierPathWithRoundedRect: levelView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(3.5,3.5)];
            }
            //创建 layer
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = levelView.bounds;
            //赋值
            maskLayer.path = maskPath.CGPath;
            levelView.layer.mask = maskLayer;
        }

    }
    y = y + 7;
}

- (void)handleNames {
    NSArray *names = @[@"偏低",@"正常",@"标准",@"偏高"];
    for (int i = 0; i < names.count; i ++) {
        if (self.levelTitleLabelPool.count <= i) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            [self addSubview:label];
            [self.levelTitleLabelPool addObject:label];
        }
        UILabel *label = self.levelTitleLabelPool[i];
        label.frame = CGRectMake(startX + levelItemWidth * i, y, levelItemWidth, 30);
        label.hidden = NO;
        label.font = kGlobalFont(9);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kGetColor(102, 102, 102, 1.0);
        label.text = names[i];
    }
    y = y + 30;
}

- (void)handleData {
    
    NSArray *edgeValues = @[@"12",@"23",@"34",@"45",@"56"];
    NSArray *colors = @[[UIColor blueColor],[UIColor orangeColor],[UIColor cyanColor],[UIColor redColor]];
    NSArray *names = @[@"偏低",@"正常",@"标准",@"偏高"];
    NSString *currentName = @"正常";

    //坐标
    NSInteger index = [names indexOfObject:currentName];
    self.circleCodeView.image = nil;
    self.circleCodeView.shapeLayer.hidden = NO;
    self.circleCodeView.shapeLayer.strokeColor = ((UIColor *)colors[index]).CGColor;
    self.circleCodeView.hidden = NO;

    CGFloat value = 25;
    CGFloat min = [edgeValues[0] floatValue];
    CGFloat max = [edgeValues[edgeValues.count - 1] floatValue];
    if (value > min && value < max) {
        CGFloat levelNum = [edgeValues[index + 1] floatValue] - [edgeValues[index] floatValue];
        CGFloat diff = (value - [edgeValues[index] floatValue]) / levelNum;
        CGFloat x = 20 + levelItemWidth * index + levelItemWidth * diff - 7.5;
        self.circleCodeView.frame = CGRectMake(x, 71, 15, 15);
    }else {
        self.circleCodeView.frame = CGRectMake(20 + levelItemWidth * index + levelItemWidth / 2.0 - 7.5, 71, 15, 15);
    }
    self.detailLabel.frame = CGRectMake(15, y, kScreenWidth - 30, cellHeight - y);
    self.detailLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"这是一个描述这是一个描述这是一个描述"];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self bringSubviewToFront:self.circleCodeView];
}
@end
