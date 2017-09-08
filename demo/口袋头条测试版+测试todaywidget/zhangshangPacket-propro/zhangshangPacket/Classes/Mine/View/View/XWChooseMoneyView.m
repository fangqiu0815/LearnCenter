//
//  XWChooseMoneyView.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWChooseMoneyView.h"

@interface XWChooseMoneyView ()
{
    int _tempW;
}

/**
 *  按钮选中,中间值
 */
@property (nonatomic,strong) UIButton *tempBtn;

@end

@implementation XWChooseMoneyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLab];
        [self addSubview:self.lineView];
        
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    WeakType(self);
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(ScreenW*0.4);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.titleLab.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(1);
    }];
    
    NSArray *cashArr = [NSArray arrayWithArray:STUserDefaults.converlist];
    int i = 0;
    _tempW = 0;
    for (NSString *title in cashArr) {
        UIButton *btn = [[UIButton alloc] init];
        if (i >= 4) {
            btn.frame = CGRectMake(15, 110, 60, 30);
        }else{
            btn.frame = CGRectMake(i*15 + _tempW + 15, 70, 60, 30);
        }
        
        NSString *str = [NSString stringWithFormat:@"%@元",title];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        btn.contentMode = UIViewContentModeCenter;
        [btn setTitleColor:MainRedColor forState:UIControlStateNormal];
        [btn setBackgroundImage:MyImage(@"icon_treasury_cash") forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:MyImage(@"icon_treasury_cash_fill") forState:UIControlStateSelected];
        [btn setBackgroundColor:WhiteColor];
        
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //[btn sizeToFit];
        _tempW += btn.frame.size.width;

        [self addSubview:btn];
        i++;
    }
    
}

-(void)titleBtnClick:(UIButton *)sender
{
    
    if (sender!= self.tempBtn) {
        self.tempBtn.selected = NO;
        sender.selected = YES;
        self.tempBtn = sender;
    }else{
        self.tempBtn.selected = YES;
    }
}



- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"选择面值(元)";
        _titleLab.textColor = BlackColor;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    }
    return _titleLab;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = MainBGColor;
        
    }
    return _lineView;
}





@end
