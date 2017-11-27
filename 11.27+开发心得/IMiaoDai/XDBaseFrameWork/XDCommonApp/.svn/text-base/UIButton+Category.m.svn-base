//
//  UIButton+Category.m
//  XDCommonApp
//
//  Created by XD-XY on 2/18/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

+(UIButton *)initButton:(CGRect)rect btnImage:(UIImage *)image btnTitle:(NSString *)str titleColor:(UIColor *)color
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setTitle:str forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}

+(UIButton *)initButton:(CGRect)rect btnNorImage:(UIImage *)image btnPressBtn:(UIImage *)press btnTitle:(NSString *)str titleColor:(UIColor *)color
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setTitle:str forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:press forState:UIControlStateHighlighted];
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}

@end
