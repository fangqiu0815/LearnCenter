//
//  XWMineListCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineListCell.h"

@interface XWMineListCell ()
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *rightTitleLab;

@end

@implementation XWMineListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addTheView];
    }
    return self;
}

- (void)setCellDataWithImage:(UIImage *)image andTitle:(NSString *)titleStr ;

{
    self.titleLab.text = titleStr;
    self.iconImage.image = image;
    
}

#pragma mark addTheView
-(void)addTheView
{
    [self addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(Size(25, 25));
    }];
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(self.iconImage.mas_right).offset(10);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    [self addSubview:self.rightTitleLab];
    [self.rightTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(self).offset(-25);
        make.width.mas_equalTo(ScreenW*0.3);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
}
#pragma mark btnAction
#pragma mark get
-(UIImageView *)iconImage
{
    if (_iconImage == nil)
    {
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}
-(UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        
    }
    return _titleLab;
}

- (UILabel *)rightTitleLab
{

    if (!_rightTitleLab) {
        _rightTitleLab = [[UILabel alloc]init];
        _rightTitleLab.font = [UIFont systemFontOfSize:RemindFont(10, 12, 14)];
        _rightTitleLab.textColor = [UIColor lightTextColor];
        
    }
    return _rightTitleLab;
    
}


@end
