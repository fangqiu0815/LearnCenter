//
//  DetailListCell.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/2.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "DetailListCell.h"

@interface DetailListCell ()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;
@end

@implementation DetailListCell
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
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo([self.titleLab.text widthWithfont:self.titleLab.font]);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(5);
    }];
    UIView *line_A = [[UIView alloc]init];
    line_A.backgroundColor = [UIColor colorWithRed:0.66 green:0.73 blue:0.87 alpha:1.00];
    [self addSubview:line_A];
    [line_A mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.equalTo(self.titleLab);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(self.titleLab.mas_left).offset(-10);
    }];
    UIView *line_B = [[UIView alloc]init];
    line_B.backgroundColor = [UIColor colorWithRed:0.66 green:0.73 blue:0.87 alpha:1.00];
    [self addSubview:line_B];
    [line_B mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(10);
        make.centerY.equalTo(self.titleLab);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.detailLab];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10*AdaptiveScale_W);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}
-(void)setTheCellDataWithName:(NSString *)name andTitle:(NSString *)title
{
    self.titleLab.text = title;
//    NSLog(@"name = %@",name);
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:name];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [name length])];
    [self.detailLab setAttributedText:attributedString1];
    [self.detailLab  sizeToFit];
}
#pragma mark btnAction

#pragma mark get
-(UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"商品详情";
        _titleLab.textColor = [UIColor colorWithRed:0.24 green:0.53 blue:0.75 alpha:1.00];
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    }
    return _titleLab;
}
-(UILabel *)detailLab
{
    if (_detailLab == nil)
    {
        _detailLab = [[UILabel alloc]init];
        NSString *tempStr = @"规格:500ml:6.4*23cm\n500ml:6.8*25cm\n材料:塑料\n品牌:Fa So La\n颜色分类:绿色，蓝色，粉色,橙色\n产地:中国";
        _detailLab.text = tempStr;
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:tempStr];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:8];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [tempStr length])];
        [_detailLab setAttributedText:attributedString1];
        [_detailLab sizeToFit];
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
        _detailLab.numberOfLines = 0;
    }
    return _detailLab;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
