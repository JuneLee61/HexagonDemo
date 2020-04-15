//
//  MainSelectCoverView.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/18.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "MainSelectCoverView.h"
#import "CoverDescripView.h"

@interface MainSelectCoverView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) CoverDescripView *descripView;

@end

@implementation MainSelectCoverView

- (instancetype)initWithFrame:(CGRect)frame center:(CGPoint)center {
    
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
        
    self.bgView = [[UIView alloc] initWithFrame:self.bounds];
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self addSubview:self.bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.bgView addGestureRecognizer:tap];
    

    self.contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content2"]];
    self.contentImageView.center = center;
    CGFloat width = self.bounds.size.width / 3.0;
    CGFloat rate = self.contentImageView.image.size.width / self.contentImageView.image.size.height;
    CGFloat height = width / rate;
    self.contentImageView.bounds = CGRectMake(0, 0, width, height);
    [self addSubview:self.contentImageView];
    
    _contentLabel = [[UILabel alloc] initWithFrame:self.contentImageView.frame];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.text = @"";
    [self addSubview:_contentLabel];
    
    CGFloat descripHeight = 180;
    
    self.descripView = [[CoverDescripView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentImageView.frame) - self.contentImageView.bounds.size.height * 0.28, self.bounds.size.width, descripHeight)];
    self.descripView.backgroundColor = [UIColor whiteColor];
    [self insertSubview:self.descripView belowSubview:self.contentImageView];
    self.bounds = CGRectMake(0, 0, self.bounds.size.width, CGRectGetMaxY(self.descripView.frame));
    
    return self;
}

- (void)setContent:(NSString *)content {
    _content = content;
    _contentLabel.text = content;
}

- (void)dismiss{
    if (self.delegate && [self.delegate respondsToSelector:@selector(coverViewDismiss)]) {
        [self.delegate coverViewDismiss];
    }
    [self removeFromSuperview];
}

@end
