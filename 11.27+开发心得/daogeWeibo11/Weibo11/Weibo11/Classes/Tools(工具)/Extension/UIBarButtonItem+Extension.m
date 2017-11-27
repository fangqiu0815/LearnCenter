//
//  UIBarButtonItem+Extension.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)ff_barButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton ff_buttonWithTitle:title imageName:imageName target:target action:action];
    
    return [[self alloc] initWithCustomView:button];
}

@end
