//
//  CustomButton.m
//  HexagonDemo
//
//  Created by JuneLee on 2019/4/23.
//  Copyright © 2019 JuneLee. All rights reserved.
//

#import "CustomButton.h"

/** 不响应的alpha最小值 */
static CGFloat minNotResponseAlpha = 0.1;

@interface CustomButton ()
/** 记录上一次点击的点 */
@property (nonatomic, assign) CGPoint previousTouchPoint;
/** 记录上一次点击的点的响应值 */
@property (nonatomic, assign) BOOL previousTouchHitTestResponse;
/** 按钮的图片 */
@property (nonatomic, strong) UIImage *contentImage;
/** 按钮的背景图片 */
@property (nonatomic, strong) UIImage *backgroundImage;

@end

@implementation CustomButton


/** 初始化默认值 */
- (void)setDefualtParam {
    _previousTouchPoint = CGPointMake(-9999, -99);
    _contentImage = self.currentImage;
    _backgroundImage = self.currentBackgroundImage;
}

#pragma mark - 重写点击方法
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL superResult = [super pointInside:point withEvent:event];
    if (!superResult) {
        return superResult;
    }
    
    if (point.x == _previousTouchPoint.x && point.y == _previousTouchPoint.y) {
        return self.previousTouchHitTestResponse;
    }
    self.previousTouchPoint = point;
    
    BOOL response = [self shouldResponseAtPoint:point image:_contentImage] || [self shouldResponseAtPoint:point image:_backgroundImage];
    self.previousTouchHitTestResponse = response;
    return response;
}

/** 该点是否可响应 */
- (BOOL)shouldResponseAtPoint:(CGPoint)point image:(UIImage *)image {
    
    UIImageView *contentView = self.imageView;
    if (!image || !contentView) {
        return NO;
    }
    
    CGPoint imagePoint = CGPointMake(point.x - contentView.frame.origin.x, point.y - contentView.frame.origin.y);
    imagePoint = CGPointApplyAffineTransform(imagePoint, [self viewToImageTransform:contentView]);
    UIColor *pixeColor = [self imageColorAtPoint:imagePoint image:image];
    CGFloat alpla = 0.0;
    if (pixeColor) {
        [pixeColor getRed:nil green:nil blue:nil alpha:&alpla];
    }
    return alpla >= minNotResponseAlpha;
}

- (CGAffineTransform)viewToImageTransform:(UIImageView *)imageView {
    
    UIImage *currentImage = imageView.image;
    if (!currentImage) {
        return CGAffineTransformIdentity;
    }
    
    UIViewContentMode contentMode = imageView.contentMode;
    if (imageView.frame.size.width == 0 || imageView.frame.size.height == 0
        || (contentMode != UIViewContentModeScaleToFill && contentMode != UIViewContentModeScaleAspectFit && contentMode != UIViewContentModeScaleAspectFill)) {
        return CGAffineTransformIdentity;
    }
    
    CGFloat ratioWidth = currentImage.size.width / imageView.frame.size.width;
    CGFloat ratioHeight = currentImage.size.height / imageView.frame.size.height;
    
    BOOL imageWiderThanView = ratioWidth > ratioHeight;
    if (contentMode == UIViewContentModeScaleAspectFit || contentMode == UIViewContentModeScaleAspectFill) {
        
        CGFloat ratio = ((imageWiderThanView && contentMode == UIViewContentModeScaleAspectFit) || (!imageWiderThanView && contentMode == UIViewContentModeScaleAspectFill)) ? ratioWidth:ratioHeight;
        CGFloat xOffset = (currentImage.size.width - (imageView.frame.size.width * ratio)) * 0.5;
        CGFloat yOffset = (currentImage.size.height - (imageView.frame.size.height * ratio)) * 0.5;
        return CGAffineTransformConcat(CGAffineTransformMakeScale(ratio, ratio), CGAffineTransformMakeTranslation(xOffset, yOffset));
        
    }
    return CGAffineTransformMakeScale(ratioWidth, ratioHeight);
}

#pragma mark - 获取该点的颜色值
- (UIColor *)imageColorAtPoint:(CGPoint)point image:(UIImage *)image {
    
    //获取在实际原图上该点的值
    size_t pixelsWide = CGImageGetWidth(image.CGImage);
    size_t pixelsHigh = CGImageGetHeight(image.CGImage);
    CGFloat rateWidth = self.bounds.size.width / pixelsWide;
    CGFloat rateHeight = self.bounds.size.height / pixelsHigh;
    CGPoint realPoint = CGPointMake(point.x / rateWidth, point.y / rateHeight);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bitmapBytesPerRow = (int)(pixelsWide * 4);
    UInt32 bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Big;

   CGContextRef context = CGBitmapContextCreate(nil,  pixelsWide, pixelsHigh,  8, bitmapBytesPerRow, colorSpace, bitmapInfo);
    unsigned char* data = CGBitmapContextGetData(context);
    
    if (!context || !data || !image.CGImage) {
        return nil;
    }

    CGRect rect = CGRectMake(0, 0, pixelsWide, pixelsHigh);
    CGContextDrawImage(context, rect, image.CGImage);
    
    int offset = 4 * ((pixelsWide * round(realPoint.y)) + round(realPoint.x));
    int alpha =  data[offset] / 255.0;
    int red = data[offset + 1] / 255.0;
    int green = data[offset + 2] / 255.0;
    int blue = data[offset + 3] / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
