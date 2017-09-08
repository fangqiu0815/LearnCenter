//
//  XWMineImageView.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineImageView.h"
#import "UIImageView+CornerRadius.h"

@interface XWMineImageView ()


@end

@implementation XWMineImageView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.boLangImgView];
        self.boLangImgView.userInteractionEnabled = YES;
        [self.boLangImgView addSubview:self.iconImageView];
        [self.boLangImgView addSubview:self.nameLab];
        [self.boLangImgView addSubview:self.setBtn];
        
        [self addView];
    }
    return self;
}

- (UIImageView *)boLangImgView
{
    if (!_boLangImgView) {
        _boLangImgView = [[UIImageView alloc]init];
        _boLangImgView.userInteractionEnabled = YES;
        _boLangImgView.dk_imagePicker = DKImagePickerWithNames(@"bg_user",@"bg_user_night",@"bg_user");
    }
    return _boLangImgView;
}

- (void)addView
{
    
    WeakType(self);
    [_boLangImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [_setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself).offset(20);
        make.right.mas_equalTo(weakself).offset(-8*AdaptiveScale_W);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself).offset(40);
        make.centerX.mas_equalTo(weakself.mas_centerX);
        make.width.height.mas_equalTo(70*AdaptiveScale_W);
        
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(weakself.mas_centerX);
        // make.height.mas_equalTo(30*AdaptiveScale_W);
        make.width.mas_equalTo([weakself.nameLab.text widthWithfont:weakself.nameLab.font] + 20*AdaptiveScale_W);
    }];
    
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithRoundingRectImageView];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:STUserDefaults.img] placeholderImage:MyImage(@"bg_user_nouser")];
        [_iconImageView zy_attachBorderWidth:5 color:WhiteColor];
        
    }
    return _iconImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc]init];
        if (STUserDefaults.ischeck == 1) {
            _nameLab.text = [NSString stringWithFormat:@"%@",STUserDefaults.name];
        } else {
            _nameLab.text = [NSString stringWithFormat:@"%@  (ID:%@)",STUserDefaults.name,STUserDefaults.uid];
        }
        
        _nameLab.textColor = WhiteColor;
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(18, 19, 20)];
        
        
    }
    return _nameLab;
}

- (UIButton *)setBtn
{
    if (!_setBtn) {
        _setBtn = [[UIButton alloc]init];
        [_setBtn setImage:MyImage(@"icon_user_setting") forState:0];
    }
    return _setBtn;

}





@end
