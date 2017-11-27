//
//  HMTempViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMTempViewController.h"

@interface HMTempViewController ()

@end

@implementation HMTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"第 %zd 级页面", self.navigationController.childViewControllers.count];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:@"PUSH" imageName:nil target:self action:@selector(push)];
}

#pragma mark - 监听方法
/// 再次 PUSH 当前控制器
- (void)push {
    HMTempViewController *vc = [[HMTempViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
