//
//  XWSquareButton.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWSquareButton.h"
#import "XWMeModel.h"
#import "UIButton+FQButton.h"
#import <SDWebImage/UIButton+WebCache.h>
@implementation XWSquareButton

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    //[self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    // 调整图片
    self.imageView.yj_y = self.yj_height * 0.1;
    self.imageView.yj_width = self.yj_width * 0.75;
    self.imageView.yj_height = self.imageView.yj_width;
    self.imageView.yj_centerX = self.yj_width * 0.5;
    
    // 调整文字
    self.titleLabel.yj_x = 0;
    self.titleLabel.yj_y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.yj_width = self.yj_width;
    self.titleLabel.yj_height = self.yj_height - self.titleLabel.yj_y;
}

-(void)setModel:(XWMeModel *)model {
    _model = model;
    
    [self setTitle:model.screen_name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:model.iconImageStr] forState:UIControlStateNormal];
}


@end
