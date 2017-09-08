//
//  DetailHeadView.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/2.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "DetailHeadView.h"

@interface DetailHeadView ()


@end

@implementation DetailHeadView
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
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(IPHONE_W-13*2);
    }];
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoImage.mas_bottom).offset(15*AdaptiveScale_W);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo([self.titleLab.text sizeOfTextWithMaxSize:Size(IPHONE_W-13*2, MAXFLOAT) font:self.titleLab.font].height+5);
    }];
    
    [self addSubview:self.integralLab];
    [self.integralLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(15*AdaptiveScale_W);
        make.width.mas_equalTo([self.integralLab.text widthWithfont:self.integralLab.font]+30*AdaptiveScale_W);
        make.height.mas_equalTo(15);
    }];
    
    [self addSubview:self.repertoryLab];
    [self.repertoryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.equalTo(self.integralLab);
        make.height.equalTo(self.integralLab);
        make.width.mas_equalTo([self.repertoryLab.text widthWithfont:self.integralLab.font]);
    }];
}
#pragma mark btnAction

#pragma mark get
-(UIImageView *)photoImage
{
    if (_photoImage == nil)
    {
        _photoImage = [[UIImageView alloc]init];
        _photoImage.image = MyImage(@"222222");
        _photoImage.contentMode = UIViewContentModeScaleAspectFill;
        _photoImage.clipsToBounds = YES;
    }
    return _photoImage;
}
-(UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"柠檬杯 日本Fasola柠檬杯意塑料携水杯随手生随行杯运动水瓶杯子";
        _titleLab.textColor = CUSTOMCOLOR(17, 17, 17);
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(13, 15, 17)];
        _titleLab.numberOfLines = 0;
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
-(UILabel *)repertoryLab
{
    if (_repertoryLab == nil)
    {
        _repertoryLab = [[UILabel alloc]init];
        _repertoryLab.text = @"库存:1000";
        _repertoryLab.textColor = CUSTOMCOLOR(153, 153, 153);
        _repertoryLab.font = [UIFont systemFontOfSize:RemindFont(11, 13, 15)];
    }
    return _repertoryLab;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
