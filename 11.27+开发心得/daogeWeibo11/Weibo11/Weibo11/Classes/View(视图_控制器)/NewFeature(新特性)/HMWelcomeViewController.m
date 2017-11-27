//
//  HMWelcomeViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/8.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMWelcomeViewController.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HMWelcomeViewController ()
/// 用户头像
@property (nonatomic, strong) UIImageView *iconView;
/// 欢迎标签
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation HMWelcomeViewController

- (void)loadView {
    self.view = [UIImageView ff_imageViewWithImageName:@"ad_background"];
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载图像
    // - 注意：一定要设置 placeholderImage，否则联网加载图像时，不会显示默认图像
    [self.iconView sd_setImageWithURL:[HMUserAccountViewModel sharedUserAccount].avatarURL
                     placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-(self.view.center.y + 100));
    }];
    self.messageLabel.alpha = 0;
    
    // 图片动画
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        // 标签动画
        [UIView animateWithDuration:0.5 animations:^{
            self.messageLabel.alpha = 1;
        } completion:^(BOOL finished) {
            DDLogInfo(@"欢迎界面完成");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HMSwitchRootViewControllerNotification object:nil];
        }];
    }];
}

#pragma mark - 设置界面
- (void)setupUI {
    // 1. 添加控件
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.messageLabel];
    
    // 2. 自动布局
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(-160);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconView);
        make.top.equalTo(self.iconView.mas_bottom).offset(12);
    }];
}

#pragma mark - 懒加载控件
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.cornerRadius = 45;
    }
    return _iconView;
}

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [UILabel ff_labelWithTitle:@"欢迎归来" color:[UIColor darkGrayColor] fontSize:18];
    }
    return _messageLabel;
}

@end
