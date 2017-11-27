//
//  HMVisitorView.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMVisitorView.h"

@interface HMVisitorView()
/// 遮罩图像
@property (nonatomic, strong) UIImageView *maskImageView;
/// 图标
@property (nonatomic, strong) UIImageView *iconView;
/// 小房子
@property (nonatomic, strong) UIImageView *homeIconView;
/// 提示标签
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation HMVisitorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

/// 设置访客视图信息
- (void)visitorInfoWithImageName:(NSString *)imageName message:(NSString *)message {
    
    self.messageLabel.text = message;
    
    // 根据图像名称是否为 nil 判断是否首页
    self.homeIconView.hidden = (imageName != nil);
    
    if (imageName != nil) {
        // 设置图标图像
        self.iconView.image = [UIImage imageNamed:imageName];
        
        // 将遮罩视图挪动到底部
        [self sendSubviewToBack:self.maskImageView];
    } else {
        // 首页开始动画
        [self startAnimation];
    }
}

/// 开始旋转图标图像动画
- (void)startAnimation {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    // 旋转角度
    anim.toValue = @(2 * M_PI);
    // 重复次数
    anim.repeatCount = MAXFLOAT;
    // 动画时长
    anim.duration = 20;
    // 动画删除时是否删除
    anim.removedOnCompletion = NO;
    
    [self.iconView.layer addAnimation:anim forKey:nil];
}

#pragma mark - 设置界面
/// 设置界面
- (void)setupUI {
    // 0. 背景颜色
    self.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    
    // 1. 添加控件
    [self addSubview:self.iconView];
    [self addSubview:self.maskImageView];
    [self addSubview:self.homeIconView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.registerButton];
    [self addSubview:self.loginButton];
    
    // 2. 自动布局
    /// 1> 图标
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-40);
    }];
    /// 2> 小房子
    [self.homeIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.iconView);
    }];
    /// 3> 消息
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconView);
        make.top.equalTo(self.iconView.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(224, 35));
    }];
    /// 4> 注册按钮
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageLabel);
        make.top.equalTo(self.messageLabel.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    /// 5> 登录按钮
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.messageLabel);
        make.top.equalTo(self.messageLabel.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    // 6> 遮罩图像
    [self.maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.registerButton.mas_bottom);
    }];
}

#pragma mark - 懒加载控件
/// 遮罩视图
- (UIImageView *)maskImageView {
    if (_maskImageView == nil) {
        _maskImageView = [UIImageView ff_imageViewWithImageName:@"visitordiscover_feed_mask_smallicon"];
    }
    return _maskImageView;
}
/// 图标
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [UIImageView ff_imageViewWithImageName:@"visitordiscover_feed_image_smallicon"];
    }
    return _iconView;
}
/// 小房子
- (UIImageView *)homeIconView {
    if (_homeIconView == nil) {
        _homeIconView = [UIImageView ff_imageViewWithImageName:@"visitordiscover_feed_image_house"];
    }
    return _homeIconView;
}
/// 消息标签
- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [UILabel ff_labelWithTitle:@"登录后，别人评论你的微博，发给你的消息，都会在这里收到通知" color:[UIColor darkGrayColor] fontSize:14];
    }
    return _messageLabel;
}
/// 注册按钮
- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [UIButton ff_buttonWithTitle:@"注册" titleColor:[UIColor orangeColor] backImageName:@"common_button_white_disable"];
    }
    return _registerButton;
}
/// 登录按钮
- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [UIButton ff_buttonWithTitle:@"登录" titleColor:[UIColor darkGrayColor] backImageName:@"common_button_white_disable"];
    }
    return _loginButton;
}

@end
