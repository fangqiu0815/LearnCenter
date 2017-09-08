//
//  XWTaskHeaderCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTaskHeaderCell.h"

@implementation XWTaskHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLab];
        
        [self addView];
        
    }
    return self;
}

#pragma mark btnAction

//-(void)signBtnAction
//{
//    if (self.ClickMasterBlock)
//    {
//        self.ClickMasterBlock();
//    }
//}


- (void)addView
{
    WeakType(self);
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.centerY.mas_equalTo(weakself);
        make.width.height.mas_equalTo(30*AdaptiveScale_W);
        
    }];

    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(15*AdaptiveScale_W);
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(weakself.mas_right).offset(-15*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakself);
        make.height.mas_equalTo(1);
    }];
    
   
    
}

- (void)setCellDataWithImage:(UIImage *)image andTitle:(NSString *)titleStr andTitleColor:(UIColor *)titleColor{
    self.titleLab.text = titleStr;
    self.titleLab.textColor = titleColor;
    self.iconImageView.image = image;
    
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(16, 18, 20)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        
    }
    return _titleLab;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}



- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = MainMidLineColor;
        
    }
    return _lineView;
}


@end
