//
//  MainView.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/16.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "MainView.h"
#import "CollectionCell.h"
#import "MainHeaderView.h"
#import "MainFlowLayout.h"
#import "UIImage+Addition.h"
#import "MainSelectCoverView.h"


/** 多边形的宽高比例 */
static const CGFloat sizeRate = 304.0 / 337.0;
/** 间隙比例 */
static const CGFloat marginRate = 22.0 / 1125.0;
/** 头部高度比例 */
static const CGFloat headerImageRate = 1125.0 / 1340.0;
/** 一行显示的个数 */
static const CGFloat ColumnCount = 3.5;                   

@interface MainView ()<UICollectionViewDelegate,UICollectionViewDataSource,CollectionCellDelegate,MainSelectCoverViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MainHeaderView *headerView;
@property (nonatomic, strong) MainSelectCoverView *coverView;
@property (nonatomic, strong) MainFlowLayout *layout;

@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    UIColor *color = [UIColor colorWithRed:0.0/255.0 green:140/255.0 blue:225/255.0 alpha:1.0];
    self.backgroundColor = color;
    
    self.margin = self.bounds.size.width * marginRate;
    CGFloat width = (self.bounds.size.width - _margin * (floorf(ColumnCount) + 1)) / ColumnCount;
    self.itemHeight = width / sizeRate;
    
    self.layout = [[MainFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.itemSize = CGSizeMake(width, _itemHeight);
    _layout.margin = _margin;
    _layout.indexCount = (int)self.dataArray.count;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:246/255.0 green:249/255.0 blue:250/255.0 alpha:1.0];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.bounces = NO;
    [_collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_collectionView];
    
    [_collectionView addSubview:self.headerView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_layout getItemCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    MainLayoutItem *item = _layout.itemArray[indexPath.row];
    cell.item = item;

    if (item.enabled) {
        cell.content = self.dataArray[item.index];
        cell.delegate = self;
    }else {
        cell.content = @"";
    }

    return cell;
}

#pragma mark - cellDelegate
- (void)cell:(CollectionCell *)cell itemWithIndex:(int)index {
    CGPoint center = cell.center;
//    if (fabs(CGRectGetMaxY(cell.frame) - _collectionView.contentSize.height) < 150) {
////        self.offset =
//    }else {
//        self.isShow = NO;
//    }
    self.coverView = [[MainSelectCoverView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _collectionView.contentSize.height) center:center];
    self.coverView.delegate = self;
    self.coverView.content = self.dataArray[index];
    [_collectionView addSubview:self.coverView];
    
    CGFloat diff = self.coverView.frame.size.height - _collectionView.contentSize.height;
    if (diff > 0) {
        self.isShow = YES;
        self.offset = diff;
    }else{
        self.isShow = NO;
        self.offset = 0;
    }
    self.coverView.frame = CGRectMake(0, 0, self.bounds.size.width, _collectionView.contentSize.height);
    [_layout collectionViewContentSize];
    [_collectionView reloadData];
}

#pragma mark - MainSelectCoverViewDelegate
- (void)coverViewDismiss {
    self.isShow = NO;
    self.offset = 0;
    [_layout collectionViewContentSize];
    [_collectionView reloadData];
}

#pragma mark - getter
- (MainHeaderView *)headerView {
    if (!_headerView) {
        CGFloat height = self.bounds.size.width / headerImageRate;
        _headerView = [[MainHeaderView alloc] initWithFrame:CGRectMake(0, - _itemHeight * 0.52 + _margin + 64 , self.bounds.size.width, height)];
    }
    return _headerView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 14; i ++) {
            [_dataArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _dataArray;
}
@end
