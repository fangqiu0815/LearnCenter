//
//  XWSearchHistoryCell.m
//  demo
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWSearchHistoryCell.h"

@implementation XWSearchHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.deleteBtn];
        [self.contentView addSubview:self.bottomView];
        [self.contentView addSubview:self.clockImg];
        
        [self addView];
        
    }
    return self;
}

- (void)addView{
    WeakType(self);
    [_clockImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(weakself);
        make.width.height.mas_equalTo(35);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.clockImg.mas_right).offset(10);
        make.centerY.mas_equalTo(weakself);
        make.width.mas_equalTo(ScreenW*0.7);
        make.height.mas_equalTo(30);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(weakself);
        make.width.height.mas_equalTo(35);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomView;

}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = MainTextColor;
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]init];
        [_deleteBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        
        
    }
    return _deleteBtn;
}


@end
