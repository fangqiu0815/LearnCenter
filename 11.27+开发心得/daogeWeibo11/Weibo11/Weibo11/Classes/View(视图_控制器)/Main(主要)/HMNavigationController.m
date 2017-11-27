//
//  HMNavigationController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMNavigationController.h"

@interface HMNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation HMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 在根控制器器如果在右侧按住向右滑动，然后再点击 PUSH 按钮，则无法 PUSH 出新的控制器
    // 解决办法
    // 1. 设置 interactivePopGestureRecognizer 的代理
    // 2. 实现代理方法，并且在根视图控制器时不支持手势返回
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        // 判断子控制器的数量
        NSString *title = @"返回";
        
        if (self.childViewControllers.count == 1) {
            title = self.childViewControllers.firstObject.title;
        }
        
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:title imageName:@"navigationbar_back_withtext" target:self action:@selector(goBack)];
        
        // 隐藏底部的 TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate
/// 手势识别将要开始
///
/// @param gestureRecognizer 手势识别
///
/// @return 返回 NO，放弃当前识别到的手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 如果是根视图控制器，则不支持手势返回
    return self.childViewControllers.count > 1;
}

#pragma mark - 监听方法
/// 返回上级视图控制器
- (void)goBack {
    [self popViewControllerAnimated:YES];
}

@end
