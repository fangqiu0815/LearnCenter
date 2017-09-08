//
//  UIBarButtonItem+Item.m
//  BaiSi
//
//  Created by mac on 16/6/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
// 把重复的代码抽取成方法
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action
{
    // 设置导航条右侧的按钮
    UIButton *btn = [[UIButton alloc] init];
    // 设置普通图片
    [btn setImage:image forState:UIControlStateNormal];
    // 设置高亮图片
    [btn setImage:highImage forState:UIControlStateHighlighted];
    // 添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    // 让系统计算一下按钮的尺寸
    [btn sizeToFit];
    // 问题:UIBarButton点击范围过大
    // 解决：在按钮的外面包装一层UIView
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = btn.bounds;
    [btnView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnView];
    return item;
}

+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image selImage:(UIImage *)selImage addTarget:(id)target action:(SEL)action;
{
    // 设置导航条右侧的按钮
    UIButton *btn = [[UIButton alloc] init];
    // 设置普通图片
    [btn setImage:image forState:UIControlStateNormal];
    // 设置选中图片
    [btn setImage:selImage forState:UIControlStateSelected];
    // 添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    // 让系统计算一下按钮的尺寸
    [btn sizeToFit];
    // 问题:UIBarButton点击范围过大
    // 解决：在按钮的外面包装一层UIView
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = btn.bounds;
    [btnView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnView];
    return item;
}


/**
 
 */
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage title:(NSString *)title addTarget:(id)target action:(SEL)action
{
    // 设置导航条右侧的按钮
    UIButton *btn = [[UIButton alloc] init];
    // 设置按钮标题
    [btn setTitle:title forState:UIControlStateNormal];
    // 设置默认状态字体颜色
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 设置高亮状态字体颜色
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    // 设置普通图片
    [btn setImage:image forState:UIControlStateNormal];
    // 设置高亮图片
    [btn setImage:highImage forState:UIControlStateHighlighted];
    // 添加点击事件
    [btn addTarget:target action:action
    forControlEvents:UIControlEventTouchDown];
    // 让系统计算一下按钮的尺寸
    [btn sizeToFit];
    // 问题:UIBarButton点击范围过大
    // 解决：在按钮的外面包装一层UIView
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = btn.bounds;
    [btnView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnView];
    return item;
}


@end
