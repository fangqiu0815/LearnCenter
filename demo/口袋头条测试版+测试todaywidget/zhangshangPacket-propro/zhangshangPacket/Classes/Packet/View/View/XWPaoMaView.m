//
//  XWPaoMaView.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWPaoMaView.h"
#import <UIKit/UIKit.h>
@interface XWPaoMaView ()<TXScrollLabelViewDelegate>



@end

@implementation XWPaoMaView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.scrollLabelView];

        [self addView];
    }
    return self;
}

- (void)addView
{
    WeakType(self)
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(weakself.mas_centerY);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
    }];
    
    [_scrollLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(15*AdaptiveScale_W);
        make.centerY.mas_equalTo(weakself.mas_centerY);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-15*AdaptiveScale_W);
    }];
    
}

- (NSArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSArray new];
    }
    return _dataArr;
}

- (YFRollingLabel *)scrollLabelView
{
    if (!_scrollLabelView) {
        
        _scrollLabelView = [[YFRollingLabel alloc]initWithFrame:CGRectMake(55, 10, ScreenW - 70, 25) textArray:STUserDefaults.adArr font:[UIFont systemFontOfSize:RemindFont(14, 15, 16)] textColor:MainTextColor];
        
        _scrollLabelView.backgroundColor = [UIColor clearColor];
        _scrollLabelView.speed = 1;
        [_scrollLabelView setOrientation:RollingOrientationLeft];
        [_scrollLabelView setInternalWidth:_scrollLabelView.frame.size.width / 3];;
        
        //Label Click Event Using Block
        _scrollLabelView.labelClickBlock = ^(NSInteger index){
            NSString *text = [STUserDefaults.adArr objectAtIndex:index];
            NSLog(@"You Tapped item:%li , and the text is %@",(long)index,text);
        };
        
        
    }
    return _scrollLabelView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = MyImage(@"icon_missions_horn");
        [_iconImageView xw_setDayMode:^(UIView *view) {
            UIImageView *paomaView = (UIImageView *)view;
            paomaView.backgroundColor = WhiteColor;
        } nightMode:^(UIView *view) {
            UIImageView *paomaView = (UIImageView *)view;
            paomaView.backgroundColor = NightMainBGColor;
        }];
        _iconImageView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
        
    }
    return _iconImageView;
}

@end
