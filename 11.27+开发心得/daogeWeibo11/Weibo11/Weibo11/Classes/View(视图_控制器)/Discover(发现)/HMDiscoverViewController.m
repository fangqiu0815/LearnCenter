//
//  HMDiscoverViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMDiscoverViewController.h"
#import "HMDiscoverSearchView.h"
#import <objc/runtime.h>

@interface HMDiscoverViewController ()
@property (nonatomic, strong) HMDiscoverSearchView *searchView;
@end

@implementation HMDiscoverViewController
static UIView *_findView = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIWithImageName:@"visitordiscover_image_message" message:@"登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过" logonSuccessedBlock: ^ {
        
        // 设置搜索视图
        self.searchView = [[HMDiscoverSearchView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen ff_screenSize].width, 35)];
        self.navigationItem.titleView = self.searchView;
        
        self.tabBarItem.badgeValue = @"99";
        
        [self setupBadgeBackground];
    }];
}

/// 设置 Badge 数字的背景图片
- (void)setupBadgeBackground {
    // 查找 _UIBadgeView
    UIView *badgeView = [UIView ff_firstInView:self.tabBarController.tabBar clazzName:@"_UIBadgeBackground"];
    NSLog(@"最终结果 %@", badgeView);
    // 测试内部成员变量列表
    [badgeView ff_ivarsList];
    
    // 设置背景图片
    [badgeView setValue:[UIImage imageNamed:@"main_badge"] forKey:@"_image"];
}

@end
