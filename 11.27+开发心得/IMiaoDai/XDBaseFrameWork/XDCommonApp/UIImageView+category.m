//
//  UIImageView+category.m
//  NeedYouPower
//
//  Created by XD-XY on 6/27/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "UIImageView+category.h"

@implementation UIImageView (category)

+(id)initImageViewRect:(CGRect )rect andImage:(UIImage *)image andUserInteractionEnabled:(BOOL)enable
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.userInteractionEnabled = enable;
    imageView.image = image;
    return imageView;
}
@end
