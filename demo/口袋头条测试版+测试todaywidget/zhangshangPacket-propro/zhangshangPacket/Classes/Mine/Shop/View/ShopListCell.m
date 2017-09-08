//
//  ShopListCell.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/2/24.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "ShopListCell.h"
#define cellStrokeColor CUSTOMCOLORA(200, 200, 200, 1.0)

@interface ShopListCell ()
@property (nonatomic, strong) UIImageView *photoImage;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *integralLab;
@property (nonatomic, strong) UIButton *changeBtn;

@end

@implementation ShopListCell
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
    [self addSubview:self.photoImage];
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10*AdaptiveScale_W);
        make.height.mas_equalTo(60*AdaptiveScale_W);
        make.width.mas_equalTo(70*AdaptiveScale_W);
    }];
    
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoImage);
        make.left.mas_equalTo(self.photoImage.mas_right).offset(5);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(35*AdaptiveScale_W);
    }];
    
    [self addSubview:self.integralLab];
    [self.integralLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.bottom.equalTo(self.photoImage);
        make.width.mas_equalTo([self.integralLab.text widthWithfont:self.integralLab.font]+30*AdaptiveScale_W);
        make.height.equalTo(self.nameLab);
    }];
    
    [self addSubview:self.changeBtn];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.integralLab.mas_top).offset(25*AdaptiveScale_W);
        make.right.mas_equalTo(-13);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(50);
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = CUSTOMCOLOR(245, 245, 245);
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}
-(void)setTheCellDataWithModel:(ItemDetail *)dataModel andPhotoPre:(NSString *)preStr
{
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",preStr,dataModel.img]];
    NSLog(@"%@",imgUrl);
    [self.photoImage sd_setImageWithURL:imgUrl placeholderImage:MyImage(@"login_default")];
    self.nameLab.text = dataModel.name;
    self.integralLab.text = [NSString stringWithFormat:@"价格:%@元",dataModel.cash];
    
}
#pragma mark btnAction
-(void)changeBtnAction
{
    if (self.comeBtnBlock)
    {
        self.comeBtnBlock();
    }
}
#pragma mark get
-(UIImageView *)photoImage
{
    if (_photoImage == nil)
    {
        _photoImage = [[UIImageView alloc]init];
        _photoImage.image = MyImage(@"login_default");
        _photoImage.contentMode = UIViewContentModeScaleAspectFill;
        _photoImage.clipsToBounds = YES;
        _photoImage.layer.borderColor = cellStrokeColor.CGColor;
        _photoImage.layer.masksToBounds = YES;
        _photoImage.layer.borderWidth = 1.f;
    }
    return _photoImage;
}
-(UILabel *)nameLab
{
    if (_nameLab == nil)
    {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"柠檬杯 日本Fasola柠檬杯意塑料..";
        _nameLab.numberOfLines = 0;
        _nameLab.textColor = CUSTOMCOLOR(17, 17, 17);
        _nameLab.font = [UIFont systemFontOfSize:RemindFont(11, 13, 15)];
    }
    return _nameLab;
}
-(UILabel *)integralLab
{
    if (_integralLab == nil)
    {
        _integralLab = [[UILabel alloc]init];
        _integralLab.text = @"价格:2000";
        _integralLab.textColor = CUSTOMCOLOR(251, 82, 82);
        _integralLab.font = [UIFont systemFontOfSize:RemindFont(11, 13, 15)];
    }
    return _integralLab;
}
-(UIButton *)changeBtn
{
    if (_changeBtn == nil)
    {
        _changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _changeBtn.layer.cornerRadius = 4.0;
        _changeBtn.layer.borderColor = CUSTOMCOLOR(49, 144, 232).CGColor;
        _changeBtn.layer.borderWidth = 1.0f;
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
        [_changeBtn setTitle:@"兑换" forState:0];
        [_changeBtn setTitleColor:CUSTOMCOLOR(49, 144, 232) forState:0];
        [_changeBtn addTarget:self action:@selector(changeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}
@end
