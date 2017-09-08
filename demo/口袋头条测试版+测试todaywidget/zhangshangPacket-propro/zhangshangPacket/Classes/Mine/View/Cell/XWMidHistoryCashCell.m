//
//  XWMidHistoryCashCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMidHistoryCashCell.h"

@implementation XWMidHistoryCashCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.detailLab];
        [self setupUI];
    }
    return self;

}

- (void)setCellDataWithTitle:(NSString *)titleStr andRightTitle:(NSString *)rightTitle
{
    self.titleLab.text = titleStr;
    self.detailLab.text = rightTitle;
}


- (void)setupUI
{
    WeakType(self);
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(25*AdaptiveScale_W);
    }];
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25*AdaptiveScale_W);
    }];


}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        // _titleLab.text = @"今日获得元宝数";
        _titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        
    }
    return _titleLab;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        //_detailLab.text = [NSString stringWithFormat:@"%d",STUserDefaults.ingot];
        _detailLab.textAlignment = NSTextAlignmentRight;
        _detailLab.textColor = MainRedColor;
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    }
    return _detailLab;
}




@end
