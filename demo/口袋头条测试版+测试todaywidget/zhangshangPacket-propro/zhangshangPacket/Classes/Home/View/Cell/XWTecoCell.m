//
//  XWTecoCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTecoCell.h"

@implementation XWTecoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageTitleView];
        [self.contentView addSubview:self.lblTitle];
        [self.contentView addSubview:self.adImageIcon];
        [self.contentView addSubview:self.adRewardImage];
        [self.contentView addSubview:self.resourceLab];
        [self.contentView addSubview:self.detailLab];
        [self.contentView addSubview:self.authorLab];
        
        [self addView];
    }
    return self;
}

- (void)setModel:(TecoListDataModel *)model
{
    if (!_model) {
        self.lblTitle.text = model.title;
        // self.detailLab.text = model.content;
        [self.imageTitleView sd_setImageWithURL:[NSURL URLWithString:model.imgurl[@"imgurl1"]] placeholderImage:MyImage(@"bg_default_long")];
        if ([model.id integerValue] < SYS_AD_MINID || [model.id integerValue] > SYS_AD_MAXID) {
            
            if ([model.type integerValue] == 0) {//普通新闻
                self.adImageIcon.hidden = YES;
                self.adRewardImage.hidden = YES;
                self.resourceLab.text = model.resource;
                if (model.author) {
                    self.authorLab.text = [NSString stringWithFormat:@"%@",model.author];
                } else {
                    
                }
                
            }else{
                self.adImageIcon.hidden = YES;
                self.resourceLab.hidden = YES;
                self.resourceLab.text = model.resource;
                
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
                self.resourceLab.hidden = YES;
                
            }else if([model.type integerValue] == 1){//看广告文章奖励
                self.adImageIcon.hidden = NO;
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = YES;
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
                self.resourceLab.hidden = YES;
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

- (void)addView
{
    
    WeakType(self)
    [_imageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.width.mas_equalTo(110*AdaptiveScale_W);
        make.height.mas_equalTo(80*AdaptiveScale_W);
        make.left.mas_equalTo(weakself).offset(10*AdaptiveScale_W);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.imageTitleView.mas_right).offset(10*AdaptiveScale_W);
        make.top.mas_equalTo(weakself).offset(10*AdaptiveScale_W);
        make.right.mas_equalTo(weakself).offset(-10*AdaptiveScale_W);
        make.height.mas_equalTo(40*AdaptiveScale_W);
    }];
    
    //    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(weakself.imageTitleView.mas_right).offset(10*AdaptiveScale_W);
    //        make.top.mas_equalTo(weakself.lblTitle.mas_bottom).offset(5*AdaptiveScale_W);
    //        make.right.mas_equalTo(weakself).offset(-10*AdaptiveScale_W);
    //        make.height.mas_equalTo(40*AdaptiveScale_W);
    //    }];
    
    [_adImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.imageTitleView.mas_bottom);
        make.left.mas_equalTo(weakself.imageTitleView.mas_right).offset(10*AdaptiveScale_W);
        make.width.mas_equalTo(30*AdaptiveScale_W);
        make.height.mas_equalTo(15*AdaptiveScale_W);
    }];
    
    [_adRewardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself).offset(-10*AdaptiveScale_W);
        make.width.mas_equalTo(60*AdaptiveScale_W);
        make.height.mas_equalTo(20*AdaptiveScale_W);
        make.bottom.mas_equalTo(weakself);
        
    }];
    
    [_resourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.imageTitleView.mas_bottom);
        make.left.mas_equalTo(weakself.imageTitleView.mas_right).offset(10*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.2);
        make.height.mas_equalTo(15*AdaptiveScale_W);
    }];
    
    [_authorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.imageTitleView.mas_bottom);
        make.left.mas_equalTo(weakself.resourceLab.mas_right).offset(5*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.2);
        make.height.mas_equalTo(15*AdaptiveScale_W);
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
        _lblTitle.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        _lblTitle.textColor = BlackColor;
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.numberOfLines = 2;
        [_lblTitle sizeToFit];

    }
    return _lblTitle;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        // _detailLab.text = @"哈局领导开讲啦处女座选举哦亲离开农村，名字那是的囧文件夹里快乐";
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        _detailLab.textColor = BlackColor;
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.numberOfLines = 2;
        
    }
    return _detailLab;
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

- (UILabel *)resourceLab
{
    if (!_resourceLab) {
        _resourceLab = [[UILabel alloc]init];
        _resourceLab.textColor = MainTextColor;
        _resourceLab.textAlignment = NSTextAlignmentLeft;
        _resourceLab.font = [UIFont systemFontOfSize:RemindFont(10, 11, 12)];
    }
    return _resourceLab;
}

- (UILabel *)authorLab
{
    if (!_authorLab) {
        _authorLab = [[UILabel alloc]init];
        _authorLab.textColor = MainTextColor;
        _authorLab.textAlignment = NSTextAlignmentLeft;
        _authorLab.font = [UIFont systemFontOfSize:RemindFont(10, 11, 12)];
    }
    return _authorLab;
    
}


@end
