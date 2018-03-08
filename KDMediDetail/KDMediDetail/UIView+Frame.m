//
//  UIView+Frame.m
//  BaiSi
//
//  Created by mac on 16/6/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "UIView+Frame.h"
#import <objc/runtime.h>

@implementation UIView (Frame)

- (CGFloat)yj_height
{
    return self.frame.size.height;
}

- (void)setYj_height:(CGFloat)yj_height
{
    CGRect frame = self.frame;
    frame.size.height = yj_height;
    self.frame = frame;
}

- (CGFloat)yj_width
{
    return self.frame.size.width;
}

- (void)setYj_width:(CGFloat)yj_width
{
    CGRect frame = self.frame;
    frame.size.width = yj_width;
    self.frame = frame;
}


- (CGFloat)yj_centerX
{
    return self.center.x;
}

- (void)setYj_centerX:(CGFloat)yj_centerX
{
    CGPoint center = self.center;
    center.x = yj_centerX;
    self.center = center;
}

- (CGFloat)yj_centerY
{
    return self.center.y;
}

- (void)setYj_centerY:(CGFloat)yj_centerY
{
    CGPoint center = self.center;
    center.y = yj_centerY;
    self.center = center;
}

- (CGFloat)yj_x
{
    return self.frame.origin.x;
}

- (void)setYj_x:(CGFloat)yj_x
{
    CGRect frame = self.frame;
    frame.origin.x = yj_x;
    self.frame = frame;
}
- (CGFloat)yj_y
{
    return self.frame.origin.y;
}

- (void)setYj_y:(CGFloat)yj_y
{
    CGRect frame = self.frame;
    frame.origin.y = yj_y;
    self.frame = frame;
}

- (void)setYj_size:(CGSize)yj_size{
    CGRect frame = self.frame;
    frame.size = yj_size;
    self.frame = frame;
}

- (CGSize)yj_size{
   return self.frame.size;
}

- (CGFloat)yj_bottom{
    
    return CGRectGetMaxY(self.frame);
}

- (void)setYj_bottom:(CGFloat)yj_bottom{
    
    self.yj_y = yj_bottom - self.yj_height;
}


- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)yj_right {
    return CGRectGetMaxX(self.frame);
}

NSString * const _recognizerScale = @"_recognizerScale";

- (void)setScale:(CGFloat)scale {
    
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerScale), @(scale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

- (CGFloat)scale {
    
    NSNumber *scaleValue = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerScale));
    return scaleValue.floatValue;
}

#pragma mark - Angle.

NSString * const _recognizerAngle = @"_recognizerAngle";

- (void)setAngle:(CGFloat)angle {
    
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerAngle), @(angle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeRotation(angle);
}

- (CGFloat)angle {
    
    NSNumber *angleValue = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerAngle));
    return angleValue.floatValue;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}


@end



@implementation CALayer(Frame)

- (void)setHs_x:(CGFloat)hs_x
{
    CGRect frame = self.frame;
    frame.origin.x = hs_x;
    self.frame = frame;
}

- (CGFloat)hs_x
{
    return self.frame.origin.x;
}

- (void)setHs_y:(CGFloat)hs_y
{
    CGRect frame = self.frame;
    frame.origin.y = hs_y;
    self.frame = frame;
}

- (CGFloat)hs_y
{
    return self.frame.origin.y;
}

- (void)setHs_size:(CGSize)hs_size
{
    CGRect frame = self.frame;
    frame.size = hs_size;
    self.frame = frame;
    
}

- (CGSize)hs_size
{
    return self.frame.size;
}

- (void)setHs_height:(CGFloat)hs_height
{
    CGRect frame = self.frame;
    frame.size.height = hs_height;
    self.frame = frame;
}

- (CGFloat)hs_height
{
    return self.frame.size.height;
}

- (void)setHs_width:(CGFloat)hs_width
{
    CGRect frame = self.frame;
    frame.size.width = hs_width;
    self.frame = frame;
    
}

-(CGFloat)hs_width
{
    return self.frame.size.width;
}



@end


















