//
//  UIImage+CH.h
//  
//
//  Created by 陈聪豪 on 16/4/18.
//  Copyright © 2016年 diyuanxinxi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CH)

/**
 *  防渲染
 */
+(UIImage *)imgRenderingModeWithImgName:(NSString *)ImgStr;

/**
 *  用颜色返回一张图片
 */
+ (UIImage *)createImageWithColor:(UIColor*) color;

@end
