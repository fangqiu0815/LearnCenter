//
//  UIButton+Category.h
//  XDCommonApp
//
//  Created by XD-XY on 2/18/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)
+(UIButton *)initButton:(CGRect )rect btnImage:(UIImage *)image btnTitle:(NSString *)str titleColor:(UIColor *)color;
+(UIButton *)initButton:(CGRect ) rect btnNorImage:(UIImage *)image btnPressBtn:(UIImage *)press btnTitle:(NSString *)str titleColor:(UIColor *)color;
@end
