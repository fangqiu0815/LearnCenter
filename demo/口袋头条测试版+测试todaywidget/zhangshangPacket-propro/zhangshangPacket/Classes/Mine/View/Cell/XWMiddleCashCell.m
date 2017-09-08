//
//  XWMiddleCashCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMiddleCashCell.h"

@implementation XWMiddleCashCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.detailLab];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.rightIcon];
        
        [self setupUI];
        
    }
    return self;
}

- (void)setCellDataWithTitle:(NSString *)titleStr andRightTitle:(NSString *)rightTitle andRightTitleColor:(UIColor *)rightTitleColor andleftImage:(UIImage *)leftImage
{
    self.titleLab.text = titleStr;
    self.detailLab.text = rightTitle;
    self.detailLab.textColor = rightTitleColor;
    self.iconImageView.image = leftImage;
    
}

- (void)setCellDataWithTitle:(NSString *)titleStr andLeftImage:(UIImage *)leftImage andRightTitle:(UIImage *)rightIcon
{
    self.titleLab.text = titleStr;
    self.iconImageView.image = leftImage;
    self.detailLab.hidden = YES;
    self.rightIcon.image = rightIcon;
}


-(void)reloadScoreAction
{
    self.detailLab.text = [NSString stringWithFormat:@"%.2ld",(long)STUserDefaults.ingot];
}

- (void)setupUI
{
    WeakType(self);
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(10);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(25*AdaptiveScale_W);
    }];
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(ScreenW*0.4);
        make.height.mas_equalTo(25*AdaptiveScale_W);
    }];
    
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(25*AdaptiveScale_W);
        make.height.mas_equalTo(25*AdaptiveScale_W);
    }];
    
}

- (UIImageView *)rightIcon
{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]init];
    }
    return _rightIcon;

}


- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}


- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
    }
    return _titleLab;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);

       // _detailLab.text = [NSString stringWithFormat:@"%d",STUserDefaults.ingot];
        _detailLab.textAlignment = NSTextAlignmentRight;
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    }
    return _detailLab;
}


@end
