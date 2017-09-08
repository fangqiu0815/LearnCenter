//
//  XWCashInfoHeaderCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCashInfoHeaderCell.h"

@implementation XWCashInfoHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.everydayLab];
        [self addSubview:self.cornLab];
        [self addSubview:self.timeLab];
        
        
        [self addView];
    }
    
    return self;
}

- (void)addView{
    WeakType(self);
    
    [_everydayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*AdaptiveScale_W);
        make.width.mas_equalTo(60);
        make.centerY.mas_equalTo(weakself);
        make.height.mas_equalTo(30);
        
    }];
    
    [_cornLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.width.mas_equalTo(60);
        make.centerY.mas_equalTo(weakself);
        make.height.mas_equalTo(30);
        
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10*AdaptiveScale_W);
        make.width.mas_equalTo(60);
        make.centerY.mas_equalTo(weakself);
        make.height.mas_equalTo(30);
        
    }];
    
}

- (void)setCellMidTitle:(NSString *)midTitle
{
    self.cornLab.text = midTitle;
}


- (UILabel *)everydayLab
{
    if (!_everydayLab) {
        
        _everydayLab = [[UILabel alloc]init];
        _everydayLab.text = @"来源";
        _everydayLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _everydayLab.textAlignment = NSTextAlignmentLeft;
        _everydayLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
    }
    
    return _everydayLab;
}

- (UILabel *)cornLab
{
    if (!_cornLab) {
        _cornLab = [[UILabel alloc]init];
        //_cornLab.text = @"元宝";
        _cornLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _cornLab.textAlignment = NSTextAlignmentCenter;
        _cornLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
    }
    return _cornLab;
}

- (UILabel *)timeLab
{
    if (!_timeLab) {
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"时间";
        _timeLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
        
    }
    return _timeLab;
}



@end
