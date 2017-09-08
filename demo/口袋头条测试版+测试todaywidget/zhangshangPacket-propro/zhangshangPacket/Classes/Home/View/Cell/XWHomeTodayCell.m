//
//  XWHomeTodayCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeTodayCell.h"

#define DotViewCentX 20//圆点中心 x坐标
#define VerticalLineWidth 2//时间轴 线条 宽度
#define ShowLabTop 10//cell间距
#define ShowLabWidth (320 - DotViewCentX - 20)
#define ShowLabFont [UIFont systemFontOfSize:15]

@implementation XWHomeTodayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.titleLab];
        
        [self.contentView addSubview:self.topView];
        [self.contentView addSubview:self.circleView];
        [self.contentView addSubview:self.bottomView];
        [self setupUI];
    }
    return self;
}

- (void)setCellWithDict:(NSDictionary *)dic
{
//    NSString *str = [dic[@"day"] substringWithRange:NSMakeRange(0, 5)];
//    self.timeLab.text = str;
//    self.titleLab.text = dic[@"title"];

}

- (void)setTodayModel:(TodayData *)todayModel
{
    _todayModel = todayModel;
    NSString *str = [todayModel.day substringWithRange:NSMakeRange(0, 5)];
    self.timeLab.text = str;
    self.titleLab.text = todayModel.title;

}

- (void)setupUI
{
    WeakType(self);
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(10);
        make.left.mas_equalTo(15);
    }];
    
    [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.topView.mas_bottom);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(8);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.circleView.mas_bottom);
        make.width.mas_equalTo(2);
        make.bottom.mas_equalTo(weakself);
        make.left.mas_equalTo(15);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(60*AdaptiveScale_W);
        make.top.mas_equalTo(10*AdaptiveScale_W);
        make.width.mas_equalTo(60*AdaptiveScale_W);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];

    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60*AdaptiveScale_W);
        make.top.mas_equalTo(weakself.timeLab.mas_bottom).offset(10*AdaptiveScale_W);
        make.right.mas_equalTo(weakself).offset(-15*AdaptiveScale_W);
        make.height.mas_equalTo(40*AdaptiveScale_W);
    }];

}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = MainRedColor;
    }
    return _topView;
}

- (UIView *)circleView
{
    if (!_circleView) {
        _circleView = [[UIView alloc]init];
        _circleView.backgroundColor = MainRedColor;
        _circleView.layer.cornerRadius = 7.5;
        _circleView.layer.masksToBounds = YES;
    }
    return _circleView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = MainRedColor;
    }
    return _bottomView;
}

- (UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
       // _timeLab.text = @"2016年";
        _timeLab.textColor = MainRedColor;
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    }
    return _timeLab;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
       // _titleLab.text = @"阿萨德后期维护会计账簿内存的健康检查凭借其跑开了";
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
    }
    return _titleLab;
}



@end
