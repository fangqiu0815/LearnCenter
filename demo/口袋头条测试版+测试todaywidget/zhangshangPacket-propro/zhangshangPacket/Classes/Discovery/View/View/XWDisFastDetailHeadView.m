//
//  XWDisFastDetailHeadView.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWDisFastDetailHeadView.h"
#import "UIImageView+CornerRadius.h"

@implementation XWDisFastDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.wechatName];
        [self addSubview:self.wechatID];
        [self addSubview:self.contentLab];
        [self addSubview:self.typeAndAccount];
        [self addSubview:self.gotoWechat];
        
        [self addView];

        
    }
    return self;
}

- (void)addView
{
    WeakType(self);
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.top.mas_equalTo(40);
        make.width.mas_equalTo(80*AdaptiveScale_W);
        make.height.mas_equalTo(80*AdaptiveScale_W);
    }];
    
    [_wechatName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    [_wechatID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.top.mas_equalTo(weakself.wechatName.mas_bottom);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    [_typeAndAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.top.mas_equalTo(weakself.wechatID.mas_bottom);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    [_gotoWechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.width.mas_equalTo(ScreenW*0.4);
        make.bottom.mas_equalTo(-10*AdaptiveScale_W);
        make.height.mas_equalTo(30);
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.typeAndAccount.mas_bottom);
        make.left.mas_equalTo(10*AdaptiveScale_W);
        make.right.mas_equalTo(-10*AdaptiveScale_W);
        make.bottom.mas_equalTo(weakself.gotoWechat.mas_top).offset(-5);
    }];
    
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithRoundingRectImageView];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 40*AdaptiveScale_W;
        [_iconImageView zy_attachBorderWidth:2 color:MainBGColor];
        
    }
    return _iconImageView;
}

- (UILabel *)wechatName
{
    if (!_wechatName) {
        _wechatName = [[UILabel alloc]init];
        _wechatName.text = @"口袋头条";
        _wechatName.dk_textColorPicker = DKColorPickerWithColors(MainTextColor,WhiteColor,MainTextColor);
        _wechatName.textAlignment = NSTextAlignmentCenter;
        _wechatName.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
    }
    return _wechatName;
    
}
- (UILabel *)wechatID
{
    if (!_wechatID) {
        _wechatID = [[UILabel alloc]init];
        _wechatID.text = @"口袋头条";
        _wechatID.dk_textColorPicker = DKColorPickerWithColors(MainTextColor,WhiteColor,MainTextColor);
        _wechatID.textAlignment = NSTextAlignmentCenter;
        _wechatID.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        
    }
    return _wechatID;
    
}

- (UILabel *)typeAndAccount
{
    if (!_typeAndAccount) {
        _typeAndAccount = [[UILabel alloc]init];
        _typeAndAccount.text = @"新闻|9999+人订阅";
        _typeAndAccount.dk_textColorPicker = DKColorPickerWithColors(MainTextColor,WhiteColor,MainTextColor);
        _typeAndAccount.textAlignment = NSTextAlignmentCenter;
        _typeAndAccount.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
    }
    return _typeAndAccount;
    
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.text = @"";
        _contentLab.dk_textColorPicker = DKColorPickerWithColors(MainTextColor,WhiteColor,MainTextColor);
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIButton *)gotoWechat
{
    if (!_gotoWechat) {
        _gotoWechat = [[UIButton alloc]init];
        _gotoWechat.layer.cornerRadius = 12;
        _gotoWechat.layer.masksToBounds = YES;
        [_gotoWechat.layer setBorderWidth:1.0];
        _gotoWechat.layer.borderColor = MainRedColor.CGColor;
        _gotoWechat.titleLabel.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        [_gotoWechat dk_setTitleColorPicker:DKColorPickerWithColors(MainRedColor,MainRedColor,MainRedColor) forState:0];
        if (STUserDefaults.ischeck == 1) {
            [_gotoWechat setTitle:@"去搜索" forState:0];
        } else {
            [_gotoWechat setTitle:@"去微信关注" forState:0];
        }
        
    }
    return _gotoWechat;
    
}





@end
