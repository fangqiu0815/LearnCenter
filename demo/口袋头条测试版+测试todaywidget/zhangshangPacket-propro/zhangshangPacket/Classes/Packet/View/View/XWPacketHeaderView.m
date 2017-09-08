//
//  XWPacketHeaderView.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWPacketHeaderView.h"

@implementation XWPacketHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        [self addSubview:self.signInBtn];
        [self addSubview:self.signInRulBtn];
        [self addSubview:self.nowTimeLab];
        //[self addSubview:self.signInDayLab];
//        [self addSubview:self.dayLab];
//        [self addSubview:self.signInNumberLab];
        
        [self addView];
        
        //更新元通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadScoreAction) name:@"reloadscore" object:nil];
    }
    return self;
}

-(void)reloadScoreAction
{
    _signInNumberLab.text = [NSString stringWithFormat:@"%ld",STUserDefaults.serialsign];
}

- (void)addView
{
    WeakType(self)
    
    [_signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.top.mas_equalTo(weakself).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];

    [_signInDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenW*0.5 - 80);
        make.top.mas_equalTo(weakself.signInBtn.mas_bottom).offset(5);
        make.width.mas_equalTo([weakself.signInDayLab.text widthWithfont:weakself.signInDayLab.font] + 10);
        make.height.mas_equalTo(30);
    }];
    
    [_dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenW*0.5 + 60);
        make.top.mas_equalTo(weakself.signInBtn.mas_bottom).offset(5);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
        
    }];
    
    [_signInNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(ScreenW*0.5+15);
        make.top.mas_equalTo(weakself.signInBtn.mas_bottom).offset(0);
        make.width.mas_equalTo(60*AdaptiveScale_W);
        make.height.mas_equalTo(35);
        
    }];
    
    [_nowTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself).offset(-2);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(40);
    }];
    
    [_signInRulBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself).offset(-2);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
}


- (UIButton *)signInBtn
{
    if (!_signInBtn) {
        _signInBtn = [[UIButton alloc]init];
        [_signInBtn setTitleColor:WhiteColor forState:0];
        _signInBtn.layer.masksToBounds = YES;
        _signInBtn.layer.cornerRadius = 40;
        _signInBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
        
    }
    return _signInBtn;
}

- (UILabel *)signInDayLab
{
    if (!_signInDayLab) {
        _signInDayLab = [[UILabel alloc]init];
        _signInDayLab.textAlignment = NSTextAlignmentLeft;
        _signInDayLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _signInDayLab.textColor = BlackColor;
        _signInDayLab.text = @"已经连续签到";
    }
    return _signInDayLab;
}

- (UILabel *)dayLab
{
    if (!_dayLab) {
        
        _dayLab = [[UILabel alloc]init];
        _dayLab.textAlignment = NSTextAlignmentCenter;
        _dayLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _dayLab.textColor = BlackColor;
        _dayLab.text = @"天";
    }
    return _dayLab;
}

- (UILabel *)signInNumberLab
{
    if (!_signInNumberLab) {
        
        _signInNumberLab = [[UILabel alloc]init];
        _signInNumberLab.textAlignment = NSTextAlignmentCenter;
        
        if (STUserDefaults.isLogin)
        {
            _signInNumberLab.hidden = NO;
        }else
        {
            _signInNumberLab.hidden = YES;
        }

        _signInNumberLab.text = [NSString stringWithFormat:@"%ld",STUserDefaults.serialsign];
        _signInNumberLab.font = [UIFont systemFontOfSize:RemindFont(18, 19, 20)];
        _signInNumberLab.textColor = MainRedColor;

    }
    return _signInNumberLab;

}


- (UILabel *)nowTimeLab
{
    if (!_nowTimeLab) {
        _nowTimeLab = [[UILabel alloc]init];
        _nowTimeLab.text = [NSString stringWithFormat:@"%@",[self getCurrentTime]];
        _nowTimeLab.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
        _nowTimeLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _nowTimeLab.textAlignment = NSTextAlignmentLeft;
        _nowTimeLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        
    }
    return _nowTimeLab;
}

- (UIButton *)signInRulBtn
{
    if (!_signInRulBtn) {
        _signInRulBtn = [[UIButton alloc]init];
        [_signInRulBtn setTitle:@"任务规则" forState:0];
        [_signInRulBtn dk_setTitleColorPicker:DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor) forState:0];
        _signInRulBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
        _signInRulBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _signInRulBtn;
}

//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

@end
