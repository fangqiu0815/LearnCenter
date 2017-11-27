//
//  UIButton+Extension.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/// 使用图像名创建图像
///
/// @param title 按钮名称(可选)
/// @param imageName 图像名(可选)
/// @param target 监听对象
/// @param action 监听方法(可选)
///
/// @return UIButton
+ (instancetype)ff_buttonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;

/// 创建按钮
///
/// @param title         标题
/// @param color         字体颜色
/// @param fontSize      字号
/// @param imageName     图像
/// @param backImageName 背景图像
///
/// @return UIButton
+ (instancetype)ff_buttonWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize imageName:(NSString *)imageName backImageName:(NSString *)backImageName;

/// 创建按钮
///
/// @param title         标题
/// @param titleColor    标题颜色
/// @param backImageName 背景图像名称
///
/// @return UIButton
+ (instancetype)ff_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backImageName:(NSString *)backImageName;

@end
