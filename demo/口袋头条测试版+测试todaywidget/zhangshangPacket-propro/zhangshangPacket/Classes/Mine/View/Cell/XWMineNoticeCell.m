//
//  XWMineNoticeCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineNoticeCell.h"

@implementation XWMineNoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.timeLab];
        
        
        [self addView];
    }
    
    return self;
}

- (void)setCell:(NSDictionary *)dic
{
    
    _titleLab.text = dic[@"title"];
    _timeLab.text = dic[@"date"];
    _urlStr = dic[@"noticeurl"];
    _contentLab.text = dic[@"content"];
    
}

- (void)addView{
    WeakType(self);
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.6);
        make.height.mas_equalTo(30*AdaptiveScale_W);
        
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*AdaptiveScale_W);
        make.bottom.mas_equalTo(-10*AdaptiveScale_W);
        make.top.mas_equalTo(weakself.titleLab.mas_bottom).offset(10*AdaptiveScale_W);
        make.right.mas_equalTo(-10*AdaptiveScale_W);
        
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10*AdaptiveScale_W);
        make.top.mas_equalTo(10*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.3*AdaptiveScale_W);
        
        
    }];

}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"";
        _titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
    }
    
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.text = @"";
        _contentLab.textColor = MainTextColor;
        _contentLab.textAlignment = NSTextAlignmentLeft;
        _contentLab.font = [UIFont systemFontOfSize:RemindFont(13, 14, 15)];
        _contentLab.numberOfLines = 3;
    }
    return _contentLab;
}

- (UILabel *)timeLab
{
    if (!_timeLab) {
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"";
        _timeLab.textColor = MainTextColor;
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font = [UIFont systemFontOfSize:RemindFont(13, 14, 15)];
        
        
    }
    return _timeLab;
}



@end
