//
//  CollectionCell.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/16.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "CollectionCell.h"
#import "CustomButton.h"
#import "UIImage+Addition.h"

@interface CollectionCell ()

@property (nonatomic, strong) CustomButton *contentBtn;

@end

@implementation CollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _contentBtn = [CustomButton buttonWithType:(UIButtonTypeCustom)];
        _contentBtn.frame = self.bounds;
        [_contentBtn setBackgroundImage:[UIImage imageNamed:@"content"] forState:(UIControlStateNormal)];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_contentBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        [_contentBtn setDefualtParam];
        [self.contentView addSubview:_contentBtn];
        
    }
    return self;
}

- (void)setItem:(MainLayoutItem *)item {
    _item = item;
    _contentBtn.userInteractionEnabled = item.enabled;
    if (item.itemType == MainLayoutItemImageTypeWhite) {
        [_contentBtn setBackgroundImage:[UIImage imageNamed:@"content"] forState:(UIControlStateNormal)];
    }else {
        [_contentBtn setBackgroundImage:[UIImage imageNamed:@"bg"] forState:(UIControlStateNormal)];
    }
    if (item.enabled) {
        _contentBtn.tag = 100 + item.index;
    }
}

- (void)setContent:(NSString *)content {
    _content = content;
    [_contentBtn setTitle:content forState:(UIControlStateNormal)];
}

- (void)click:(CustomButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:itemWithIndex:)]) {
        [self.delegate cell:self itemWithIndex:(int)button.tag - 100];
    }
}

@end
