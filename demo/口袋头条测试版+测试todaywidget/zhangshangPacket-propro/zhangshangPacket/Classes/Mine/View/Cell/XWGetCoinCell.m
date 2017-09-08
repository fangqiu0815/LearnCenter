//
//  XWGetCoinCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWGetCoinCell.h"

@implementation XWGetCoinCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.canGetLab];
        [self.contentView addSubview:self.cashLab];
        [self.contentView addSubview:self.tixianBtn];
        
        
        [self setupUI];
    }
    return self;
}

#pragma mark btnAction

-(void)signBtnAction
{
    if (self.GotoChargeBlock)
    {
        self.GotoChargeBlock();
    }
}

- (void)setupUI
{
    WeakType(self);
    
    [_canGetLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(25);
    }];
    
    [_tixianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(-5);
        
    }];
    
    [_cashLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(weakself.tixianBtn.mas_left).offset(-5*AdaptiveScale_W);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];

}

- (UILabel *)canGetLab
{
    if (!_canGetLab) {
        _canGetLab = [[UILabel alloc]init];
        _canGetLab.text = @"可提现金额(元)";
        _canGetLab.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
        _canGetLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);

    }
    return _canGetLab;
}

- (UILabel *)cashLab
{
    if (!_cashLab) {
        _cashLab = [[UILabel alloc]init];
        _cashLab.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
        _cashLab.textColor = MainRedColor;
        _cashLab.textAlignment = NSTextAlignmentRight;
    }
    return _cashLab;
}

- (UIButton *)tixianBtn
{
    if (!_tixianBtn) {
        _tixianBtn = [[UIButton alloc]init];
        
        [_tixianBtn setBackgroundImage:MyImage(@"icon_withdraw") forState:0];
        
    }
    return _tixianBtn;
}



@end
