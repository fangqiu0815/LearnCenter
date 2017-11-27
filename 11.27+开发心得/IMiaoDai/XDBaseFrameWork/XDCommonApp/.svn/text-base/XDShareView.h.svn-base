//
//  XDShareView.h
//  XDCommonApp
//
//  Created by XD-XY on 4/10/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XDShareViewDelegate <NSObject>

-(void)shareViewBtnCLick:(UIButton *)button;

@end

@interface XDShareView : UIView
{
    CGFloat aheight;
}

@property(nonatomic,assign)id<XDShareViewDelegate>delegate;
@property(nonatomic,strong)UIView * hview;
@property(nonatomic,strong)UIView * Bgview;
@property(nonatomic,strong)UIButton * wxBtn;
@property(nonatomic,strong)UIButton * xlBtn;
@property(nonatomic,strong)UIButton * canelBtn;

-(void)setViewShow;
-(void)setViewHidden;

@end
