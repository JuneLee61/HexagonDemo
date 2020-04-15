//
//  UIImage+Addition.h
//  QingNiu
//
//  Created by DonYau on 2017/12/15.
//  Copyright © 2017年 Yolanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)
/** 根据颜色创建Image */
- (UIImage *)createImageWithColor:(UIColor *)color;
/** 缩放image */ 
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

//- (UIColor *)mostColor;
@end
