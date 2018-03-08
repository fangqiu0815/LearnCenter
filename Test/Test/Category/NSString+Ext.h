//
//  NSString+Ext.h
//  CategoryDemo
//
//  Created by ZJQ on 2017/2/8.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Ext)


/**
 判断字符串是否为空
 
 @return <#return value description#>
 */
- (BOOL)isNull;

/**
 获取字符串的宽度
 
 @param size 尺寸
 @param fontSize 字体大小
 @return <#return value description#>
 */
- (CGFloat)widthWithSize:(CGSize)size fontSize:(CGFloat)fontSize;

/**
 获取字符串高度
 
 @param size 尺寸
 @param fontSize 字体大小
 @return <#return value description#>
 */
- (CGFloat)heightWithSize:(CGSize)size fontSize:(CGFloat)fontSize;

/**
 判断是否是有效的电话号码
 
 @return <#return value description#>
 */
- (BOOL)isValidMobileNumber;

/**
 将时间戳转换为时间
 
 @return <#return value description#>
 */
- (NSString *)stampToDatestring;


/**
 判断是否是有效的邮箱
 
 @return <#return value description#>
 */
- (BOOL)isValidEmail;

/**
 是否是字母和数字的组合
 */
-(BOOL)checkIsHaveNumAndLetter;


@end
