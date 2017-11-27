//
//  XDShareView.m
//  XDCommonApp
//
//  Created by XD-XY on 4/10/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "XDShareView.h"
#import "XDTools.h"
#import "XDHeader.h"

@implementation XDShareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self makeView];
    }
    return self;
}

-(void)makeView
{
    
    if (IOS7){
        aheight = UI_SCREEN_HEIGHT;
    }else{
        aheight  = UI_MAINSCREEN_HEIGHT;
    }
    self.hview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, aheight)];
    _hview.backgroundColor = [UIColor blackColor];
    _hview.alpha = .5f;
    [self addSubview:_hview];
    
    self.Bgview = [[UIView alloc] initWithFrame:CGRectMake(0, height_y(self.hview), UI_SCREEN_WIDTH, 440/2.0f)];
    _Bgview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shareBg"]];
    [self addSubview:_Bgview];

    NSArray * nameArray = @[@"腾讯微博",@"新浪微博",@"微信好友",@"朋友圈",@"人人网",@"短信"];

    for (int i = 0; i < 6; i++) {
        UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(40+100*(i%3), 20+75*(i/3), 41, 41)];
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"shareIcon%d",i]];
        [_Bgview addSubview:iv];

        UILabel * lb = [XDTools addAlabelForAView:_Bgview withText:nameArray[i] frame:CGRectMake(iv.frame.origin.x-10, height_y(iv)+8, 60, 15) font:[UIFont systemFontOfSize:13] textColor:UIColorFromRGB(0x696969)];
        lb.textAlignment = NSTextAlignmentCenter;
//        lb.backgroundColor = [UIColor orangeColor];

        UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(25+95*(i%3), 15+75*(i/3), 75, 75) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(btnClick:) target:self buttonTpye:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor orangeColor];
        btn.tag = 1000+i;
        [_Bgview addSubview:btn];
    }

//    self.xlBtn = [XDTools getAButtonWithFrame:CGRectMake(8, 15, 302/2.0f, 84/2.0f) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:nil nbgImage:@"share_weibo" hbgImage:@"share_weibo" action:@selector(btnClick:) target:self buttonTpye:UIButtonTypeCustom];
//    _xlBtn.tag = 1001;
//    [_Bgview addSubview:_xlBtn];
//    
//    self.wxBtn = [XDTools getAButtonWithFrame:CGRectMake(width_x(_xlBtn), _xlBtn.frame.origin.y, 302/2.0f, 84/2.0f) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:nil nbgImage:@"share_weixin" hbgImage:@"share_weixin" action:@selector(btnClick:) target:self buttonTpye:UIButtonTypeCustom];
//    _wxBtn.tag = 1002;
//    [_Bgview addSubview:_wxBtn];





    UIImageView * lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 175, 300, 1)];
    lineIV.image = [UIImage imageNamed:@"line"];
    [_Bgview addSubview:lineIV];
    
    self.canelBtn = [XDTools getAButtonWithFrame:CGRectMake(10, 182, 300, 40) nomalTitle:@"取消" hlTitle:@"取消" titleColor:UIColorFromRGB(0xee8a00) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(btnClick:) target:self buttonTpye:UIButtonTypeCustom];
    [_canelBtn addTarget:self action:@selector(canelBtnClick) forControlEvents:UIControlEventTouchDown];
    [_Bgview addSubview:_canelBtn];
    
    self.hidden =YES;
}

-(void)setViewHidden
{
    if (IOS7) {
        [UIView animateKeyframesWithDuration:0.3 delay:0 options:0 animations:^{
            _hview.hidden =YES;
            _Bgview.frame = CGRectMake(0, aheight, UI_SCREEN_WIDTH, 440/2.0f);
        } completion:^(BOOL finished) {
            self.hidden =YES;
        }];
    }else{

        [UIView animateWithDuration:.3f animations:^{
            _hview.hidden =YES;
            _Bgview.frame = CGRectMake(0, aheight, UI_SCREEN_WIDTH, 440/2.0f);
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];


    }
}

-(void)setViewShow
{
    self.hidden =NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _hview.hidden =NO;
    _Bgview.frame = CGRectMake(0, aheight-440/2.0f, UI_SCREEN_WIDTH, 440/2.0f);
    [UIView commitAnimations];
    
}

-(void)canelBtnClick
{
    [self setViewHidden];
}

#pragma mark ====================分享=========================
-(void)btnClick:(UIButton *)button
{
    [_delegate shareViewBtnCLick:button];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
