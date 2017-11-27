//
//  UIBarButtonItem+Extension.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/// 使用图像名称创建自定义视图的 UIBarButtonItem
///
/// @param title 按钮名称(可选)
/// @param imageName 图像名(可选)
/// @param target 监听对象
/// @param action 监听方法(可选)
///
/// @return UIBarButtonItem
+ (instancetype)ff_barButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;

@end
