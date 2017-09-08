//
//  XWPublishInformView.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/6.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWPublishInformView.h"

#define ShareH  190*AdaptiveScale_W
#define ShareW  40*AdaptiveScale_W
@interface XWPublishInformView ()


@end

@implementation XWPublishInformView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(ShareW, ScreenH/2 - ShareH/2, ScreenW - ShareW*2, ShareH)];
        view1.backgroundColor = [UIColor whiteColor];
        view1.layer.masksToBounds = YES;
        view1.layer.cornerRadius = 5.0;
        [self addSubview:view1];
        
        // 最顶上的label
        UILabel *label = [[UILabel alloc]init];
        label.text = @"通知";
        label.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(17, 18, 19)];
        label.textColor = BlackColor;
        label.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(15*AdaptiveScale_W);
            make.width.mas_equalTo(ScreenW*0.3);
            make.height.mas_equalTo(35*AdaptiveScale_W);
        }];
        
        // 右上角跳过
        UIButton *rightLab = [[UIButton alloc]init];
        [rightLab setTitle:@"跳过" forState:0];
        [rightLab setTitleColor:MainTextColor forState:0];
        rightLab.titleLabel.font = [UIFont systemFontOfSize:RemindFont(13, 14, 15)];
        rightLab.titleLabel.textAlignment = NSTextAlignmentRight;
        [rightLab addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:rightLab];
        [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(label.mas_centerY);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(view1.mas_right).offset(-10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(20);
        }];
        
//        //内容方法
//        UILabel *detailLab = [[UILabel alloc]init];
//        detailLab.text = @"“口袋头条”提醒您登录微信才可提现,点击登录可赚取更多元宝!";
//        detailLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
//        detailLab.textColor = BlackColor;
//        detailLab.textAlignment = NSTextAlignmentCenter;
//        detailLab.numberOfLines = 0;
//        [view1 addSubview:detailLab];
//        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self);
//            make.top.mas_equalTo(label.mas_bottom).offset(10*AdaptiveScale_W);
//            make.width.mas_equalTo(ScreenW*0.65);
//            make.height.mas_equalTo(60);
//        }];
        
        //其他方法
        UILabel *otherLab = [[UILabel alloc]init];
//        otherLab.text = @"(其他方法：我的-钱包-提现-绑定后即可提现)";
        otherLab.text = @"温馨提示：微信登录获取更多奖励！";
        otherLab.font = [UIFont systemFontOfSize:RemindFont(15 , 16, 17)];
        otherLab.numberOfLines = 2;
        otherLab.textColor = MainTextInformColor;
        otherLab.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:otherLab];
        [otherLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(label.mas_bottom).offset(15*AdaptiveScale_W);
            make.width.mas_equalTo(ScreenW*0.65);
            make.height.mas_equalTo(48*AdaptiveScale_W);
        }];
        
        //绑定按钮
        UIButton *button = [[UIButton alloc]init];
        [button setBackgroundImage:MyImage(@"icon_inform_binding_login") forState:0];
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(view1.mas_bottom).offset(-20*AdaptiveScale_W);
            make.centerX.mas_equalTo(view1.mas_centerX);
            make.width.mas_equalTo(ScreenW - ShareW*2 - 40);
            make.height.mas_equalTo(60*AdaptiveScale_W);
        }];
        
        
//        XWShareButton * btn1 = [self btnAnimateWithFrame:CGRectMake(LSCREENW/6, LSCREENH-70, 50,50) imageName:@"wxcircle" title:@"朋友圈" animateFrame:CGRectMake(LSCREENW/6, LSCREENH-100, 50, 50) delay:0.1];
//        btn1.tag = 1;
//        [btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        XWShareButton * btn2 = [self btnAnimateWithFrame:CGRectMake((LSCREENW-50)/2, LSCREENH-70, 50, 50) imageName:@"wechat" title:@"好友" animateFrame:CGRectMake((LSCREENW-50)/2, LSCREENH-100, 50, 50) delay:0.1];
//        //img_wechat_friend   img_wechat_logo
//        btn2.tag = 2;
//        [btn2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        XWShareButton * btn3 = [self btnAnimateWithFrame:CGRectMake(LSCREENW*4/6, LSCREENH-70, 50, 50) imageName:@"icon_QRcode" title:@"二维码" animateFrame:CGRectMake(LSCREENW*4/6, LSCREENH-100, 50, 50) delay:0.1];
//        //img_wechat_friend   img_wechat_logo
//        btn3.tag = 3;
//        [btn3 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
//        plus.frame = CGRectMake((LSCREENW-25)/2 ,LSCREENH-25, 25, 25);
//        [plus setImage:[UIImage imageNamed:@"close_share_icon"] forState:UIControlStateNormal];
//        [plus addTarget:self action:@selector(cancelAnimation) forControlEvents:UIControlEventTouchUpInside];
//        plus.tag = 4;
//        [self addSubview:plus];
//        [UIView animateWithDuration:0.2 animations:^{
//            
//            plus.transform = CGAffineTransformMakeRotation(M_PI_2);
//        }];
        
    }
    return self;
}

- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

//- (XWShareButton *)btnAnimateWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title animateFrame:(CGRect)aniFrame delay:(CGFloat)delay
//{
//    XWShareButton * btn = [XWShareButton buttonWithImage:MyImage(imageName) title:title];
//    btn.frame = frame;
//    [self addSubview:btn];
//    
//    [UIView animateWithDuration:1 delay:delay usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        
//        btn.frame  = aniFrame;
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    return btn;
//    
//}

- (void)closeClick
{

    [self removeFromSuperview];

}

-(void)BtnClick:(id)sender
{
    [self removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPosition = [touch locationInView:self];
    
    CGFloat deltaY = currentPosition.y;
    if (deltaY<(ScreenH-ShareH))
    {
        [self cancelAnimation];
    }
}

-(void)cancelAnimation
{
    UIButton * cancelBtn = (UIButton*)[self viewWithTag:1];
    [UIView animateWithDuration:0.2 animations:^{
        
        cancelBtn.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }];
    
    for (NSInteger i = 0; i<self.subviews.count; i++)
    {
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:[UIButton class]])
        {
            [UIView animateWithDuration:0.3 delay:0.1*i options:UIViewAnimationOptionTransitionCurlDown animations:^{
                view.frame = CGRectMake(view.frame.origin.x,view.frame.origin.y, ScreenW - 40 , 180);
            } completion:^(BOOL finished) {
                
                [self removeFromSuperview];
            }];
        }
    }
}


@end
