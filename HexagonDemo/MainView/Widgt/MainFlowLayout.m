//
//  MainFlowLayout.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/17.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "MainFlowLayout.h"
#import "CollectionCell.h"
#import "MainView.h"

/** 第一行左边所占比例 */
static const CGFloat firstRate = (1 - 68.0 / 304.0);
/** 第二行左边所占比例 */
static const CGFloat secondRate = (1 - 228.0 / 304.0);

@implementation MainLayoutItem
@end

@interface MainFlowLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArray; ///< 所有的cell的布局
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@end


@implementation MainFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.attrsArray = [NSMutableArray array];
    self.itemArray = [NSMutableArray array];

    _itemWidth = self.itemSize.width;
    _itemHeight = self.itemSize.height;
    
    for (int section = 0; section < self.collectionView.numberOfSections; section ++) {
        NSInteger rowNumber = [self.collectionView numberOfItemsInSection:0];
        for (int row = 0; row < rowNumber; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:0];
            [self.attrsArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    [self updateItemArray];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    MainLayoutItem *item = [[MainLayoutItem alloc] init];
    
    CGFloat x;
    CGFloat y = 0;
    
    int row = indexPath.row / 9.0;
    int virtual_number = (int)indexPath.row;
    if (row > 0) {
        virtual_number = (int)indexPath.row - row * 9;
    }
    
    if (virtual_number / 5 == 0 ) {
        x = (virtual_number % 5) * (_itemWidth + _margin) - _itemWidth * firstRate + _margin / 3.0;
        y = (row * 2 + virtual_number / 5 ) * (_itemHeight + _margin) * 0.8 + 64;
    }else {
        x = (virtual_number % 5) * (_itemWidth + _margin) - _itemWidth * secondRate + _margin / 3.0;
        y = (row * 2 + virtual_number / 5 ) * (_itemHeight + _margin) * 0.8 + 64;
    }
    attrs.frame = CGRectMake(x, y, _itemWidth, _itemHeight);
    
    if (CGRectGetMinX(attrs.frame) < 0 || CGRectGetMaxX(attrs.frame) > self.collectionView.bounds.size.width) {
        item.itemType = MainLayoutItemImageTypeGray;
        item.enabled = NO;
    }else {
        item.itemType = MainLayoutItemImageTypeWhite;
        item.enabled = YES;
    }
    if (indexPath.row < 18) {
        item.enabled = NO;
    }
    [_itemArray addObject:item];
    return attrs;
}

- (CGSize)collectionViewContentSize {
    
    UICollectionViewLayoutAttributes *attrs = self.attrsArray.lastObject;
    CGRect rect = attrs.frame;
    
    MainView *view = (MainView *)self.collectionView.superview;
    if (view.isShow) {
        return CGSizeMake(self.collectionView.bounds.size.width, CGRectGetMaxY(rect) + view.offset);
    }else {
        return CGSizeMake(self.collectionView.bounds.size.width, CGRectGetMaxY(rect));
    }
}

- (int)getItemCount {
    
    int remainder = self.indexCount % 5;
    int dataNumber = 18 + (self.indexCount / 5 * 9);
    if (remainder > 0) {
        dataNumber = dataNumber + (remainder > 3 ? 9 : 5);
    }
    return dataNumber;
}

- (void)updateItemArray {
   
    int index = 0;
    for (MainLayoutItem *item in _itemArray) {
        if (item.enabled && index < self.indexCount) {
            item.index = index;
            item.enabled = YES;
            index ++;
        }else {
            item.index = -1;
            item.enabled = NO;
        }
    }
}
@end
