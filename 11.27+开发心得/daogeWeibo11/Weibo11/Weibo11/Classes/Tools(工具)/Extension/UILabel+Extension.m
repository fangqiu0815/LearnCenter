//
//  UILabel+Extension.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)ff_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize {
    return [self ff_labelWithTitle:title color:color fontSize:fontSize alignment:NSTextAlignmentCenter];
}

+ (instancetype)ff_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    label.textAlignment = alignment;
//    label.preferredMaxLayoutWidth = 
    
    [label sizeToFit];
    
    return label;
}

@end
