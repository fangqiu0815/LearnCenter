//
//  XWTaskListHeaderCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTaskListHeaderCell.h"

@implementation XWTaskListHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.itemLab];
        [self.contentView addSubview:self.rightLab];
        [self.contentView addSubview:self.redView];
        
        [self setupUI];
    }
    return self;
}

- (void)setCellDataTitle:(NSString *)titleStr andrightTitle:(NSString *)rightTitleStr
{
    self.rightLab.text = rightTitleStr;
    self.itemLab.text = titleStr;

}

- (void)setupUI
{
    WeakType(self);
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(weakself);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(2);
    }];
    
    [_itemLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.redView.mas_right).offset(15);
        make.centerY.mas_equalTo(weakself);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(ScreenW*0.3);
    }];
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself).offset(-15);
        make.centerY.mas_equalTo(weakself);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(ScreenW*0.3);
        
    }];
    
}

- (UIView *)redView
{
    if (!_redView) {
        _redView = [[UIView alloc]init];
        _redView.dk_backgroundColorPicker = DKColorPickerWithColors(MainRedColor,MainRedColor,MainRedColor);
        
    }
    return _redView;
}

- (UILabel *)itemLab
{
    if (!_itemLab) {
        _itemLab = [[UILabel alloc]init];
        _itemLab.text = @"";
        _itemLab.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
        _itemLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _itemLab.textAlignment = NSTextAlignmentLeft;
        _itemLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
    }
    return _itemLab;
}

- (UILabel *)rightLab
{
    if (!_rightLab) {
        _rightLab = [[UILabel alloc]init];
        _rightLab.text = @"";
        _rightLab.textColor = MainTextColor;
        _rightLab.textAlignment = NSTextAlignmentRight;
        _rightLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    }
    return _rightLab;
}


@end
