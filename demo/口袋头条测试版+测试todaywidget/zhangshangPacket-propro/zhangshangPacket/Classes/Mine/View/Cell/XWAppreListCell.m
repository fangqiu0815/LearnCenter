//
//  XWAppreListCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWAppreListCell.h"
#import "UIImageView+CornerRadius.h"

@implementation XWAppreListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.moneyLab];
        [self.contentView addSubview:self.incomeLab];

        [self addView];
        
    }
    return self;
}

-(void)setcell:(NSDictionary *)dic withindex:(NSInteger )index
{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]] placeholderImage:MyImage(@"bg_default")];
    _titleLab.text = [NSString stringWithFormat:@"%@(ID:%@)",dic[@"name"],dic[@"id"]];
    NSString *timeStr = dic[@"addtime"];
    _moneyLab.text = [NSString stringWithFormat:@"＋%@",dic[@"dearningsde"]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStr intValue]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [dateFormat stringFromDate:confromTimesp];
    _timeLab.text = [NSString stringWithFormat:@"推荐时间:%@",string];
    
}

- (void)addView
{

    WeakType(self);

    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.left.mas_equalTo(weakself).offset(10*AdaptiveScale_W);
        make.width.height.mas_equalTo(60);
        
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.iconImageView.mas_top);
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(10*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(30*AdaptiveScale_W);
        
        
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(weakself.iconImageView.mas_bottom);
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(10*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.75);
        make.height.mas_equalTo(25*AdaptiveScale_W);
        
        
    }];
    
    [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(weakself.iconImageView.mas_top);
        make.right.mas_equalTo(weakself.mas_right).offset(-10*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.3);
        make.height.mas_equalTo(40*AdaptiveScale_W);
        
        
        
    }];

    [_incomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(weakself.iconImageView.mas_bottom);
        make.centerX.mas_equalTo(weakself.moneyLab.mas_centerX);
        make.width.mas_equalTo(ScreenW*0.3);
        make.height.mas_equalTo(25*AdaptiveScale_W);
        
        
    }];
    
}

- (UIImageView *)iconImageView
{

    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithRoundingRectImageView];
       // _iconImageView.image = [UIImage imageNamed:@"czym"];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 30;
        [_iconImageView zy_attachBorderWidth:5 color:MainBGColor];
    }
    
    return _iconImageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        //_titleLab.text = @"";
        
        _titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);

        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(18, 20, 22)];
    }
    return _titleLab;
}

- (UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
       // _timeLab.text = @"收徒时间：1232456789";
        _timeLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);

        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = [UIFont systemFontOfSize:RemindFont(11, 12, 13)];
    }
    return _timeLab;
}

- (UILabel *)moneyLab
{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc]init];
      //  _moneyLab.text = @"9999";
        _moneyLab.textColor = MainYellowColor;
        _moneyLab.textAlignment = NSTextAlignmentCenter;
        _moneyLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(20 , 22, 24)];
    }
    return _moneyLab;
}

- (UILabel *)incomeLab
{
    if (!_incomeLab) {
        _incomeLab = [[UILabel alloc]init];
        _incomeLab.text = @"收益";
        _incomeLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);

        _incomeLab.textAlignment = NSTextAlignmentCenter;
        _incomeLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    }
    return _incomeLab;
}
@end
