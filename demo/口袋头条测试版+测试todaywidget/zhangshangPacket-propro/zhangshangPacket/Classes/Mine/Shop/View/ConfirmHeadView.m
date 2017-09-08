//
//  ConfirmHeadView.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/1.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "ConfirmHeadView.h"

@interface ConfirmHeadView ()

@end

@implementation ConfirmHeadView
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
    UILabel *goodsLab = [[UILabel alloc]init];
    goodsLab.text = @"商品";
    goodsLab.textColor = CUSTOMCOLOR(17, 17, 17);
    goodsLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    
    [self addSubview:goodsLab];
    [goodsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*AdaptiveScale_W);
        make.top.mas_equalTo(38*AdaptiveScale_W);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo([goodsLab.text widthWithfont:goodsLab.font]);
    }];
    
    [self addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goodsLab.mas_right).offset(38*AdaptiveScale_W);
        make.centerY.equalTo(goodsLab);
        make.size.mas_equalTo(Size(70*AdaptiveScale_W, 70*AdaptiveScale_W));
    }];
    
    CGFloat titleMaxWidth = IPHONE_W-13*AdaptiveScale_W*2-70*AdaptiveScale_W-[goodsLab.text widthWithfont:goodsLab.font]-10*AdaptiveScale_W-38*AdaptiveScale_W;
    CGFloat titleHeight = [self.titleLab.text sizeOfTextWithMaxSize:Size(titleMaxWidth, MAXFLOAT) font:self.titleLab.font].height+5;
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.photoImageView.mas_right).offset(10*AdaptiveScale_W);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
        make.height.mas_equalTo(titleHeight+20*AdaptiveScale_W);
        make.top.equalTo(self.photoImageView);
    }];
    
    [self addSubview:self.integralLab];
    [self.integralLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo([self.titleLab.text widthWithfont:self.titleLab.font]);
        make.bottom.equalTo(self.photoImageView).offset(5*AdaptiveScale_W);
    }];
    
    UIView *line_F = [[UIView alloc]init];
    line_F.backgroundColor = LineColor;
    [self addSubview:line_F];
    [line_F mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.photoImageView.mas_bottom).offset(10*AdaptiveScale_W);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *numberLab = [[UILabel alloc]init];
    numberLab.text = @"数量";
    numberLab.textColor = CUSTOMCOLOR(17, 17, 17);
    numberLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    [self addSubview:numberLab];
    [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_F.mas_bottom).offset(13.5*AdaptiveScale_W);
        make.width.equalTo(goodsLab);
        make.height.equalTo(goodsLab);
        make.left.equalTo(goodsLab);
    }];
    
    [self addSubview:self.numberButton];
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13*AdaptiveScale_W);
        make.centerY.mas_equalTo(numberLab);
        make.size.mas_equalTo(Size(110, 30));
    }];
    
    UIView *line_S = [[UIView alloc]init];
    line_S.backgroundColor = LineColor;
    [self addSubview:line_S];
    [line_S mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(numberLab.mas_bottom).offset(13.5*AdaptiveScale_W);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *allNumber = [[UILabel alloc]init];
    allNumber.textColor = CUSTOMCOLOR(17, 17, 17);
    allNumber.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    allNumber.text = @"总价格";
    [self addSubview:allNumber];
    [allNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_S.mas_bottom).offset(13.5*AdaptiveScale_W);
        make.left.equalTo(numberLab);
        make.width.mas_equalTo([allNumber.text widthWithfont:allNumber.font]);
        make.height.equalTo(numberLab);
    }];
    
    
    
    [self addSubview:self.allIntegralLab];
    [self.allIntegralLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13*AdaptiveScale_W);
        make.centerY.equalTo(allNumber);
        make.width.mas_equalTo([self.allIntegralLab.text widthWithfont:self.allIntegralLab.font]);
        make.height.equalTo(numberLab);
    }];
    
    [self addSubview:self.balanceLab];
    [self.balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.allIntegralLab.mas_bottom).offset(4);
        make.width.mas_equalTo(ScreenW*0.4);
        make.height.mas_equalTo(15);
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
#pragma mark btnAction
-(void)setMaxNumber:(NSInteger)maxNumber
{
    self.numberButton.maxValue = maxNumber;

}
#pragma mark get
-(UIImageView *)photoImageView
{
    if (_photoImageView == nil)
    {
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.image = MyImage(@"login_default");
        _photoImageView.clipsToBounds = YES;
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _photoImageView;
}
-(UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"柠檬杯 日本Fasola柠檬杯意塑料携水杯随手生随行杯运动水瓶杯子";
        _titleLab.numberOfLines = 3;
        _titleLab.textColor = CUSTOMCOLOR(17, 17, 17);
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(11, 13, 15)];
    }
    return _titleLab;
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
-(PPNumberButton *)numberButton
{
    if (_numberButton == nil)
    {
        _numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(100, 100, 110, 30)];
        [_numberButton setBackgroundColor:MainBGColor];
        _numberButton.shakeAnimation = YES;
        _numberButton.minValue = 1;
        _numberButton.maxValue = MAXFLOAT;
        _numberButton.inputFieldFont = RemindFont(11,13,15);
        _numberButton.increaseTitle = @"＋";
        _numberButton.decreaseTitle = @"－";
        WeakType(self);
        _numberButton.numberBlock = ^(NSString *num){
            if (weakself.NumberChangeBlock)
            {
                weakself.NumberChangeBlock(num);
            }
        };
    }
    return _numberButton;
}

-(UILabel *)allIntegralLab
{
    if (_allIntegralLab == nil)
    {
        _allIntegralLab = [[UILabel alloc]init];
        _allIntegralLab.text = @"2000";
        _allIntegralLab.textColor = CUSTOMCOLOR(17, 17, 17);
        _allIntegralLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
        _allIntegralLab.textAlignment = NSTextAlignmentRight;
    }
    return _allIntegralLab;
}
-(UILabel *)balanceLab
{
    if (_balanceLab == nil)
    {
        _balanceLab = [[UILabel alloc]init];
        _balanceLab.textAlignment = NSTextAlignmentRight;
        _balanceLab.textColor = CUSTOMCOLOR(85, 85, 85);
        _balanceLab.font = [UIFont systemFontOfSize:RemindFont(10, 12, 14)];
    }
    return _balanceLab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
