//
//  MainFlowLayout.h
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/17.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    MainLayoutItemImageTypeGray = 0,    //灰色
    MainLayoutItemImageTypeWhite = 1,   //白色
} MainLayoutItemImageType;

@interface MainLayoutItem : NSObject

/** 图片类型 */
@property (nonatomic, assign) MainLayoutItemImageType itemType;
/** 是否可点击 */
@property (nonatomic, assign) BOOL enabled;
/** 可点击下标 */
@property (nonatomic, assign) int index;
@end

NS_ASSUME_NONNULL_BEGIN

@interface MainFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, assign) int indexCount;

@property (nonatomic, strong) NSMutableArray<MainLayoutItem*> *itemArray;

- (int)getItemCount;

- (CGSize)collectionViewContentSize;
@end

NS_ASSUME_NONNULL_END
