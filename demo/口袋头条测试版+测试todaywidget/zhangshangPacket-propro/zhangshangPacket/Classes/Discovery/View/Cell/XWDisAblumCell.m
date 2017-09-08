//
//  XWDisAblumCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWDisAblumCell.h"

@implementation XWDisAblumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.whiteView];
        [self.whiteView addSubview:self.iconImageView];
        [self.whiteView addSubview:self.titleLab];
        [self.whiteView addSubview:self.timeLab];
//        [self.whiteView addSubview:self.detailLab];
        
        self.contentView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainBGColor,MainRedColor);
        
        [self addView];
    }
    return self;
}

- (void)setDataModel:(DisBestAblumModel *)dataModel
{
    _dataModel = dataModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.piclist[0]] placeholderImage:MyImage(@"bg_default_long")];
    
    self.titleLab.text = dataModel.label;
//    self.detailLab.text = [NSString stringWithFormat:@"%@:%@",dataModel.label,dataModel.labeldesc];
    self.timeLab.text = dataModel.date;
    [self.contentView layoutIfNeeded];

}

- (void)addView{
    WeakType(self);
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself).offset(8);
        make.right.mas_equalTo(weakself).offset(-8);
        make.bottom.mas_equalTo(weakself).offset(-5);
        make.top.mas_equalTo(weakself).offset(5);

    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.whiteView.mas_top).offset(5);
        make.left.mas_equalTo(weakself.whiteView.mas_left).offset(5);
        make.right.mas_equalTo(weakself.whiteView.mas_right).offset(-5);
        make.height.mas_equalTo(160*AdaptiveScale_W);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.whiteView.mas_left).offset(5);
        make.bottom.mas_equalTo(weakself.whiteView.mas_bottom).offset(-5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(100);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(8);
        make.left.mas_equalTo(weakself.whiteView.mas_left).offset(5);
        make.right.mas_equalTo(weakself.whiteView.mas_right).offset(-5);
//        make.height.mas_equalTo(50);
    }];
    
//    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(weakself.titleLab.mas_bottom).offset(5);
//        make.left.mas_equalTo(weakself.whiteView.mas_left).offset(5);
//        make.right.mas_equalTo(weakself.whiteView.mas_right).offset(-5);
//        make.bottom.mas_equalTo(weakself.whiteView.mas_bottom).offset(-5);
//    }];
    
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += self.iconImageView.yj_height;
    totalHeight += [self.titleLab sizeThatFits:size].height;
    totalHeight += self.timeLab.yj_height;
    totalHeight += 4*8*AdaptiveScale_W;
    return CGSizeMake(size.width, totalHeight);
}


- (UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc]init];
        _whiteView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightBolangBGColor,MainRedColor);
    }
    return _whiteView;

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
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    
    }
    return _titleLab;
}

- (UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = MainTextColor;
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = [UIFont systemFontOfSize:RemindFont(13, 14, 15)];
    }
    return _timeLab;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.textColor = MainTextColor;
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.numberOfLines = 3;
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(13, 14, 15)];
    }
    return _detailLab;

}



@end
