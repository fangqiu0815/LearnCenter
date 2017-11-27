//
//  HMProfileViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMProfileViewController.h"

@interface HMProfileViewController ()

@end

@implementation HMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIWithImageName:@"visitordiscover_image_profile" message:@"登录后，你的微博、相册、个人资料会显示在这里，展示给别人" logonSuccessedBlock: ^{
        self.tabBarItem.badgeValue = @"88";
    }];
}

@end
