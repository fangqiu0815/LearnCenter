//
//  XWTaskMidCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTaskMidCell.h"

@implementation XWTaskMidCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.detailLab];
        [self.contentView addSubview:self.finishLab];
        
        
        [self addView];
        
    }
    return self;
}

- (void)addView
{
    WeakType(self);
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.centerY.mas_equalTo(weakself);
        make.width.height.mas_equalTo(30*AdaptiveScale_W);
        
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(15*AdaptiveScale_W);
        make.top.mas_equalTo(10*AdaptiveScale_W);
        make.width.mas_equalTo(0.75*ScreenW);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(15*AdaptiveScale_W);
        make.bottom.mas_equalTo(-10*AdaptiveScale_W);
        make.width.mas_equalTo(0.75*ScreenW);
        make.height.mas_equalTo(40*AdaptiveScale_W);
       
    }];
    
    [_finishLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
    
}

- (void)setCellDataWithImage:(UIImage *)image andTitle:(NSString *)titleStr andDetail:(NSString *)detailStr andIsFinishedStr:(NSString *)isFinishedStr andIsFinishedStrColor:(UIColor *)isFinishedStrColor{
    self.titleLab.text = titleStr;
    self.iconImageView.image = image;
    self.detailLab.text = detailStr;
    self.finishLab.text = isFinishedStr;
    self.finishLab.textColor = isFinishedStrColor;
    
}

//#pragma mark btnAction
//
//-(void)signBtnAction
//{
//    if (self.CellClickBlock)
//    {
//        self.CellClickBlock();
//    }
//}


- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(16, 18, 20)];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        
    }
    return _titleLab;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.font = [UIFont systemFontOfSize:RemindFont(10, 12, 14)];
        _detailLab.textColor = MainGrayTextColor;
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.numberOfLines = 0;
    }
    return _detailLab;
}

- (UILabel *)finishLab
{
    if (!_finishLab) {
        _finishLab = [[UILabel alloc]init];
        _finishLab.textAlignment = NSTextAlignmentRight;
        _finishLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];

        _finishLab.textColor = MainRedColor;
        
    }
    return _finishLab;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
  
        
    }
    return _iconImageView;
}


@end
