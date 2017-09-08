//
//  XWDisHeaderView.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWDisHeaderView.h"
#import "UIImageView+CornerRadius.h"

@implementation XWDisHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];

        [self.leftView addSubview:self.titleLabLeft];
        [self.leftView addSubview:self.ablumImgLeft];
        [self.rightView addSubview:self.titleLabRight];
        [self.rightView addSubview:self.ablumImgRight];
        [self addSubview:self.centerView];
        [self addSubview:self.bottomView];
        [self addView];
        
    }
    return self;
}

- (void)addView
{
    WeakType(self);
    
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(8*AdaptiveScale_W);
    }];
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.right.mas_equalTo(weakself.centerView.mas_left);
        make.bottom.mas_equalTo(weakself.bottomView.mas_top);
    }];
    
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.left.mas_equalTo(weakself.centerView.mas_right);
        make.bottom.mas_equalTo(weakself.bottomView.mas_top);
    }];
    
    [_ablumImgLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.leftView.mas_centerY);
        make.left.mas_equalTo(weakself.leftView.mas_left).offset(30*AdaptiveScale_W);
        make.width.mas_equalTo(45*AdaptiveScale_W);
        make.height.mas_equalTo(45*AdaptiveScale_W);
    }];
    
    [_titleLabLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.leftView.mas_centerY);
        make.left.mas_equalTo(weakself.ablumImgLeft.mas_right).offset(5);
        make.width.mas_equalTo(80*AdaptiveScale_W);
        make.height.mas_equalTo(35*AdaptiveScale_W);
    }];
    
    [_ablumImgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.rightView.mas_centerY);
        make.left.mas_equalTo(weakself.rightView.mas_left).offset(30*AdaptiveScale_W);
        make.width.mas_equalTo(45*AdaptiveScale_W);
        make.height.mas_equalTo(45*AdaptiveScale_W);
    }];
    
    [_titleLabRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.rightView.mas_centerY);
        make.left.mas_equalTo(weakself.ablumImgRight.mas_right).offset(5);
        make.width.mas_equalTo(80*AdaptiveScale_W);
        make.height.mas_equalTo(35*AdaptiveScale_W);
    }];
    
    
}

- (UIView *)leftView
{
    if (!_leftView) {
        _leftView = [[UIView alloc]init];
        _leftView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainNaviColor,MainRedColor);

    }
    return _leftView;
}

- (UIView *)rightView
{
    if (!_rightView) {
        _rightView = [[UIView alloc]init];
        _rightView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainNaviColor,MainRedColor);
    }
    return _rightView;
}


- (UILabel *)titleLabLeft
{
    if (!_titleLabLeft) {
        _titleLabLeft = [[UILabel alloc]init];
        _titleLabLeft.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _titleLabLeft.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _titleLabLeft.textAlignment = NSTextAlignmentLeft;
        
    }
    return _titleLabLeft;
}

- (UIImageView *)ablumImgLeft
{
    if (!_ablumImgLeft) {
        _ablumImgLeft = [[UIImageView alloc]initWithRoundingRectImageView];
        _ablumImgLeft.layer.masksToBounds = YES;
        _ablumImgLeft.layer.cornerRadius = 45/2*AdaptiveScale_W;
        
    }
    return _ablumImgLeft;
}

- (UILabel *)titleLabRight
{
    if (!_titleLabRight) {
        _titleLabRight = [[UILabel alloc]init];
        _titleLabRight.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _titleLabRight.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _titleLabRight.textAlignment = NSTextAlignmentLeft;
        
    }
    return _titleLabRight;
    
}

- (UIImageView *)ablumImgRight
{
    if (!_ablumImgRight) {
        _ablumImgRight = [[UIImageView alloc]initWithRoundingRectImageView];
        _ablumImgRight.layer.masksToBounds = YES;
        _ablumImgRight.layer.cornerRadius = 45/2*AdaptiveScale_W;
        
    }
    return _ablumImgRight;
    
}

- (UIView *)centerView
{
    if (!_centerView) {
        _centerView = [[UIView alloc]init];
        _centerView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainBGColor,MainRedColor);
    }
    return _centerView;
    
}

- (UIView *)bottomView
{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainBGColor,MainRedColor);
    }
    return _bottomView;

}




@end
