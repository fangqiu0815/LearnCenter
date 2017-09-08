//
//  UIImageView+YJImageExtension.m
//  BaiSi
//
//  Created by 高方秋 on 16/9/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "UIImageView+YJImageExtension.h"
#import "UIImage+YJCircleImage.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (YJImageExtension)

-(void)setCircleHeader:(NSString *)url {
    UIImage *placeholder = [[UIImage imageNamed:@"bg_user_nouser"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[[UIImage imageNamed:@"bg_user_nouser"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image?[image circleImage] : placeholder;
    }];
}

@end
