//
//  XWHomePublishView.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomePublishView.h"
#define LSCREENH [UIScreen mainScreen].bounds.size.height
#define LSCREENW [UIScreen mainScreen].bounds.size.width
#define ShareH 120
#import "XWShareButton.h"
@interface XWHomePublishView ()


@end
@implementation XWHomePublishView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, LSCREENH-ShareH, LSCREENW, ShareH)];
        view1.backgroundColor = [UIColor whiteColor];
        [self addSubview:view1];
        
        // 最顶上的label
        UILabel *label = [[UILabel alloc]init];
        label.text = @"请选择您要分享平台";
        label.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        label.textColor = BlackColor;
        label.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(5);
            make.width.mas_equalTo(ScreenW*0.5);
            make.height.mas_equalTo(20);
        }];
        
        XWShareButton * btn1 = [self btnAnimateWithFrame:CGRectMake(LSCREENW/4-30, LSCREENH-70, 50,50) imageName:@"wxcircle" title:@"朋友圈" animateFrame:CGRectMake(LSCREENW/4-30, LSCREENH-100, 50, 50) delay:0.0];
        btn1.tag = 1;
        [btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        XWShareButton * btn2 = [self btnAnimateWithFrame:CGRectMake((LSCREENW/4)*3-30, LSCREENH-70, 50, 50) imageName:@"wechat" title:@"好友" animateFrame:CGRectMake((LSCREENW/4)*3-30, LSCREENH-100, 50, 50) delay:0.1];
        //img_wechat_friend   img_wechat_logo
        btn2.tag = 2;
        [btn2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
        plus.frame = CGRectMake((LSCREENW-25)/2 ,LSCREENH-25, 25, 25);
        [plus setImage:[UIImage imageNamed:@"close_share_icon"] forState:UIControlStateNormal];
        [plus addTarget:self action:@selector(cancelAnimation) forControlEvents:UIControlEventTouchUpInside];
        plus.tag = 3;
        [self addSubview:plus];
        [UIView animateWithDuration:0.2 animations:^{
            
            plus.transform = CGAffineTransformMakeRotation(M_PI_2);
        }];
        
        
    }
    return self;
}
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}
- (XWShareButton *)btnAnimateWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title animateFrame:(CGRect)aniFrame delay:(CGFloat)delay
{
    XWShareButton * btn = [XWShareButton buttonWithImage:MyImage(imageName) title:title];
    btn.frame = frame;
    [self  addSubview:btn];
    
    [UIView animateWithDuration:1 delay:delay usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        btn.frame  = aniFrame;
        
    } completion:^(BOOL finished) {
        
    }];
    return btn;
    
}
-(void)BtnClick:(XWShareButton *)btn
{
    for (NSInteger i = 0; i<self.subviews.count; i++)
    {
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:[UIButton class]])
        {
            [UIView animateWithDuration:0.3 delay:0.1*i options:UIViewAnimationOptionTransitionCurlDown animations:^{
                view.frame = CGRectMake(view.frame.origin.x, LSCREENH, 50, 50);
            } completion:^(BOOL finished) {
            }];
        }
    }
    
    [self performSelector:@selector(removeView:) withObject:btn afterDelay:0.5];
    
}
-(void)removeView:(UIButton*)btn
{
    [self removeFromSuperview];
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPosition = [touch locationInView:self];
    
    CGFloat deltaY = currentPosition.y;
    if (deltaY<(LSCREENH-ShareH))
    {
        [self cancelAnimation];
    }
}

-(void)cancelAnimation
{
    UIButton * cancelBtn = (UIButton*)[self viewWithTag:3];
    [UIView animateWithDuration:0.2 animations:^{
        
        cancelBtn.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }];
    
    for (NSInteger i = 0; i<self.subviews.count; i++)
    {
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:[UIButton class]])
        {
            [UIView animateWithDuration:0.3 delay:0.1*i options:UIViewAnimationOptionTransitionCurlDown animations:^{
                view.frame = CGRectMake(view.frame.origin.x, LSCREENH, 50, 50);
            } completion:^(BOOL finished) {
                
                [self removeFromSuperview];
            }];
        }
    }
}


@end
