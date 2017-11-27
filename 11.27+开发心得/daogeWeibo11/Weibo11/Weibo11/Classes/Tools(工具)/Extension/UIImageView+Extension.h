//
//  UIImageView+Extension.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

/// 使用图像名创建图像视图
///
/// @param imageName 图像名称
///
/// @return UIImageView
+ (instancetype)ff_imageViewWithImageName:(NSString *)imageName;

@end
