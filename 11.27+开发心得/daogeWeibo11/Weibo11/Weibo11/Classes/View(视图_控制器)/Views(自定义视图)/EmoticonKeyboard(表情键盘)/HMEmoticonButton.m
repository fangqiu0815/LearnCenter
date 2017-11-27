//
//  HMEmoticonButton.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/16.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMEmoticonButton.h"
#import "HMEmoticon.h"

@implementation HMEmoticonButton

#pragma mark - 设置数据
- (void)setEmoticon:(HMEmoticon *)emoticon {
    _emoticon = emoticon;
    
    self.hidden = NO;
    
    // 设置按钮图片
    [self setImage:[UIImage imageWithContentsOfFile:emoticon.imagePath] forState:UIControlStateNormal];
    
    // 设置 emoji 文字
    [self setTitle:emoticon.emoji forState:UIControlStateNormal];
}

- (void)setIsDeleteButton:(BOOL)isDeleteButton {
    _isDeleteButton = isDeleteButton;
    
    // 提示：由于父视图增加了长按手势，按钮的高亮状态不会被激活了
    [self setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateNormal];
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置 emoji 字符串的字体大小和图片尺寸一致
        self.titleLabel.font = [UIFont systemFontOfSize:32];
    }
    return self;
}

@end
