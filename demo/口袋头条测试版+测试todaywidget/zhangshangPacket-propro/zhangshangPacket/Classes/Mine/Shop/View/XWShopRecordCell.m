//
//  XWShopRecordCell.m
//  zhangshangPacket
//
//  Created by 高方秋 on 2017/6/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWShopRecordCell.h"

@implementation XWShopRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLab];
        [self addSubview:self.accountExLab];
        [self addSubview:self.moneyLab];
        [self addSubview:self.addressLab];
        [self addSubview:self.signLab];
        [self addSubview:self.timeLab];
        [self addSubview:self.bottomView];
        
        [self setupUI];
        
    }
    return self;
}

-(void)setcell:(NSDictionary *)dic
{
    self.titleLab.text = dic[@"name"];
    self.timeLab.text = dic[@"date"];
    self.accountExLab.text = dic[@"num"];
    self.moneyLab.text = dic[@"price"];
    self.addressLab.text = [NSString stringWithFormat:@"收货地址:%@",dic[@"address"]];
    //待定
    self.signLab.text = [NSString stringWithFormat:@"发送中"];
}

- (void)setGoodsModel:(UserGoodsList *)goodsModel
{
    _goodsModel = goodsModel;
    self.titleLab.text = goodsModel.name;
    self.timeLab.text = goodsModel.date;
    self.accountExLab.text = goodsModel.num;
    self.moneyLab.text = [NSString stringWithFormat:@"%.2f",[goodsModel.price floatValue]/100.0];
    
    //读取地址plist文件 并显示reapid对应的地址信息
    NSDictionary *tempDict = [NSDictionary dictionaryWithContentsOfFile:XWADDRESS_REAPID_CACHE_PATH];
    JLLog(@"tempDict---%@",tempDict);
    if ([tempDict[@"reapid"] isEqualToString:goodsModel.reapid]) {
        self.addressLab.text = [NSString stringWithFormat:@"兑换地址：%@",tempDict[@"address"]];
    }
    //待定
    self.signLab.text = [NSString stringWithFormat:@"发送中"];
    
}


- (void)setupUI
{
    WeakType(self);
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(50*AdaptiveScale_W);
    }];
    
    UILabel *accountInfoLab = [[UILabel alloc]init];
    accountInfoLab.text = @"兑换个数：";
    accountInfoLab.textAlignment = NSTextAlignmentLeft;
    accountInfoLab.textColor = BlackColor;
    accountInfoLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    [self addSubview:accountInfoLab];
    [accountInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(weakself.titleLab.mas_bottom).offset(5);
        make.width.mas_equalTo([accountInfoLab.text widthWithfont:accountInfoLab.font]+5);
        make.height.mas_equalTo(20);
    }];
    
    CGFloat accountLabW = accountInfoLab.yj_width*0.5;
    
    [_accountExLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(accountInfoLab.mas_right).offset(5);
        make.top.mas_equalTo(accountInfoLab);
        make.width.mas_equalTo(accountLabW);
        make.height.mas_equalTo(accountInfoLab.mas_height);
        
    }];
    
    UILabel *priceLab = [[UILabel alloc]init];
    priceLab.text = @"价格：";
    priceLab.textAlignment = NSTextAlignmentLeft;
    priceLab.textColor = BlackColor;
    priceLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(accountInfoLab.mas_bottom).offset(5);
        make.width.mas_equalTo([priceLab.text widthWithfont:priceLab.font]+5);
        make.height.mas_equalTo(20);
    }];
    
    [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceLab.mas_right).offset(5);
        make.top.mas_equalTo(priceLab);
        make.width.mas_equalTo(priceLab.mas_width);
        make.height.mas_equalTo(priceLab.mas_height);
        
    }];
    
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(priceLab.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *signstateLab = [[UILabel alloc]init];
    signstateLab.text = @"状态：";
    signstateLab.textAlignment = NSTextAlignmentLeft;
    signstateLab.textColor = BlackColor;
    signstateLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    [self addSubview:signstateLab];
    [signstateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenW*0.45);
        make.top.mas_equalTo(weakself.titleLab.mas_bottom).offset(5);
        make.width.mas_equalTo([signstateLab.text widthWithfont:signstateLab.font]);
        make.height.mas_equalTo(20);
    }];
    
    [_signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(signstateLab.mas_right).offset(5);
        make.top.mas_equalTo(signstateLab);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(signstateLab.mas_height);
        
    }];
    
    UILabel *timeInfoLab = [[UILabel alloc]init];
    timeInfoLab.text = @"时间：";
    timeInfoLab.textAlignment = NSTextAlignmentLeft;
    timeInfoLab.textColor = BlackColor;
    timeInfoLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    [self addSubview:timeInfoLab];
    [timeInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenW*0.45);
        make.top.mas_equalTo(signstateLab.mas_bottom).offset(5);
        make.width.mas_equalTo([timeInfoLab.text widthWithfont:timeInfoLab.font]);
        make.height.mas_equalTo(20);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeInfoLab.mas_right).offset(5);
        make.top.mas_equalTo(timeInfoLab);
        make.width.mas_equalTo(ScreenW*0.3);
        make.height.mas_equalTo(timeInfoLab.mas_height);
        
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
        _bottomView.backgroundColor = MainBGColor;
    }
    return _bottomView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = BlackColor;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

- (UILabel *)accountExLab
{
    if (!_accountExLab) {
        _accountExLab = [[UILabel alloc]init];
        _accountExLab.textColor = MainRedColor;
        _accountExLab.textAlignment = NSTextAlignmentLeft;
        _accountExLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        
    }
    return _accountExLab;
    
}

- (UILabel *)moneyLab
{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc]init];
        _moneyLab.textColor = MainRedColor;
        _moneyLab.textAlignment = NSTextAlignmentLeft;
        _moneyLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        
    }
    return _moneyLab;
}

- (UILabel *)addressLab
{
    if (!_addressLab) {
        _addressLab = [[UILabel alloc]init];
        _addressLab.textColor = BlackColor;
        _addressLab.textAlignment = NSTextAlignmentLeft;
        _addressLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        _addressLab.numberOfLines = 2;
    }
    return _addressLab;
}

- (UILabel *)signLab
{
    if (!_signLab) {
        _signLab = [[UILabel alloc]init];
        _signLab.textColor = MainRedColor;
        _signLab.textAlignment = NSTextAlignmentLeft;
        _signLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        
    }
    return _signLab;
}

- (UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = BlackColor;
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        
    }
    return _timeLab;
    
}


@end
