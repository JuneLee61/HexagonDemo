//
//  MainSelectCoverView.h
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/18.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainSelectCoverViewDelegate <NSObject>

- (void)coverViewDismiss;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MainSelectCoverView : UIView

@property (nonatomic, strong) NSString *content;

@property (nonatomic, weak) id<MainSelectCoverViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame center:(CGPoint)center;

@end

NS_ASSUME_NONNULL_END
