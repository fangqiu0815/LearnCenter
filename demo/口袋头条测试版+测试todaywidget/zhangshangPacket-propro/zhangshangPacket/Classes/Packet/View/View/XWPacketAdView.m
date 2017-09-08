//
//  XWPacketAdView.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWPacketAdView.h"

@implementation XWPacketAdView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLab];
        [self addSubview:self.detailLab];
        [self addSubview:self.adImageView];
        
        [self addView];
    }
    return self;
}

-(void)signBtnAction
{
    if (self.GotoAdBlock)
    {
        self.GotoAdBlock();
    }
}

- (void)addView
{
    WeakType(self)
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.left.mas_equalTo(weakself).offset(10);
        make.width.mas_equalTo(80*AdaptiveScale_W);
        make.height.mas_equalTo(100*AdaptiveScale_W);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.iconImageView.mas_top);
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(10*AdaptiveScale_W);
        make.right.mas_equalTo(weakself.mas_right).offset(-10*AdaptiveScale_W);
        
    }];
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(10*AdaptiveScale_W);
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(weakself.mas_right).offset(-10*AdaptiveScale_W);
        
    }];
    
    [_adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(10*AdaptiveScale_W);
        make.bottom.mas_equalTo(weakself.iconImageView.mas_bottom);
        make.width.mas_equalTo(20*AdaptiveScale_W);
        make.height.mas_equalTo(8*AdaptiveScale_W);
    }];
    
    
    
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"czym"];
        
    }
    return _iconImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"哈局领导开讲啦处女座选举哦亲离开农村，名字那是的囧文件夹里快乐";
        _nameLab.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.numberOfLines = 0;
        
    }
    return _nameLab;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.text = @"哈局领导开讲啦处女座选举哦亲离开农村，名字那是的囧文件夹里快乐";
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
        _detailLab.textColor = [UIColor blackColor];
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.numberOfLines = 0;
        
    }
    return _detailLab;
}

- (UIImageView *)adImageView
{
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc]init];
        _adImageView.image = MyImage(@"Icon_Information_Advertisement");
        
        
    }
    return _adImageView;
}


@end
