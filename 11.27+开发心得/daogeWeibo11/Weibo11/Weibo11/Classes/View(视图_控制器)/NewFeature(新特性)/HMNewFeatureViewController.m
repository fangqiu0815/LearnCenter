//
//  HMNewFeatureViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/8.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMNewFeatureViewController.h"
#import "AppDelegate.h"

@interface HMNewFeatureViewController () <UIScrollViewDelegate>
/// 滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;
/// 分页控件
@property (nonatomic, strong) UIPageControl *pageControl;
/// 开始按钮
@property (nonatomic, strong) UIButton *startButton;
/// 分享微博
@property (nonatomic, strong) UIButton *sharedButton;
@end

@implementation HMNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

#pragma mark - 监听方法
/// 点击开始按钮
- (void)clickStartButton {
    DDLogInfo(@"新特性进入主页");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HMSwitchRootViewControllerNotification object:nil];
}

- (void)clickSharedButton {
    self.sharedButton.selected = !self.sharedButton.selected;
}

#pragma mark - UIScrollViewDelegate
/// UIScrollView 停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    // 当前页数
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
}

#pragma mark - 设置界面
- (void)setupUI {
    [self prepareScrollView];
    [self preparePageControl];
    [self prepareLastPage];
}

/// 准备最后一页控件
- (void)prepareLastPage {
    
    UIImageView *imageView = self.scrollView.subviews.lastObject;
    
    imageView.userInteractionEnabled = YES;
    
    [imageView addSubview:self.startButton];
    [imageView addSubview:self.sharedButton];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.bottom.mas_equalTo(-140);
    }];
    
    [self.sharedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.startButton);
        make.bottom.mas_equalTo(self.startButton.mas_top).offset(-20);
    }];
}

/// 准备分页控件
- (void)preparePageControl {
    [self.view addSubview:self.pageControl];
    
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0;
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-80);
    }];
}

/// 准备 UIScrollView
- (void)prepareScrollView {
    [self.view addSubview:self.scrollView];
    
    self.scrollView.frame = self.view.bounds;
    
    // 添加图像视图
    for (int i = 0; i < 4; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%zd", i + 1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        // 设置大小
        imageView.frame = CGRectOffset(self.view.bounds, i * self.view.bounds.size.width, 0);
        
        [self.scrollView addSubview:imageView];
    }
    
    // 设置 contentSize
    self.scrollView.contentSize = CGRectInset(self.view.bounds, -1.5 * self.view.bounds.size.width, 0).size;
}

#pragma mark - 懒加载控件
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.pageIndicatorTintColor = [UIColor blackColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        
        // 提示：需要禁止用户交互，否则用户点击小圆点，会移动，但是页面不会变化
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (UIButton *)startButton {
    if (_startButton == nil) {
        _startButton = [UIButton ff_buttonWithTitle:@"进入主页" titleColor:[UIColor whiteColor] backImageName:@"new_feature_finish_button"];
        
        [_startButton addTarget:self action:@selector(clickStartButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UIButton *)sharedButton {
    if (_sharedButton == nil) {
        _sharedButton = [[UIButton alloc] init];
        
        [_sharedButton setTitle:@" 分享到微博" forState:UIControlStateNormal];
        [_sharedButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [_sharedButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [_sharedButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        
        [_sharedButton sizeToFit];
        
        [_sharedButton addTarget:self action:@selector(clickSharedButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sharedButton;
}

@end
