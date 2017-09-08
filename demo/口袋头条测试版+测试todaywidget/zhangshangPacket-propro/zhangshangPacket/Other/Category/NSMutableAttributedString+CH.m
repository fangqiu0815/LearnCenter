//
//  NSMutableAttributedString+CH.m
//  
//
//  Created by 陈聪豪 on 16/4/18.
//  Copyright © 2016年 diyuanxinxi.com. All rights reserved.
//

#import "NSMutableAttributedString+CH.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString (CH)

/**
 *  返回导航栏标题特殊样式的字符串
 */
+ (NSMutableAttributedString*)attributedWithSubstring:(NSString*)str textColor:(UIColor*)textColor font:(CGFloat)fontSize
{
    
    //创建数字的样式
    NSMutableAttributedString *arrtStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    [arrtStr addAttributes:@{
                             NSFontAttributeName :  [UIFont fontWithName:@"STHeitiSC-Medium" size:fontSize],
                             NSForegroundColorAttributeName: textColor
                             } range:NSMakeRange(0, str.length)];
    
    return arrtStr;
    
}


//返回两种字体
+ (NSMutableAttributedString*)attributedWithString:(NSString*)str HighlightedTextSize:(CGFloat)highlightedSize normalTextSize:(CGFloat)normalSize hightedRange:(NSRange)hightedRange normalRange:(NSRange)normalRange  hightedColor:(UIColor*)hightedColor normalColor:(UIColor*)normalColor
{
    
    //创建数字的样式
    NSMutableAttributedString *arrtStr = [[NSMutableAttributedString alloc] initWithString:str];
    [arrtStr addAttributes:@{
                             NSFontAttributeName :  [UIFont systemFontOfSize:highlightedSize],
                             NSForegroundColorAttributeName: hightedColor                             } range:hightedRange];
    
    //创建文字的样式
    [arrtStr addAttributes:@{
                             NSFontAttributeName :  [UIFont systemFontOfSize:normalSize],
                             NSForegroundColorAttributeName: normalColor                             } range:normalRange];
    
    //返回带有属性样式的字符串
    return arrtStr;
    
}
@end
