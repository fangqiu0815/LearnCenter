//
//  XWMidSquareButton.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMidSquareButton.h"

@implementation XWMidSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
    [self setBackgroundColor:WhiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.yj_y = self.yj_height * 0.10;
    self.imageView.yj_width = self.yj_width * 0.7;
    self.imageView.yj_height = self.imageView.yj_width;
    self.imageView.yj_centerX = self.yj_width * 0.5;
    
    // 调整文字
    self.titleLabel.yj_x = 0;
    self.titleLabel.yj_y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.yj_width = self.yj_width;
    self.titleLabel.yj_height = self.yj_height - self.titleLabel.yj_y;
}

@end
