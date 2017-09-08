//
//  NSString+CZNSStringExt.h
//  
//
//  Created by apple on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (CZNSStringExt)

// 对象方法
- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

// 类方法
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(CGFloat)font;


- (CGFloat)widthWithfont:(UIFont *)font;

+ (CGFloat)widthWithText:(NSString *)text Font:(CGFloat )font;

// 传递一个字符串数组，可以渲染不同的颜色，后期有需要可以把 color 和 font 也以数组的形式传递，配对使用
- (NSMutableAttributedString *)setAttributedWithIdentifyStringArray:(NSArray *)identifyStringArray color:(UIColor *)color font:(UIFont *)font;

/**
 计算文本高度方法
 
 @param font 字体大小
 @param width 宽度
 @return 文字高度
 */
- (CGFloat)hs_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

@end
