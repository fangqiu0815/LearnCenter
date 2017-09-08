
//
//  AddressConfirmView.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/11.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "AddressConfirmView.h"

@implementation AddressConfirmView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addTheView];
    }
    return self;
}
#pragma mark addTheView
-(void)addTheView
{
    
    UILabel *receiveLab = [[UILabel alloc]init];
    receiveLab.text = @"收货人：";
    receiveLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    [self addSubview:receiveLab];
    [receiveLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*AdaptiveScale_W);
        make.top.mas_equalTo(25*AdaptiveScale_W);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self addSubview:self.receiveTextF];
    [self.receiveTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(receiveLab);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(receiveLab.mas_right);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
    }];
    
    
    
    UILabel *phoneLab = [[UILabel alloc]init];
    phoneLab.text = @"联系电话：";
    phoneLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    [self addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.receiveTextF.mas_bottom).offset(20*AdaptiveScale_W);
        make.left.equalTo(receiveLab);
        make.height.equalTo(receiveLab);
        make.width.equalTo(receiveLab);
    }];
    
    [self addSubview:self.phoneTextF];
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneLab);
        make.height.equalTo(self.receiveTextF);
        make.left.mas_equalTo(phoneLab.mas_right);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
    }];
    
    
    UILabel *detailLab = [[UILabel alloc]init];
    detailLab.text = @"详细地址：";
    detailLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    [self addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextF.mas_bottom).offset(20*AdaptiveScale_W);
        make.left.equalTo(receiveLab);
        make.height.equalTo(receiveLab);
        make.width.equalTo(receiveLab);
    }];
    
    [self addSubview:self.detailTextF];
    [self.detailTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(detailLab);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(detailLab.mas_right);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
    }];
    
    UIView *line_F = [[UIView alloc]init];
    line_F.backgroundColor = LineColor;
    [self addSubview:line_F];
    [line_F mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailTextF.mas_bottom).offset(10*AdaptiveScale_W);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(13, 15, 17)];
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:MainColor forState:0];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailLab);
        make.right.mas_equalTo(self.mas_centerX).offset(-15*AdaptiveScale_W);
        make.height.mas_equalTo(50*AdaptiveScale_W);
        make.top.mas_equalTo(line_F.mas_bottom);
    }];
    
    UIView *line_S = [[UIView alloc]init];
    line_S.backgroundColor = LineColor;
    [self addSubview:line_S];
    [line_S mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cancleBtn.mas_right);
        make.height.equalTo(cancleBtn);
        make.centerY.equalTo(cancleBtn);
        make.width.mas_equalTo(1);
    }];
    
    UIButton *confirmSaveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmSaveBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(13, 15, 17)];
    [confirmSaveBtn setTitle:@"确认" forState:0];
    [confirmSaveBtn setTitleColor:MainColor forState:0];
    [confirmSaveBtn addTarget:self action:@selector(confirmSaveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:confirmSaveBtn];
    [confirmSaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line_S.mas_right);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(25);
        make.centerY.equalTo(cancleBtn);
    }];
}
#pragma mark btnAction
-(void)confirmSaveBtnAction
{
    if (self.ConfirmBlock)
    {
        self.ConfirmBlock();
    }
}
-(void)cancleBtnAction
{
    if (self.CloseBlock)
    {
        self.CloseBlock();
    }
}

#pragma mark get
-(UILabel *)detailTextF
{
    if (_detailTextF == nil)
    {
        _detailTextF = [[UILabel alloc]init];
        _detailTextF.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
        _detailTextF.numberOfLines = 0;
    }
    return _detailTextF;
}
-(UILabel *)receiveTextF
{
    if (_receiveTextF == nil)
    {
        _receiveTextF = [[UILabel alloc]init];
        _receiveTextF.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    }
    return _receiveTextF;
}
-(UILabel *)phoneTextF
{
    if (_phoneTextF == nil)
    {
        _phoneTextF = [[UILabel alloc]init];
        _phoneTextF.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    }
    return _phoneTextF;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
