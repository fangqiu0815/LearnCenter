//
//  XWMineHeaderCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

//
//  XWMineHeaderView.m
//  zhangshangnews
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineHeaderCell.h"
#import "UIImageView+CornerRadius.h"
#import "XWLoginVC.h"
@implementation XWMineHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLab];
        
        [self addView];
        
        //更新 用户数据通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadInfoAction) name:@"reloadscore" object:nil];
        
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

- (void)addView
{
    
    WeakType(self);
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself).offset(10*AdaptiveScale_W);
        make.centerX.mas_equalTo(weakself.mas_centerX);
        make.width.height.mas_equalTo(70*AdaptiveScale_W);
        
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(10*AdaptiveScale_W);
        make.centerX.mas_equalTo(weakself.mas_centerX);
       // make.height.mas_equalTo(30*AdaptiveScale_W);
        make.width.mas_equalTo([weakself.nameLab.text widthWithfont:weakself.nameLab.font] + 20*AdaptiveScale_W);
    }];
    
    
    
}

-(void)reloadInfoAction
{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:STUserDefaults.img] placeholderImage:MyImage(@"bg_user_nouser")];
    if (STUserDefaults.ischeck == 1) {
        _nameLab.text = [NSString stringWithFormat:@"%@",STUserDefaults.name];
    } else {
        _nameLab.text = [NSString stringWithFormat:@"%@  (ID:%@)",STUserDefaults.name,STUserDefaults.uid];
    }
    
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithRoundingRectImageView];
        _iconImageView.image = [UIImage imageNamed:@"czym"];
        [_iconImageView zy_attachBorderWidth:10 color:MainYellowColor];
        if (STUserDefaults.isLogin)
        {
            _iconImageView.image = [UIImage imageNamed:@"czym"];
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:STUserDefaults.img] placeholderImage:MyImage(@"bg_user_nouser")];
            [_iconImageView zy_attachBorderWidth:5 color:WhiteColor];

        }else{
            _iconImageView.image = MyImage(@"bg_user_nouser");
        }
        
        
    }
    return _iconImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.textColor = WhiteColor;
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(18, 19, 20)];
        if (STUserDefaults.isLogin)
        {
            JLLog(@"%@",STUserDefaults.name);
            
            if (STUserDefaults.ischeck == 1) {
                _nameLab.text = [NSString stringWithFormat:@"%@",STUserDefaults.name];

            } else {
                
                if ([self isBlankString:STUserDefaults.name]) {
                    _nameLab.text = [NSString stringWithFormat:@"(ID:%@)",STUserDefaults.uid];
                } else {
                    _nameLab.text = [NSString stringWithFormat:@"%@  (ID:%@)",STUserDefaults.name,STUserDefaults.uid];
                }
            }
            
        }

    }
    return _nameLab;
}

-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

@end

