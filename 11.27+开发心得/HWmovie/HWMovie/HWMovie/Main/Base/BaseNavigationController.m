//
//  BaseNavigationController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
/**
 项目一 中，用AFNetWorking 封装网络接口，完成DataService类，并把数据的获取改成网络获取：
 注意点1：重新获取数据后要刷新页面 ，页面的 刷新在主线程中。
 注意点2：如果用到block ，注意循环引用的问题
 */
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barStyle = UIBarStyleBlack;
    // 导航栏背景图
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all-64"] forBarMetrics:UIBarMetricsDefault];
    // 导航栏透明
    self.navigationBar.translucent = YES;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // return [self.topViewController preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

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
