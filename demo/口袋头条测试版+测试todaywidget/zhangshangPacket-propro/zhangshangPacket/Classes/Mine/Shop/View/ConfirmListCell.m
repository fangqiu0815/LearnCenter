//
//  ConfirmListCell.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/1.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "ConfirmListCell.h"
#import "UIImage+CH.h"


@interface ConfirmListCell ()
@property (nonatomic, strong) UILabel *receiveLab;
@property (nonatomic, strong) UILabel *phoneLab;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *defaultBtn;

@end

@implementation ConfirmListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addTheView];
    }
    return self;
}
#pragma mark addTheView
-(void)addTheView
{
    [self addSubview:self.receiveLab];
    [self.receiveLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*AdaptiveScale_W);
        make.top.mas_equalTo(15*AdaptiveScale_W);
        make.right.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(15*AdaptiveScale_W);
    }];
    
    [self addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
        make.centerY.equalTo(self.receiveLab);
        make.height.equalTo(self.receiveLab);
    }];
    
    [self addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.receiveLab.mas_bottom).offset(20*AdaptiveScale_W);
        make.left.equalTo(self.receiveLab);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
        make.height.equalTo(self.receiveLab);
    }];
    
    [self addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*AdaptiveScale_W);
        make.bottom.mas_equalTo(-10*AdaptiveScale_W);
        make.height.mas_equalTo(16*AdaptiveScale_W);
        make.width.mas_equalTo(50);
    }];
    
    [self addSubview:self.defaultBtn];
    [self.defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(Size(40, 40));
        make.centerY.equalTo(self.deleteBtn);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
    }];
    
    UIView *line_T = [[UIView alloc]init];
    line_T.backgroundColor = LineColor;
    [self addSubview:line_T];
    [line_T mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}
-(void)setDataModel:(AddressList*)dataModel
{

    _dataModel = dataModel;

    self.receiveLab.text = [NSString stringWithFormat:@"收货人:%@",_dataModel.name];
    self.phoneLab.text = [NSString stringWithFormat:@"联系电话:%@",_dataModel.phone];
    self.addressLab.text = [NSString stringWithFormat:@"收货地址:%@",_dataModel.address];
    if (_dataModel.isSlected) {
        [self.defaultBtn setImage:[UIImage imgRenderingModeWithImgName:@"close_share_icon"] forState:0];
    }else{
        [self.defaultBtn setImage:[UIImage imgRenderingModeWithImgName:@"btn_unSelect"] forState:0];

    }
}

#pragma mark btnAction
-(void)defaultBtnAction
{
    if (self.SelectedBlock)
    {
        self.SelectedBlock(self.dataModel);
    }
}
-(void)deleteBtnAction
{
    if (self.DeLeteBlock)
    {
        self.DeLeteBlock();
    }
}
#pragma mark get
-(UILabel *)receiveLab
{
    if (_receiveLab == nil)
    {
        _receiveLab = [[UILabel alloc]init];
        _receiveLab.text = @"收货人:王俊杰";
        _receiveLab.textColor = CUSTOMCOLOR(51, 51, 51);
        _receiveLab.font = [UIFont systemFontOfSize:RemindFont(13, 15, 17)];
    }
    return _receiveLab;
}
-(UILabel *)phoneLab
{
    if (_phoneLab == nil)
    {
        _phoneLab = [[UILabel alloc]init];
        _phoneLab.text = @"联系电话:15541826767";
        _phoneLab.textColor = self.receiveLab.textColor;
        _phoneLab.font = self.receiveLab.font;
    }
    return _phoneLab;
}
-(UILabel *)addressLab
{
    if (_addressLab == nil)
    {
        _addressLab = [[UILabel alloc]init];
        _addressLab.text = @"收货地址:福建省泉州市xx区xx街道xx号";
        _addressLab.textColor = self.phoneLab.textColor;
        _addressLab.font = self.phoneLab.font;
    }
    return _addressLab;
}
-(UIButton *)deleteBtn
{
    if (_deleteBtn == nil)
    {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(10, 12, 14)];
        [_deleteBtn setTitle:@"删除" forState:0];
        [_deleteBtn setTitleColor:CUSTOMCOLOR(153, 153, 153) forState:0];
        [_deleteBtn setImage:[UIImage imgRenderingModeWithImgName:@"btn_delete"] forState:0];
        [_deleteBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
-(UIButton *)defaultBtn
{
    if (_defaultBtn == nil)
    {
        _defaultBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _defaultBtn.layer.cornerRadius = 17.0/2;
        _defaultBtn.layer.masksToBounds = YES;
        _defaultBtn.layer.borderColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00].CGColor;
        _defaultBtn.layer.borderWidth = 2.5f;
        [_defaultBtn setImage:[UIImage imgRenderingModeWithImgName:@"btn_Select"] forState:0];
        [_defaultBtn addTarget:self action:@selector(defaultBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
