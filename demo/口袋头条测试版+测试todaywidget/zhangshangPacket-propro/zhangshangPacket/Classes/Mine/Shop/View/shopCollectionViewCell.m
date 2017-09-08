//
//  shopCollectionViewCell.m
//  zhangshangPacket
//
//  Created by zhenhui huang on 2017/6/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "shopCollectionViewCell.h"
#define cellStrokeColor CUSTOMCOLORA(200, 200, 200, 1.0)

@interface shopCollectionViewCell ()
@property(nonatomic,strong)UIImageView *photoImage;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *integraLab;
@property(nonatomic,strong)UILabel *FrontLab;
@property(nonatomic,strong)UILabel *BehindLab;

@end

@implementation shopCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = WhiteColor;
        [self addTheView];
    }
    return self;
}
-(void)addTheView{
    [self addSubview:self.photoImage];
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(30*AdaptiveScale_W);
        make.height.mas_equalTo((ScreenW-120*AdaptiveScale_W)/2);
        make.width.mas_equalTo(self.photoImage.mas_height);

    }];
    
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.photoImage);
        make.top.mas_equalTo(self.photoImage.mas_bottom).offset(5);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
    
    [self addSubview:self.FrontLab];
    [self.FrontLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoImage);
        make.width.mas_equalTo([self.FrontLab.text widthWithfont:self.FrontLab.font] +5*AdaptiveScale_W);
        make.height.equalTo(self.nameLab);
        make.top.mas_equalTo(self.nameLab.mas_bottom);
    }];
    
    [self addSubview:self.integraLab];
    [self.integraLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.FrontLab.mas_right);
        make.width.mas_equalTo([self.integraLab.text widthWithfont:self.integraLab.font] +5*AdaptiveScale_W);
        make.top.height.equalTo(self.FrontLab);
    }];
    
    [self addSubview:self.BehindLab];
    [self.BehindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.integraLab.mas_right);
        make.width.mas_equalTo([self.BehindLab.text widthWithfont:self.BehindLab.font] );
        make.top.height.equalTo(self.FrontLab);
    }];
}
-(void)setTheCellDataWithModel:(ItemDetail *)dataModel andPhotoPre:(NSString *)preStr
{
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",preStr,dataModel.img]];
    NSLog(@"%@",imgUrl);
    [self.photoImage sd_setImageWithURL:imgUrl placeholderImage:MyImage(@"login_default")];
    self.nameLab.text = dataModel.name;
    self.integraLab.text = [NSString stringWithFormat:@"%.2f",[dataModel.cash floatValue]/100.0];
    
}
#pragma mark --
-(UIImageView *)photoImage{
    if (_photoImage == nil) {
        _photoImage = [[UIImageView alloc]init];
        _photoImage.image = MyImage(@"111111");
        _photoImage.contentMode = UIViewContentModeScaleAspectFill;
        _photoImage.layer.borderColor =WhiteColor.CGColor;
        _photoImage.clipsToBounds = YES;
        _photoImage.layer.masksToBounds = YES;
        _photoImage.layer.borderWidth = 0.f;
    }
    return _photoImage;
}
-(UILabel *)nameLab{
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"iPad mini4 16G";
        _nameLab.numberOfLines = 0;
        _nameLab.textColor = BlackColor;
        _nameLab.font = [UIFont systemFontOfSize:RemindFont(13, 14, 15) ];

    }
    return _nameLab;
}
-(UILabel *)integraLab{
    if (_integraLab == nil) {
        _integraLab = [[UILabel alloc]init];
        _integraLab.text = @"199.00";
        _integraLab.textColor = CUSTOMCOLOR(251, 82, 82);
        _integraLab.font = [UIFont systemFontOfSize:RemindFont(11, 12, 13)];
    }
    return _integraLab;
}
-(UILabel *)FrontLab{
    if (_FrontLab == nil) {
        _FrontLab = [[UILabel alloc]init];
        _FrontLab.text = @"价格：";
        _FrontLab.textColor = BlackColor;
        _FrontLab.font = [UIFont systemFontOfSize:RemindFont(11, 12, 13)];
    }
    return _FrontLab;
}
-(UILabel *)BehindLab{
    if (_BehindLab == nil) {
        _BehindLab = [[UILabel alloc]init];
        _BehindLab.text = @"元";
        _BehindLab.textColor = BlackColor;
        _BehindLab.font = [UIFont systemFontOfSize:RemindFont(11, 12, 13)];
    }
    return _BehindLab;
}

@end
