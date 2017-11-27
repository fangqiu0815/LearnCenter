//
//  HMMainViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMMainViewController.h"
#import "HMNavigationController.h"
#import "HMHomeViewController.h"
#import "HMMessageViewController.h"
#import "HMDiscoverViewController.h"
#import "HMProfileViewController.h"
#import "HMComposeTypeView.h"
#import "HMUserAccountViewModel.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface HMMainViewController ()
/// 撰写按钮
@property (nonatomic, strong) UIButton *composeButton;
@end

@implementation HMMainViewController

#pragma mark - 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewControllers];
    
    // 隐藏 tabBar 上方分隔线的做法 － 现在有些应用程序的自定义 TabBar 会遇到，分享一下 :D
    self.tabBar.shadowImage = [[UIImage alloc] init];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self setupComposeButton];
}

#pragma mark - 监听方法
/// 点击撰写按钮
- (void)clickComposeButton {

    // 判断用户是否登录
//    if (![HMUserAccountViewModel sharedUserAccount].isLogon) {
//        [SVProgressHUD showInfoWithStatus:@"请先登录" maskType:SVProgressHUDMaskTypeGradient];
//        
//        return;
//    }
    
    // 实例化撰写类型视图
    HMComposeTypeView *composeView = [[HMComposeTypeView alloc] initWithSelectedComposeType:^(HMComposeType *type) {
        
        DDLogInfo(@"选中撰写标题: %@ - 类名: %@", type.title, type.controllerName);

        if (type.controllerName != nil) {
            Class cls = NSClassFromString(type.controllerName);
            
            // 判断类名是否存在
            if (cls == nil) {
                return;
            }
            
            UIViewController *vc = [[cls alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }];
    
    // 在当前视图中显示
    [composeView showInView:self.view];
}

#pragma mark - 设置 UI
/// 设置撰写按钮位置
- (void)setupComposeButton {

    CGRect rect = self.tabBar.bounds;
    CGFloat w = rect.size.width / self.childViewControllers.count - 1;
    
    self.composeButton.frame = CGRectInset(rect, 2 * w, 0);
}

#pragma mark - 设置子控制器
/// 添加所有子控制器
- (void)addChildViewControllers {
    
    // 设置 tabBar 的 tintColor
    self.tabBar.tintColor = [UIColor orangeColor];
    
    // 添加子控制器
    [self addChildViewController:[[HMHomeViewController alloc] init] title:@"首页" imageName:@"tabbar_home"];
    [self addChildViewController:[[HMMessageViewController alloc] init] title:@"消息" imageName:@"tabbar_message_center"];
    
    // 添加一个空白控制器
    [self addChildViewController:[[UIViewController alloc] init]];
    
    [self addChildViewController:[[HMDiscoverViewController alloc] init] title:@"发现" imageName:@"tabbar_discover"];
    [self addChildViewController:[[HMProfileViewController alloc] init] title:@"我" imageName:@"tabbar_profile"];
}

/// 添加子控制器
///
/// @param childController 子控制器
/// @param title           标题
/// @param imageName       图像名称
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName {
    
    // 设置标题
    childController.title = title;
    
    // 通过 AttributeText 设置字体属性
    // 设置字体颜色
    // [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateHighlighted];
    // 设置字体大小
    // [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]} forState:UIControlStateNormal];
    
    // 设置图像
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    NSString *selectedImageName = [NSString stringWithFormat:@"%@_selected", imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 添加子控制器
    HMNavigationController *nav = [[HMNavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}

#pragma mark - 懒加载控件
/// 撰写按钮
- (UIButton *)composeButton {
    if (_composeButton == nil) {
        _composeButton = [[UIButton alloc] init];
        
        // 设置按钮图像
        [_composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [_composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        // 添加到 tabBar
        [self.tabBar addSubview:_composeButton];
        
        // 添加按钮监听方法
        [_composeButton addTarget:self action:@selector(clickComposeButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _composeButton;
}

@end
