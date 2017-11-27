//
//  HMEmoticonAttachment.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/17.
//  Copyright © 2015年 joyios. All rights reserved.
//

#import "HMEmoticonAttachment.h"
#import "HMEmoticon.h"

@implementation HMEmoticonAttachment

+ (instancetype)attachmentWithEmoticon:(HMEmoticon *)emoticon {
    HMEmoticonAttachment *obj = [[self alloc] init];
    
    obj.emoticon = emoticon;
    
    return obj;
}

- (NSAttributedString *)imageTextWithFont:(UIFont *)font {
    
    // 设置图像和线高
    self.image = [UIImage imageWithContentsOfFile:self.emoticon.imagePath];
    
    CGFloat lineHeight = font.lineHeight;
    self.bounds = CGRectMake(0, -4, lineHeight, lineHeight);
    
    // 生成属性文本
    NSMutableAttributedString *imageText = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:self]];
    
    // 设置字体
    [imageText addAttributes:@{NSFontAttributeName: font} range:NSMakeRange(0, 1)];
    
    return imageText.copy;
}

@end
