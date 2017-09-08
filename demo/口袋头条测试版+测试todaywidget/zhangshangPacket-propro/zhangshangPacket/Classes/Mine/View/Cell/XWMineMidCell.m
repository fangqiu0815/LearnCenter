//
//  XWMineMidCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineMidCell.h"




@implementation XWMineMidCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)
reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lineViewOne];
        [self.contentView addSubview:self.yesIncomeLab];
        [self.contentView addSubview:self.canGetLab];
        
        [self addView];
    }
    
    return self;
}

- (void)setCellDataWithYesCash:(NSString *)yesCash andTodayCoin:(NSString *)todayCoin
{
    self.yesIncomeLab.text = yesCash;
    self.canGetLab.text = todayCoin;
}

- (void)addView{
    WeakType(self);
    CGFloat Padding = ScreenW/2;
    [_lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.mas_left).offset(Padding);
        make.top.mas_equalTo(15*AdaptiveScale_W);
        make.bottom.mas_equalTo(-15*AdaptiveScale_W);
        make.width.mas_equalTo(1);
    }];
    
    [_yesIncomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself);
        make.right.mas_equalTo(weakself.lineViewOne.mas_right);
        make.bottom.mas_equalTo(weakself).offset(-40*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
        
    }];
    
    [_canGetLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.lineViewOne.mas_right);
        make.width.mas_equalTo(Padding-1);
        make.bottom.mas_equalTo(weakself).offset(-40*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    
    NSMutableArray *secondLineArr = [NSMutableArray new];
    UILabel *firstLab = [[UILabel alloc]init];
    firstLab.text = @"昨日收入(元)";
    firstLab.textColor = WhiteColor;
    firstLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    firstLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:firstLab];
    [secondLineArr addObject:firstLab];
    
    UILabel *secondLab = [[UILabel alloc]init];
    secondLab.text = @"今日获得元宝";
    secondLab.textColor = WhiteColor;
    secondLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    secondLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:secondLab];
    [secondLineArr addObject:secondLab];
    
    [secondLineArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:1 tailSpacing:1 ];
    [secondLineArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.yesIncomeLab.mas_bottom).offset(5*AdaptiveScale_W);
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

- (UILabel *)yesIncomeLab
{
    if (!_yesIncomeLab) {
        _yesIncomeLab = [[UILabel alloc]init];
       // _incomeMoney.text = @"9999.9";
        
        if (STUserDefaults.isLogin) {
            //_incomeMoney.text = [NSString stringWithFormat:@"%ld",STUserDefaults.cashtotal];
            float cashNum = [STUserDefaults.cashyes floatValue];
            if(cashNum > 1000){
                
                _yesIncomeLab.text = [NSString stringWithFormat:@"%0.2fK",cashNum/1000.0];
                
            }else{
                _yesIncomeLab.text = [NSString stringWithFormat:@"%0.2f",cashNum];
                
            }
        }else{
            _yesIncomeLab.text = @"0";

        }
        _yesIncomeLab.dk_textColorPicker = DKColorPickerWithColors(WhiteColor,WhiteColor,MainRedColor);
        _yesIncomeLab.textAlignment = NSTextAlignmentCenter;
        _yesIncomeLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeFour size:RemindFont(26, 28, 30)];
        
    }
    return _yesIncomeLab;
}

- (UILabel *)canGetLab
{
    if (!_canGetLab) {
        _canGetLab = [[UILabel alloc]init];
        // _incomeMoney.text = @"9999.9";
        _canGetLab.dk_textColorPicker = DKColorPickerWithColors(WhiteColor,WhiteColor,MainRedColor);

        _canGetLab.textAlignment = NSTextAlignmentCenter;
        _canGetLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeFour size:RemindFont(26, 28, 30)];
        if (STUserDefaults.isLogin) {
            _canGetLab.text = [NSString stringWithFormat:@"%ld",(long)STUserDefaults.ingot];
            
        }else{
            _canGetLab.text = @"0";

        }
    }
    return _canGetLab;
}










@end
