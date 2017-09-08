//
//  NSMutableAttributedString+CH.h
//  
//
//  Created by 陈聪豪 on 16/4/18.
//  Copyright © 2016年 diyuanxinxi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (CH)
/**
 *  返回导航栏标题特殊样式的字符串
 */
+ (NSMutableAttributedString*)attributedWithSubstring:(NSString*)str textColor:(UIColor*)textColor font:(CGFloat)fontSize;

/**
 *  返回带有属性的字符串
 */
+ (NSMutableAttributedString*)attributedWithString:(NSString*)str HighlightedTextSize:(CGFloat)highlightedSize normalTextSize:(CGFloat)normalSize hightedRange:(NSRange)hightedRange normalRange:(NSRange)normalRange  hightedColor:(UIColor*)hightedColor normalColor:(UIColor*)normalColor;

@end
