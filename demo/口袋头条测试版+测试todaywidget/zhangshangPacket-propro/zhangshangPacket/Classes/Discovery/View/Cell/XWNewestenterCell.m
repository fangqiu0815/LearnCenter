//
//  XWNewestenterCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWNewestenterCell.h"
#import "UIImageView+CornerRadius.h"

@implementation XWNewestenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        [self.contentView addSubview:self.lineView];
        
        [self.contentView addSubview:self.detailLab];
        [self.contentView addSubview:self.lblTitle];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.imgView];
        
        
        [self addTheView];
    }
    return self;

}

- (void)setModel:(MoreDataListModel *)model
{
    _model = model;
    JLLog(@"datamodel.pic---%@",model.pic);
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:MyImage(@"bg_user_nouser")];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.pic]]];
    CGImageRef imageRef = image.CGImage;
    CGRect rect = CGRectMake(170, 170, 91, 91);
    CGImageRef image1 = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage *newImage = [[UIImage alloc] initWithCGImage:image1];
    
    self.iconImageView.image = newImage;
    
    self.lblTitle.text = model.title;
    self.detailLab.text = model.desc;
}

- (void)setDataModel:(XWNewestenter *)dataModel
{
    _dataModel = dataModel;
    JLLog(@"datamodel.pic---%@",dataModel.pic);
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dataModel.pic]]];
    CGImageRef imageRef = image.CGImage;
    CGRect rect = CGRectMake(170, 170, 91, 91);
    CGImageRef image1 = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage *newImage = [[UIImage alloc] initWithCGImage:image1];
    
    self.iconImageView.image = newImage;
    self.lblTitle.text = dataModel.title;
    self.detailLab.text = dataModel.content;

}

- (void)addTheView
{
    WeakType(self);
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.left.mas_equalTo(weakself).offset(10*AdaptiveScale_W);
        make.width.height.mas_equalTo(60*AdaptiveScale_W);
        
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.iconImageView.mas_top);
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(10*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(30*AdaptiveScale_W);
        
        
    }];
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.iconImageView.mas_bottom);
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(10*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.75);
        make.height.mas_equalTo(25*AdaptiveScale_W);
        
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.bottom.mas_equalTo(weakself);
        make.height.mas_equalTo(1);
    }];
    
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = MyImage(@"icon_forward");
        
        [_imgView sizeToFit];
    }
    return _imgView;
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
        _iconImageView = [[UIImageView alloc]initWithRoundingRectImageView];
        // _iconImageView.image = [UIImage imageNamed:@"czym"];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 30*AdaptiveScale_W;
        [_iconImageView zy_attachBorderWidth:2 color:MainBGColor];
    }
    return _iconImageView;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc]init];
        _lblTitle.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainTextColor);
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.font = [ToolFontFit getFontSizeWithType:TGFontTypeFour size:RemindFont(16, 17, 18)];
    }
    return _lblTitle;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.dk_textColorPicker = DKColorPickerWithColors(MainTextColor,MainTextColor,MainTextColor);
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    }
    return _detailLab;
}


@end
