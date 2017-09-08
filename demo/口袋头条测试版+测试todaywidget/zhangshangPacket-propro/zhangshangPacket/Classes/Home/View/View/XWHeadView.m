//
//  XWHeadView.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHeadView.h"

@implementation XWHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLab];
        [self addSubview:self.searchBtn];
        
        
        
        [self addView];
    }
    return self;

}

- (void)addView{
    WeakType(self);
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*AdaptiveScale_W);
        make.top.mas_equalTo(35*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.3);
        make.height.mas_equalTo(30*AdaptiveScale_W);

    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10*AdaptiveScale_W);
        make.left.mas_equalTo(weakself.titleLab.mas_right).offset(10*AdaptiveScale_W);
        make.centerY.mas_equalTo(weakself.titleLab);
        make.height.mas_equalTo(30*AdaptiveScale_W);
        
    }];
    
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"口袋头条";
        _titleLab.textColor = WhiteColor;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeFour size:RemindFont(22, 23, 24)];
        
    }
    return _titleLab;

}

- (HeightBtn *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [[HeightBtn alloc]init];
        UIImage *bgimg = [UIImage imageNamed:@"background_home_searchBar"];
        //设置背景图片的拉伸区域,横向拉伸
        UIImage *newImg = [bgimg stretchableImageWithLeftCapWidth:bgimg.size.width*0.5 topCapHeight:0];
        [_searchBtn setBackgroundImage:newImg forState:UIControlStateNormal];
        [_searchBtn setImage:[UIImage imageNamed:@"SearchImg"] forState:UIControlStateNormal];
        [_searchBtn setTitle:@"   搜索   " forState:UIControlStateNormal];
        
        [_searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _searchBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -43, 0, 0);

    }
    return _searchBtn;
}

#pragma mark - 代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




@end
