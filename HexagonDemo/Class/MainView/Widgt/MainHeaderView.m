//
//  MainHeaderView.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/16.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "MainHeaderView.h"
#import "UIImage+Addition.h"

@interface MainHeaderView ()

@property (nonatomic, strong) UIView *graientView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UIColor *bgColor;
@end

@implementation MainHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
        
    self.userInteractionEnabled = NO;
    _bgColor = [UIColor colorWithRed:0.0/255.0 green:140/255.0 blue:225/255.0 alpha:1.0];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -300, self.bounds.size.width, 300)];
    view.backgroundColor = _bgColor;
    [self addSubview:view];
    
    _bgView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bgView.image = [[UIImage imageNamed:@"headerBg"] createImageWithColor:_bgColor];
    _bgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_bgView];
    [self addGradientlayer];

    return self;
}

- (void)addGradientlayer {
    if (self.gradientLayer == nil) {
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.frame = _bgView.bounds;
        self.gradientLayer.locations  = @[@(0.2), @(1.0)];
    }
    self.gradientLayer.frame = _bgView.bounds;
    CGColorRef startColor = _bgColor.CGColor;
    CGColorRef endColor = [_bgColor colorWithAlphaComponent:0.5].CGColor;
    self.gradientLayer.colors = @[(__bridge id)startColor,(__bridge id)endColor];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    self.bgView.layer.mask = self.gradientLayer;
}

@end
