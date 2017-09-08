//
//  XWOtherBigImageCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/16.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWOtherBigImageCell.h"

@implementation XWOtherBigImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.adImageIcon];
        [self.contentView addSubview:self.adRewardImage];
        //[self.contentView addSubview:self.resourceLab];

        
        
        [self setupUI];
    }
    return self;
}

- (void)setModel:(TecoListDataModel *)model
{
    if (!_model) {
        
        self.titleLab.text = model.title;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl[@"imgurl1"]] placeholderImage:MyImage(@"bg_default_long")];
        self.resourceLab.text = model.resource;

        if ([model.id integerValue] < SYS_AD_MINID || [model.id integerValue] > SYS_AD_MAXID) {
            
            if ([model.type integerValue] == 0) {//普通新闻
                self.adImageIcon.hidden = YES;
                self.adRewardImage.hidden = YES;
                
            }else{
                self.adImageIcon.hidden = NO;
                if (model.hasReward) {
                    self.adRewardImage.hidden = NO;
                }else{
                    self.adRewardImage.hidden = YES;
                }
            }
            
        } else {
            
            if ([model.type integerValue] == 0) {//普通广告
                self.adImageIcon.hidden = NO;
                self.adRewardImage.hidden = NO;
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = NO;
                
            }else if([model.type integerValue] == 1){//看广告文章奖励
                self.adImageIcon.hidden = NO;
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = NO;
                self.adRewardImage.image = MyImage(@"Icon_Information_Prompt_RedMission");
                
                if (model.hasReward) {
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
                if (model.hasReward) {
                    self.adRewardImage.hidden = NO;
                }else{
                    self.adRewardImage.hidden = YES;
                }
            }
            
        }
        
    }
    
}


- (void)setupUI
{
    WeakType(self);
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*AdaptiveScale_W);
        make.right.mas_equalTo(-10*AdaptiveScale_W);
        make.height.mas_equalTo(50*AdaptiveScale_W);
        make.top.mas_equalTo(5*AdaptiveScale_W);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*AdaptiveScale_W);
        make.right.mas_equalTo(-10*AdaptiveScale_W);
        make.height.mas_equalTo(90*AdaptiveScale_W);
        make.top.mas_equalTo(weakself.titleLab.mas_bottom).offset(5*AdaptiveScale_W);
    }];
    
    [_adImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*AdaptiveScale_W);
        make.width.mas_equalTo(30*AdaptiveScale_W);
        make.height.mas_equalTo(15*AdaptiveScale_W);
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(5);
    }];
    
    [_adRewardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10*AdaptiveScale_W);
        make.width.mas_equalTo(60);
        make.bottom.mas_equalTo(-2);
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(5);
    }];
    
    [_resourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.adImageIcon.mas_right).offset(10*AdaptiveScale_W);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20*AdaptiveScale_W);
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(5);
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
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        _titleLab.textColor = BlackColor;
        _titleLab.numberOfLines = 2;
        [_titleLab sizeToFit];

    }
    return _titleLab;
    
}

- (UILabel *)resourceLab
{
    if (!_resourceLab) {
        _resourceLab = [[UILabel alloc]init];
        _resourceLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        _resourceLab.textColor = MainTextColor;
        
        
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
