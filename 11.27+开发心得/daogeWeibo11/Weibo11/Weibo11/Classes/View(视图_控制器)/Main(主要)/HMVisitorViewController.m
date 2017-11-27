//
//  HMVisitorViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMVisitorViewController.h"
#import "HMVisitorView.h"
#import "HMOAuthViewController.h"

@interface HMVisitorViewController ()
/// 用户登录标记
@property (nonatomic, assign) BOOL userLogon;
/// 访客视图
@property (nonatomic, strong) HMVisitorView *visitorView;
@end

@implementation HMVisitorViewController

- (void)loadView {
    
    self.userLogon = [HMUserAccountViewModel sharedUserAccount].isLogon;
    self.userLogon ? [super loadView] : [self setupVisitorView];
}

#pragma mark - 监听方法
/// 点击注册按钮
- (void)clickRegisterButton {
    NSLog(@"点击注册按钮");
}

/// 点击登录按钮
- (void)clickLoginButton {
    
    HMOAuthViewController *vc = [[HMOAuthViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 设置界面
/// 设置访客视图
- (void)setupVisitorView {
    self.visitorView = [[HMVisitorView alloc] init];
    
    self.view = self.visitorView;
}

/// 设置界面
- (void)setupUIWithImageName:(NSString *)imageName message:(NSString *)message logonSuccessedBlock:(void (^)())logonSuccessedBlock {
    
    // 设置未登录的导航栏信息
    if (!self.userLogon) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:@"注册" imageName:nil target:self action:@selector(clickRegisterButton)];
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:@"登录" imageName:nil target:self action:@selector(clickLoginButton)];
        
        // 设置访客视图
        [self.visitorView visitorInfoWithImageName:imageName message:message];
        
        // 添加按钮监听方法
        [self.visitorView.registerButton addTarget:self action:@selector(clickRegisterButton) forControlEvents:UIControlEventTouchUpInside];
        [self.visitorView.loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    } else if (logonSuccessedBlock != nil) {
        logonSuccessedBlock();
    }
}

@end
