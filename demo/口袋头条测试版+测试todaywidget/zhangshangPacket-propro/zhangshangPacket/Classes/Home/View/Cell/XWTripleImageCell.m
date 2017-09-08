//
//  XWTripleImageCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTripleImageCell.h"

@implementation XWTripleImageCell

#pragma mark init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lblTitle];
        [self.contentView addSubview:self.imageRight];
        [self.contentView addSubview:self.imageCenter];
        [self.contentView addSubview:self.imageLeft];
        [self.contentView addSubview:self.resourceLab];
        [self.contentView addSubview:self.adImageIcon];
        [self.contentView addSubview:self.adRewardImage];
        [self.contentView addSubview:self.detailLab];
        [self.contentView addSubview:self.bottomLine];
        
        [self setupUI];
    }
    return self;
}

- (void)setModel:(NewsListDataModel *)model
{
    
    if (!_model) {
        self.lblTitle.text = model.title;

        if ([model.id integerValue] < SYS_AD_MINID || [model.id integerValue] > SYS_AD_MAXID) {
            // self.detailLab.text = model.content;
            [self.imageLeft sd_setImageWithURL:[NSURL URLWithString:model.imgsUrl[@"imgsUrl1"]] placeholderImage:MyImage(@"bg_default_long")];
            [self.imageCenter sd_setImageWithURL:[NSURL URLWithString:model.imgsUrl[@"imgsUrl2"]] placeholderImage:MyImage(@"bg_default_long")];
            [self.imageRight sd_setImageWithURL:[NSURL URLWithString:model.imgsUrl[@"imgsUrl3"]] placeholderImage:MyImage(@"bg_default_long")];
            
//            [self.imageLeft yl_setNoImageModelWithUrl:[NSURL URLWithString:model.imgsUrl[@"imgsUrl1"]]
//                                   placeHolderImage:MyImage(@"bg_default_long")];
//            
//            [self.imageCenter yl_setNoImageModelWithUrl:[NSURL URLWithString:model.imgsUrl[@"imgsUrl2"]]
//                                     placeHolderImage:MyImage(@"bg_default_long")];
//            
//            [self.imageRight yl_setNoImageModelWithUrl:[NSURL URLWithString:model.imgsUrl[@"imgsUrl3"]]
//                                     placeHolderImage:MyImage(@"bg_default_long")];
            
            
            if ([model.type integerValue] == 0) {//普通新闻
                self.adImageIcon.hidden = YES;
                self.adRewardImage.hidden = YES;
                self.resourceLab.text = model.resource;
                
            }else{
                self.adImageIcon.hidden = NO;
                self.resourceLab.hidden = YES;
                
                if ([model.hasReward integerValue]== 1) {
                    self.adRewardImage.hidden = NO;
                }else{
                    self.adRewardImage.hidden = YES;
                }
                
            }

        } else {
            // self.detailLab.text = model.content;
            [self.imageLeft sd_setImageWithURL:[NSURL URLWithString:model.imgsUrl[@"imgsUrl1"]] placeholderImage:MyImage(@"bg_default")];
            [self.imageCenter sd_setImageWithURL:[NSURL URLWithString:model.imgsUrl[@"imgsUrl2"]] placeholderImage:MyImage(@"bg_default")];
            [self.imageRight sd_setImageWithURL:[NSURL URLWithString:model.imgsUrl[@"imgsUrl3"]] placeholderImage:MyImage(@"bg_default")];
            
            if ([model.type integerValue] == 0) {//普通新闻
                self.adImageIcon.hidden = NO;
                self.adRewardImage.hidden = NO;
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = YES;

            }else if([model.type integerValue] == 1){
                self.adImageIcon.hidden = NO;
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = YES;
                self.adRewardImage.image = MyImage(@"Icon_Information_Prompt_RedMission");

                if ([model.hasReward integerValue]== 1) {
                    self.adRewardImage.hidden = NO;
                }else{
                    self.adRewardImage.hidden = YES;
                }
                
            }else if ([model.type integerValue] == 2){
                self.adImageIcon.hidden = NO;
                self.adRewardImage.hidden = NO;
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = YES;
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
    
    CGFloat Distance = (ScreenW - 4*10*AdaptiveScale_W)/3;
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [_resourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.height.mas_equalTo(25*AdaptiveScale_W);
        make.width.mas_equalTo(Distance);
        make.bottom.mas_equalTo(weakself.bottomLine.mas_top).offset(-5*AdaptiveScale_W);
    }];
    
    [_adImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.bottom.mas_equalTo(-5*AdaptiveScale_W);
        make.width.mas_equalTo(40*AdaptiveScale_W);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
    
    [_adRewardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.bottom.mas_equalTo(-5*AdaptiveScale_W);
        make.width.mas_equalTo(50*AdaptiveScale_W);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
    
    [_imageCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.resourceLab.mas_top).offset(-5*AdaptiveScale_W);
        make.centerX.mas_equalTo(weakself);
        make.width.mas_equalTo(Distance);
        make.height.mas_equalTo(70*AdaptiveScale_W);
    }];
    
    [_imageLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.resourceLab.mas_top).offset(-5*AdaptiveScale_W);
        make.left.mas_equalTo(weakself).offset(15*AdaptiveScale_W);
        make.height.mas_equalTo(70*AdaptiveScale_W);
        make.width.mas_equalTo(Distance);
    }];
    
    [_imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.resourceLab.mas_top).offset(-5*AdaptiveScale_W);
        make.right.mas_equalTo(weakself).offset(-15*AdaptiveScale_W);
        make.height.mas_equalTo(70*AdaptiveScale_W);
        make.width.mas_equalTo(Distance);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.top.mas_equalTo(8*AdaptiveScale_W);
        make.bottom.mas_equalTo(weakself.imageLeft.mas_top).offset(-8*AdaptiveScale_W);
    }];
    
}

#pragma mark lazy
- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init] ;
        _lblTitle.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _lblTitle.numberOfLines = 0;
        //超过尺寸部分文本以省略号代替
        _lblTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _lblTitle ;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        _detailLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _detailLab.numberOfLines = 2;
        [_detailLab sizeToFit];

    }
    return _detailLab;
}


- (UIImageView *)imageCenter {
    if (!_imageCenter) {
        _imageCenter = [[UIImageView alloc] init] ;
        _imageCenter.contentMode = UIViewContentModeScaleAspectFill;
        _imageCenter.clipsToBounds = YES;

    }
    return _imageCenter ;
}
- (UIImageView *)imageLeft {
    if (!_imageLeft) {
        _imageLeft = [[UIImageView alloc] init] ;
        _imageLeft.contentMode = UIViewContentModeScaleAspectFill;
        _imageLeft.clipsToBounds = YES;

    }
    return _imageLeft ;
}
- (UIImageView *)imageRight {
    if (!_imageRight) {
        _imageRight = [[UIImageView alloc] init] ;
        _imageRight.contentMode = UIViewContentModeScaleAspectFill;
        _imageRight.clipsToBounds = YES;

    }
    return _imageRight ;
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
        
    }
    return _adRewardImage;

}


@end
