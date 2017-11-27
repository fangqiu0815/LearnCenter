//
//  UIBarButtonItem+Extension.m
//  新浪微博
//
//  Created by 谢培艺 on 15/12/8.
//  Copyright © 2015年 iphone5solo. All rights reserved.
//

#import "UIBarButtonItem+PYExtension.h"
#import "UIView+PYExtension.h"

@implementation UIBarButtonItem (PYExtension)
+ (instancetype)py_itemWithViewController:(UIViewController *)viewController action:(SEL)action image:(NSString *)image highlightImage:(NSString *)highlightImage
{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置图片
    [item setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (highlightImage.length > 0) {
        [item setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    }
    // 设置监听事件
    [item addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置尺寸
    item.py_size = item.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

+ (instancetype)py_itemWithViewController:(UIViewController *)viewController action:(SEL)action title:(NSString *)title
{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置文字
    [item setTitle:title forState:UIControlStateNormal];
    
    // 默认字体大小
    item.titleLabel.font = [UIFont systemFontOfSize:16];
    
    // 默认按钮小
    item.py_size = CGSizeMake(44, 44);
    
    // 设置监听事件
    [item addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}
@end
