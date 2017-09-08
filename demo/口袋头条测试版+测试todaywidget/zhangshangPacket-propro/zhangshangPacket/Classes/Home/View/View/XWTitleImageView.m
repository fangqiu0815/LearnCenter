//
//  XWTitleImageView.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTitleImageView.h"

@implementation XWTitleImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLab];
        [self addSubview:self.imageBtn];
        
        [self addView];
    }
    return self;
}

- (void)addView
{
    WeakType(self)
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself);
        make.centerY.mas_equalTo(weakself);
        make.width.mas_equalTo([weakself.titleLab.text widthWithfont:weakself.titleLab.font]);
        
    }];
    
    [_imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself);
        make.centerY.mas_equalTo(weakself);
        make.width.height.mas_equalTo(20);
        
    }];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        
    }
    return _titleLab;
}

- (UIButton *)imageBtn
{
    if (!_imageBtn ) {
        _imageBtn = [[UIButton alloc]init];
//        _imageBtn.badge.text = @"99+";
        [_imageBtn setBadgeBGColor:MainRedColor];
        [_imageBtn setBadgeTextColor:WhiteColor];
        _imageBtn.shouldAnimateBadge = YES;
        _imageBtn.shouldHideBadgeAtZero = YES;

        
        
    }
    return _imageBtn;
}

@end
