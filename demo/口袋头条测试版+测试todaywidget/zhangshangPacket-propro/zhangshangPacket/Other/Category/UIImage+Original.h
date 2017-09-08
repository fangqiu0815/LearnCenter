//
//  UIImage+Original.h
//  KDNews
//
//  Created by apple on 2017/3/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Original)

// 传递一个图片的名称进来，返回一个不渲染的图片
+ (UIImage *)imageNamedWithRenderOriginal:(NSString *)imageName;

/**
 根据颜色和尺寸生成图片
 
 @param color 颜色
 @param size 输出图片大小
 @return 图片大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


@end
