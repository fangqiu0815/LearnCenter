//
//  XWSearchListCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWSearchListCell.h"

@implementation XWSearchListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.authorLab];
        [self.contentView addSubview:self.detailLab];
        [self.contentView addSubview:self.lblTitle];
        [self.contentView addSubview:self.iconImageView];
        
        
        [self addTheView];
    }
    return self;
    
}

- (void)setDataModel:(SearchPostListModel *)dataModel
{
    _dataModel = dataModel;
    JLLog(@"datamodel---%@",dataModel.imgsrc);
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.imgsrc] placeholderImage:MyImage(@"bg_default_long")];
    
    self.lblTitle.text = dataModel.title;
    if (STUserDefaults.ischeck == 1) {
        self.authorLab.text = @"网络";
    } else {
        self.authorLab.text = dataModel.author;

    }
    
}

- (void)addTheView
{
    WeakType(self);
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.width.mas_equalTo(110*AdaptiveScale_W);
        make.height.mas_equalTo(80*AdaptiveScale_W);
        make.right.mas_equalTo(weakself).offset(-15*AdaptiveScale_W);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.iconImageView.mas_top);
        make.left.mas_equalTo(weakself).offset(10*AdaptiveScale_W);
        make.right.mas_equalTo(weakself.iconImageView.mas_left).offset(-10*AdaptiveScale_W);;
        
    }];
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.lblTitle.mas_bottom).offset(5);
        make.left.mas_equalTo(weakself).offset(10*AdaptiveScale_W);
        make.right.mas_equalTo(weakself.iconImageView.mas_left).offset(10*AdaptiveScale_W);;
        make.height.mas_equalTo(40*AdaptiveScale_W);
        
    }];
    
    [_authorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.lblTitle.mas_bottom).offset(5);
        make.left.mas_equalTo(weakself).offset(10*AdaptiveScale_W);
        make.width.mas_equalTo(80*AdaptiveScale_W);
        make.height.mas_equalTo(35*AdaptiveScale_W);
    }];
    
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.bottom.mas_equalTo(weakself);
        make.height.mas_equalTo(1);
    }];
    
}


- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainBGColor,MainRedColor);
    }
    return _lineView;
    
}

- (UIImageView *)iconImageView
{
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc]init];
        //_titleLab.text = @"";
        _lblTitle.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.font = [ToolFontFit getFontSizeWithType:TGFontTypeFour size:RemindFont(16, 17, 18)];
        _lblTitle.numberOfLines = 2;
        [_lblTitle sizeToFit];
        _lblTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _lblTitle;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        //_titleLab.text = @"";
        _detailLab.dk_textColorPicker = DKColorPickerWithColors(MainTextColor,MainTextColor,MainTextColor);
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    }
    return _detailLab;
}

- (UILabel *)authorLab
{
    if (!_authorLab) {
        _authorLab = [[UILabel alloc]init];
        //_titleLab.text = @"";
        _authorLab.dk_textColorPicker = DKColorPickerWithColors(MainTextColor,MainTextColor,MainTextColor);
        _authorLab.textAlignment = NSTextAlignmentLeft;
        _authorLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    }
    return _authorLab;
}

@end
