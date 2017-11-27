//
//  MainTabBarController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "MainTabBarController.h"

#import "MovieViewController.h"
#import "NewsViewController.h"
#import "TopViewController.h"
#import "CinemaViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"

#import "HWButton.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createViewControllers];
    [self _setTabBar];
}

- (void)_createViewControllers {
    // 第三级控制器
    MovieViewController *movieViewController = [[MovieViewController alloc] init];
    NewsViewController *newsViewController = [[NewsViewController alloc] init];
    TopViewController *topViewController = [[TopViewController alloc] init];
    CinemaViewController *cinemaViewController = [[CinemaViewController alloc] init];
    MoreViewController *moreViewController = [[MoreViewController alloc] init];
    NSArray *vcArray = @[movieViewController,newsViewController,topViewController,cinemaViewController,moreViewController];
    
    // 第二级控制器
    NSMutableArray *navArray = [NSMutableArray array];
    for (NSInteger i = 0; i < vcArray.count; i++) {
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vcArray[i]];
        [navArray addObject:nav];
    }
    
    self.viewControllers = navArray;
    
}

- (void)_setTabBar {
    // 01 tabBar.subviews移除
    Class cls = NSClassFromString(@"UITabBarButton");
    for (UIView *subView in self.tabBar.subviews) {
//        NSLog(@"%@",[self.tabBar.subviews[0] class]);  //UITabBarButton
        if ([subView isKindOfClass:cls]) {
            
            [subView removeFromSuperview];
        }
    }
    
    // 02 tabBar背景
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg_all"]];
    // tabBar透明
    self.tabBar.translucent = YES;
    
    CGFloat tabBarButtonWidth = CGRectGetWidth(self.tabBar.frame)/5;
    CGFloat tabBarButtonHeight = CGRectGetHeight(self.tabBar.frame);
    // 03 设置选中阴影
    _selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tabBarButtonWidth, tabBarButtonHeight)];
    _selectedImg.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    [self.tabBar addSubview:_selectedImg];
    
    // 04 tabBar.subviews -> 按钮添加
    NSArray *buttonImageNames = @[@"movie_home.png",@"msg_new.png",@"start_top250.png",@"icon_cinema.png",@"more_setting.png"];
    NSArray *buttonNames = @[@"电影",@"新闻",@"Top",@"影院",@"更多"];
    
//    for (NSInteger i = 0; i < self.viewControllers.count; i++) {
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*tabBarButtonWidth, 0, tabBarButtonWidth, tabBarButtonHeight)];
//        button.tag = i;
//        [button setTitle:buttonNames[i] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:11];
//        [button setImage:[UIImage imageNamed:buttonImageNames[i]] forState:UIControlStateNormal];
//        // CGFloat top, left, bottom, right;
//        button.titleEdgeInsets = UIEdgeInsetsMake(30, -18, 0, 0);
//        button.imageEdgeInsets = UIEdgeInsetsMake(-10, 24, 0, 0);
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:button];
//    }
    
    for (NSInteger i = 0; i < self.viewControllers.count; i++) {
        
        HWButton *button = [[HWButton alloc] initWithFrame:CGRectMake(i*tabBarButtonWidth, 0, tabBarButtonWidth, tabBarButtonHeight) withImgName:buttonImageNames[i] withTitle:buttonNames[i]];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
        
    }
    
}

- (void)buttonAction:(UIButton *)button {
    self.selectedIndex = button.tag;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    _selectedImg.center = button.center;
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
