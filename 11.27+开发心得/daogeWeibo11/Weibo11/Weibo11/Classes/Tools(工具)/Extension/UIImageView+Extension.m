//
//  UIImageView+Extension.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

+ (instancetype)ff_imageViewWithImageName:(NSString *)imageName {
    
    return [[self alloc] initWithImage:[UIImage imageNamed:imageName]];
}

@end
