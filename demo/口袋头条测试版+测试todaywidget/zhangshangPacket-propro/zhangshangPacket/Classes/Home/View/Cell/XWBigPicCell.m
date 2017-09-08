//
//  XWBigPicCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWBigPicCell.h"
#define padding 8*AdaptiveScale_W

@implementation XWBigPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.adImageIcon];
        [self.contentView addSubview:self.adRewardImage];
        //[self.contentView addSubview:self.resourceLab];
        [self.contentView addSubview:self.bottomLine];
        
        [self setupUI];
    }
    return self;
}

- (void)setModel:(NewsListDataModel *)model
{
    
    if (!_model) {
        
        self.titleLab.text = [NSString stringWithFormat:@"%@",model.title];
        self.resourceLab.text = model.resource;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsUrl[@"imgsUrl1"]] placeholderImage:MyImage(@"bg_default_long")];
        
        if ([model.id integerValue] < SYS_AD_MINID || [model.id integerValue] > SYS_AD_MAXID) {
//            [self.iconImageView yl_setNoImageModelWithUrl:[NSURL URLWithString:model.imgsUrl[@"imgsUrl1"]]
//                                         placeHolderImage:MyImage(@"bg_default_long")];
            if ([model.type integerValue] == 0) {//普通新闻
                self.adImageIcon.hidden = YES;
                self.adRewardImage.hidden = YES;
                
            }else{
                self.adImageIcon.hidden = NO;
                if ([model.hasReward integerValue]== 1) {
                    self.adRewardImage.hidden = NO;
                }else{
                    self.adRewardImage.hidden = YES;
                }
                
            }
            
        } else {
//            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsUrl[@"imgsUrl1"]] placeholderImage:MyImage(@"bg_default_long")];
            if ([model.type integerValue] == 0) {
                self.adImageIcon.hidden = NO;
                self.adRewardImage.hidden = NO;
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = NO;
                
            }else if([model.type integerValue] == 1){//看广告文章奖励
                self.adImageIcon.hidden = NO;
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = NO;
                self.adRewardImage.image = MyImage(@"Icon_Information_Prompt_RedMission");
                
                if ([model.hasReward integerValue]== 1) {
                    self.adRewardImage.hidden = NO;
                }else{
                    self.adRewardImage.hidden = YES;
                }
                
            }else if ([model.type integerValue] == 2){//分享广告奖励
                self.adImageIcon.hidden = NO;
                self.adRewardImage.hidden = NO;
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = NO;
                self.adRewardImage.image = MyImage(@"icon_share_reward");
                if ([model.hasReward integerValue]== 1) {
                    self.adRewardImage.hidden = NO;
                }else{
                    self.adRewardImage.hidden = YES;
                }
                
            }
            
        }

    }

}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightBolangBGColor,MainRedColor);

    }
    return _bottomLine;
}

- (void)setupUI
{
    WeakType(self);
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [_adImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.width.mas_equalTo(30*AdaptiveScale_W);
        make.bottom.mas_equalTo(weakself.bottomLine.mas_top).offset(-5);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
    
    [_adRewardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25*AdaptiveScale_W);
        make.bottom.mas_equalTo(-2);
        
    }];
    
    [_resourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.adImageIcon.mas_right).offset(15*AdaptiveScale_W);
        make.width.mas_equalTo(80);
        make.bottom.mas_equalTo(weakself.bottomLine.mas_top).offset(-5);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.height.mas_equalTo(130*AdaptiveScale_W);
        make.bottom.mas_equalTo(weakself.adImageIcon.mas_top).offset(-8*AdaptiveScale_W);
    }];

    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.top.mas_equalTo(8*AdaptiveScale_W);
        make.bottom.mas_equalTo(weakself.iconImageView.mas_top).offset(-8*AdaptiveScale_W);
    }];
    
    
}


- (UIImageView *)adImageIcon
{
    if (!_adImageIcon) {
        _adImageIcon = [[UIImageView alloc]init];
        _adImageIcon.image = MyImage(@"Icon_Information_Advertisement");
        
    }
    return _adImageIcon;
}

- (UIImageView *)adRewardImage
{
    if (!_adRewardImage) {
        _adRewardImage = [[UIImageView alloc]init];
        _adRewardImage.image = MyImage(@"Icon_Information_Prompt_RedMission");
        
    }
    return _adRewardImage;
}



- (UILabel *)titleLab
{

    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _titleLab.numberOfLines = 0;
        _titleLab.lineBreakMode = NSLineBreakByTruncatingTail;

    }
    return _titleLab;
    
}

- (UILabel *)resourceLab
{
    if (!_resourceLab) {
        _resourceLab = [[UILabel alloc]init];
        _resourceLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _resourceLab.dk_textColorPicker = DKColorPickerWithColors(MainTextColor,MainTextColor,MainRedColor);

    }
    return _resourceLab;

}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        
    }
    return _iconImageView;
}


@end
