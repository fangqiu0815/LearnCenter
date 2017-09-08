//
//  UIImage+Original.m
//  KDNews
//
//  Created by apple on 2017/3/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIImage+Original.h"

@implementation UIImage (Original)

// 传递一个图片的名称进来，返回一个不渲染的图片
+ (UIImage *)imageNamedWithRenderOriginal:(NSString *)imageName
{
    // 返回一个不渲染的图片
    return [[self imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
