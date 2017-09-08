//
//  UIImage+CH.m
//  
//
//  Created by 陈聪豪 on 16/4/18.
//  Copyright © 2016年 diyuanxinxi.com. All rights reserved.
//

#import "UIImage+CH.h"

@implementation UIImage (CH)

/**
 *  防渲染
 */
+(UIImage *)imgRenderingModeWithImgName:(NSString *)ImgStr
{
    UIImage *img = [UIImage imageNamed:ImgStr];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
