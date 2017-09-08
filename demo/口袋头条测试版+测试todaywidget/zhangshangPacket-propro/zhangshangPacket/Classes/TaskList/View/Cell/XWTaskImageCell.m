//
//  XWTaskImageCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTaskImageCell.h"

@implementation XWTaskImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.cellBtn];
        
        [self addView];
        
    }
    return self;
}

- (void)addView
{
    WeakType(self);
    CGFloat rowHeight = weakself.mj_h*0.5;
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakself);
        make.height.mas_equalTo(rowHeight);
        
    }];
    
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15*AdaptiveScale_W);
        make.height.width.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.iconImg.mas_centerY);
        make.left.mas_equalTo(weakself.iconImg.mas_right).offset(15*AdaptiveScale_W);
        make.right.mas_equalTo(weakself.mas_right).offset(-15*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    [_cellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.iconImg.mas_centerY);
        make.right.mas_equalTo(weakself).offset(-10*AdaptiveScale_W);
        make.width.mas_equalTo(60*AdaptiveScale_W);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
    
}

- (void)setCellTitle:(NSString *)titleStr andTitleStrColor:(UIColor *)titleStrColor andBtnTitle:(NSString *)btnTitle andIconImage:(UIImage *)iconImage andcontentImage:(UIImage *)contentImage{
    
    self.titleLab.text = titleStr;
    self.titleLab.textColor = titleStrColor;
    [self.cellBtn setTitle:btnTitle forState:0];
    self.iconImg.image = iconImage;
    self.iconImageView.image = contentImage;
    
}


//#pragma mark btnAction
//
//-(void)signBtnAction
//{
//    if (self.taskClickBlock)
//    {
//        self.taskClickBlock();
//    }
//}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = MyImage(@"enter");
    }
    return _iconImageView;
}

- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [UIImageView new];

    }
    return _iconImg;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(16, 18, 20)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}


- (UIButton *)cellBtn
{
    if (!_cellBtn) {
        _cellBtn = [[UIButton alloc]init];
        [_cellBtn setTitle:@"立即收徒" forState:0];
        [_cellBtn setTitleColor:WhiteColor forState:0];
        [_cellBtn setBackgroundColor:MainRedColor];
        _cellBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(10, 12, 14)];
        _cellBtn.clipsToBounds = YES;
        _cellBtn.highlighted = NO;
        _cellBtn.layer.cornerRadius = 5;
    }
    return _cellBtn;
}


@end
