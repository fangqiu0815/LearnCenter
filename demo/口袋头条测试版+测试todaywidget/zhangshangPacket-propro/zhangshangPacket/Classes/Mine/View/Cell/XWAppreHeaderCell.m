//
//  XWAppreHeaderCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWAppreHeaderCell.h"

@implementation XWAppreHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)
reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lineViewOne];
        
        [self.contentView addSubview:self.incomeMoney];
        [self.contentView addSubview:self.withdrawMoney];
        
        
        [self addView];
    }
    
    return self;
}

- (void)addView{
    WeakType(self);
    CGFloat Padding = ScreenW*0.5;
    [_lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.top.mas_equalTo(20*AdaptiveScale_W);
        make.bottom.mas_equalTo(-20*AdaptiveScale_W);
        make.width.mas_equalTo(1);
    }];
    
    
    [_incomeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself);
        make.right.mas_equalTo(weakself.lineViewOne.mas_right);
        make.bottom.mas_equalTo(weakself).offset(-45*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
        
    }];
    
    [_withdrawMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.lineViewOne.mas_right);
        make.right.mas_equalTo(weakself.mas_right);
        make.bottom.mas_equalTo(weakself).offset(-45*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    
    
    NSMutableArray *secondLineArr = [NSMutableArray new];
    UILabel *firstLab = [[UILabel alloc]init];
    firstLab.text = @"推荐数量";
    firstLab.textColor = WhiteColor;
    firstLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    firstLab.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:firstLab];
    [secondLineArr addObject:firstLab];
    
    UILabel *secondLab = [[UILabel alloc]init];
    secondLab.text = @"推荐收益(元宝)";
    secondLab.textColor = WhiteColor;
    secondLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    secondLab.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:secondLab];
    [secondLineArr addObject:secondLab];
    
    
    
    [secondLineArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:1 tailSpacing:1 ];
    [secondLineArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.incomeMoney.mas_bottom).offset(5*AdaptiveScale_W);
        make.height.mas_equalTo(20);
    }];
    
    
    
}

- (UIView *)lineViewOne
{
    if (!_lineViewOne) {
        _lineViewOne = [[UIView alloc]init];
        _lineViewOne.backgroundColor = WhiteColor;
        
    }
    return _lineViewOne;
}

/**
 * 徒弟数量
 */
- (UILabel *)incomeMoney
{
    if (!_incomeMoney) {
        _incomeMoney = [[UILabel alloc]init];
       // _incomeMoney.text = @"9999.9";
        if (STUserDefaults.isLogin) {
            _incomeMoney.text = [NSString stringWithFormat:@"%ld",STUserDefaults.disciple];
        }else{
            _incomeMoney.text = @"0";
            
        }
        
        _incomeMoney.textColor = WhiteColor;
        _incomeMoney.textAlignment = NSTextAlignmentCenter;
        _incomeMoney.font = [ToolFontFit getFontSizeWithType:TGFontTypeFour size:RemindFont(26, 28, 30)];
        
    }
    return _incomeMoney;
}


/**
 * 徒弟收益
 */
- (UILabel *)withdrawMoney
{
    if (!_withdrawMoney) {
        _withdrawMoney = [[UILabel alloc]init];
      //  _withdrawMoney.text = @"9999.9";
        if (STUserDefaults.isLogin) {
            _withdrawMoney.text = [NSString stringWithFormat:@"%ld",STUserDefaults.disciplefee];
        }else{
            _withdrawMoney.text = @"0";
            
        }
        
        _withdrawMoney.textColor = WhiteColor;
        _withdrawMoney.textAlignment = NSTextAlignmentCenter;
        _withdrawMoney.font = [ToolFontFit getFontSizeWithType:TGFontTypeFour size:RemindFont(26, 28, 30)];
        
    }
    return _withdrawMoney;
}




@end
