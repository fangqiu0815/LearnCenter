//
//  XWMidCollectCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/5.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMidCollectCell.h"
#import "UIImageView+CornerRadius.h"

@implementation XWMidCollectCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLab];
        [self addView];
        
    }
    return self;

}

-(void)setTheCellDataWithModel:(DisEditRecModel *)dataModel
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dataModel.pic]]];
    CGImageRef imageRef = image.CGImage;
    CGRect rect = CGRectMake(170, 170, 91, 91);
    CGImageRef image1 = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage *newImage = [[UIImage alloc] initWithCGImage:image1];
    self.iconImageView.image = newImage;
    //    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.pic] placeholderImage:MyImage(@"bg_default")];
    self.titleLab.text = dataModel.title;
}

- (void)setDataModel:(DisEditRecModel *)dataModel
{
    _dataModel = dataModel;
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dataModel.pic]]];
    CGImageRef imageRef = image.CGImage;
    CGRect rect = CGRectMake(170, 170, 91, 91);
    CGImageRef image1 = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage *newImage = [[UIImage alloc] initWithCGImage:image1];
    self.iconImageView.image = newImage;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.pic] placeholderImage:MyImage(@"bg_default")];
    self.titleLab.text = dataModel.title;

}

- (void)addView
{
    WeakType(self)
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.mas_top).offset(15*AdaptiveScale_W);
        make.centerX.mas_equalTo(weakself);
        make.width.mas_equalTo(60*AdaptiveScale_W);
        make.height.mas_equalTo(60*AdaptiveScale_W);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(ScreenW*0.3);
    }];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithRoundingRectImageView];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 30*AdaptiveScale_W;
        [_iconImageView zy_attachBorderWidth:2 color:MainBGColor];
    }
    return _iconImageView;

}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
    }
    return _titleLab;
}

@end
