//
//  XWTodayDetailCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTodayDetailCell.h"

@implementation XWTodayDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageTitleView];
        [self.contentView addSubview:self.lblTitle];
        [self.contentView addSubview:self.resourceLab];
        [self.contentView addSubview:self.detailLab];
        [self.contentView addSubview:self.authorLab];
        [self.contentView addSubview:self.bottomLine];
        
        [self addView];
        
    }
    return self;
}

- (void)setDataModel:(DisHeaderModel *)dataModel
{
    _dataModel = dataModel;
    
    self.lblTitle.text = dataModel.content;
    // self.detailLab.text = model.content;
    [self.imageTitleView sd_setImageWithURL:[NSURL URLWithString:dataModel.piclist[0]] placeholderImage:MyImage(@"bg_default_long")];
    self.resourceLab.text = dataModel.source;
    
    [self.authorLab setTitle:[NSString stringWithFormat:@"%d",[dataModel.note intValue]] forState:0];
    
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    }
    return _bottomLine;
}

- (void)addView
{
    
    WeakType(self)
    [_imageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.width.mas_equalTo(110*AdaptiveScale_W);
        make.height.mas_equalTo(80*AdaptiveScale_W);
        make.left.mas_equalTo(weakself).offset(15*AdaptiveScale_W);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.imageTitleView.mas_right).offset(15*AdaptiveScale_W);
        make.top.mas_equalTo(weakself.imageTitleView.mas_top);
        make.right.mas_equalTo(weakself).offset(-15*AdaptiveScale_W);
    }];
    
    [_resourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.imageTitleView.mas_bottom);
        make.left.mas_equalTo(weakself.imageTitleView.mas_right).offset(15*AdaptiveScale_W);
        make.width.mas_equalTo(60*AdaptiveScale_W);
        make.height.mas_equalTo(15*AdaptiveScale_W);
    }];
    
    [_authorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.imageTitleView.mas_bottom);
        make.left.mas_equalTo(weakself.resourceLab.mas_right).offset(5*AdaptiveScale_W);
        make.width.mas_equalTo(60*AdaptiveScale_W);
        make.height.mas_equalTo(15*AdaptiveScale_W);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

- (UIImageView *)imageTitleView
{
    if (!_imageTitleView) {
        _imageTitleView = [[UIImageView alloc]init];
        _imageTitleView.image = [UIImage imageNamed:@"czym"];
        _imageTitleView.contentMode = UIViewContentModeScaleAspectFill;
        _imageTitleView.clipsToBounds = YES;
        
    }
    return _imageTitleView;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc]init];
        //_lblTitle.text = @"哈局领导开讲啦处女座选举哦亲离开农村，名字那是的囧文件夹里快乐";
        _lblTitle.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _lblTitle.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.numberOfLines = 3;
        [_lblTitle sizeToFit];
        _lblTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _lblTitle;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        // _detailLab.text = @"哈局领导开讲啦处女座选举哦亲离开农村，名字那是的囧文件夹里快乐";
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        _detailLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.numberOfLines = 2;
        
    }
    return _detailLab;
}


- (UILabel *)resourceLab
{
    if (!_resourceLab) {
        _resourceLab = [[UILabel alloc]init];
        _resourceLab.textColor = MainTextColor;
        _resourceLab.textAlignment = NSTextAlignmentLeft;
        _resourceLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    }
    return _resourceLab;
}

- (UIButton *)authorLab
{
    if (!_authorLab) {
        _authorLab = [[UIButton alloc]init];
        [_authorLab dk_setTitleColorPicker:DKColorPickerWithColors(MainTextColor,MainTextColor,MainTextColor) forState:0];
        [_authorLab dk_setImage:DKImagePickerWithNames(@"icon_mov_eyes",@"icon_mov_eyes_white",@"icon_mov_eyes") forState:0];
        _authorLab.titleLabel.font = [UIFont systemFontOfSize:RemindFont(10, 11, 12)];
        [_authorLab setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    return _authorLab;
    
}

@end
