//
//  CollectionCell.h
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/16.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class CollectionCell;

@protocol CollectionCellDelegate <NSObject>

- (void)cell:(CollectionCell *)cell itemWithIndex:(int)index;

@end

@interface CollectionCell : UICollectionViewCell

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) MainLayoutItem *item;

@property (nonatomic, weak) id<CollectionCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
