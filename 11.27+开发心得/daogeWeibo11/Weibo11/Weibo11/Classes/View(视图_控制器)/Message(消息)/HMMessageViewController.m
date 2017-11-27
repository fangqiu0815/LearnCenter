//
//  HMMessageViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMMessageViewController.h"
#import "HMTempViewController.h"

@interface HMMessageViewController ()

@end

@implementation HMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIWithImageName:@"visitordiscover_image_message" message:@"登录后，别人评论你的微博，发给你的消息，都会在这里收到通知" logonSuccessedBlock:^{
        
        // 设置导航栏按钮
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:@"发现群"
                                                                             imageName:nil
                                                                                target:self
                                                                                action:@selector(discoverGroup)];
    }];
}

#pragma mark - 监听方法
/// 发现群
- (void)discoverGroup {
    
    HMTempViewController *vc = [[HMTempViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
