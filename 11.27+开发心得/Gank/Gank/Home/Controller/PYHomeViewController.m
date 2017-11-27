//
//  PYHomeViewController.m
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYHomeViewController.h"
#import <pop/POP.h>
#import "PYPageTitleView.h"
#import "UIColor+PYExtension.h"
#import "UIView+PYExtension.h"
#import "PYCardViewController.h"
#import "PYPageTitleContentView.h"
#import "PYCalendarView.h"
#import "CardCellCollectionViewCell.h"
#import "PYWebController.h"
#import "PYResource.h"
#import "UIBarButtonItem+PYExtension.h"
#import <PYSearch/PYSearch.h>
#import <PYSearch/PYSearchConst.h>
#import "PYSearchResultViewController.h"

#define PYCOLORPolRandomColor self.colorPol[arc4random_uniform((uint32_t)self.colorPol.count)] // 随机选取颜色池中的颜色

@interface PYHomeViewController () <UIScrollViewDelegate, PYPageTitleContentViewDelegate>

/** pageTitleContentView */
@property (nonatomic, weak) PYPageTitleContentView *pageTitleContentView;

/** 用来执行动画的view */
@property (nonatomic, weak) UIView *animationView;
/** 最基础的scrollView */
@property (nonatomic, weak) UIScrollView *baseScrollView;

/** 调节控制器背景色池 */
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorPol;
/** 当前选中的下标 */
@property (nonatomic, assign) NSInteger selectedIndex;
/** 分页标题 */
@property (nonatomic, copy) NSArray<NSString *> *pageTitles;
/** 分页标题配图 */
@property (nonatomic, copy) NSArray<NSString *> *pageTitleImageNames;

@end

@implementation PYHomeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置UI
    [self setupUI];
    
    // 默认选中第1个
    [self selectedPageTitleView:0];
    
    // 添加加载内容详情通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadResourceDetail:) name:PYCarDeatilViewCellDidSelectedNotification object:nil];
}

#pragma mark - setupUI
- (void)setupUI
{
    // 设置标签
    [self setupPageTitleView];
    // 设置内容
    [self setupBaseScrollView];
    // 添加子控制器
    [self setupChildControllers];
    // 设置标题
    [self setupTitleLabel];
    
    [self.view bringSubviewToFront:self.pageTitleContentView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置透明导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"clearImage"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"clearImage"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem py_itemWithViewController:self action:@selector(showMenu) image:@"list_normal" highlightImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem py_itemWithViewController:self action:@selector(search) image:@"search_normal" highlightImage:nil];
}

- (void)showMenu {
    [self.sideMenuController showMenu];
}

- (void)search
{
    uitex
    // 点击搜索
    PYSearchViewController *searchVC = [PYSearchViewController searchViewControllerWithHotSearches:self.pageTitles searchBarPlaceholder:@"搜你所想" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        ((PYSearchResultViewController *)searchViewController.searchResultController).searchText = searchText;
    }];
    searchVC.searchResultShowMode = PYSearchResultShowModeEmbed;
    searchVC.searchResultController = [[PYSearchResultViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    nav.navigationBar.tintColor = PYSEARCH_COLOR(159, 159, 159);
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 懒加载
- (NSArray<NSString *> *)pageTitleImageNames
{
    if (!_pageTitleImageNames) {
        _pageTitleImageNames = @[@"ios", @"android", @"front", @"recommend", @"expand", @"app", @"video"];
    }
    return _pageTitleImageNames;
}

- (NSArray<NSString *> *)pageTitles
{
    if (!_pageTitles) {
        _pageTitles = @[@"iOS", @"Android", @"前端", @"瞎推荐", @"拓展资源", @"App", @"休息视频"];
    }
    return _pageTitles;
}

-(UIView *)animationView
{
    if (!_animationView) {
        UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        animationView.backgroundColor = [UIColor greenColor];
        
        [self.view addSubview:animationView];
        _animationView = animationView;
    }
    return _animationView;
}

- (NSMutableArray *)colorPol
{
    if (!_colorPol) {
        NSArray *colorStrPol = @[@"000000", @"1296db", @"ff4100", @"feaf36", @"6600FF", @"663300",  @"d81e06"];
        NSMutableArray *colorPolM = [NSMutableArray array];
        for (NSString *colorStr in colorStrPol) {
            UIColor *color = [UIColor py_colorWithHexString:colorStr];
            [colorPolM addObject:color];
        }
        _colorPol = colorPolM;
    }
    return _colorPol;
}

#pragma mark - loadResourceDetail
- (void)loadResourceDetail:(NSNotification *)noti
{
    // 获取链接
    PYResource *resource = noti.userInfo[PYCarDeatilViewCellResourceKey];
    // 取出背景色
    UIColor *bgColor = noti.userInfo[PYCarDeatilViewCellBackgroundKey];
    // 加载网页
    PYWebController *webVC = [[PYWebController alloc] init];
    webVC.url = resource.url;
    webVC.progressColor = bgColor;
    webVC.resource = resource;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.navigationItem.titleView = titleLabel;
}

/**
 * 添加子子控制器
 */
- (void)setupChildControllers
{
    for (int i = 0; i < PYPageTitleCount; i++) {
        // 添加子控制器
        PYCardViewController *carViewController = [[PYCardViewController alloc] init];
        carViewController.resourceType = self.pageTitles[i];
        carViewController.view.frame = self.baseScrollView.bounds;
        carViewController.view.py_x = 5;
        carViewController.view.py_width = self.baseScrollView.py_width - 2 * carViewController.view.py_x;
        carViewController.view.layer.cornerRadius = 5;
        [self addChildViewController:carViewController];
    }
}

/**
 * 添加最基础的scrollView
 */
- (void)setupBaseScrollView
{
    UIScrollView *baseScrollView = [[UIScrollView  alloc] init];
    CGFloat x = 0;
    CGFloat y = 70;
    CGFloat w = PYScreenW - x * 2;
    CGFloat h = self.pageTitleContentView.py_y - y;
    baseScrollView.backgroundColor = [UIColor clearColor];
    baseScrollView.frame = CGRectMake(x, y, w, h);
    baseScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    baseScrollView.contentSize = CGSizeMake(baseScrollView.py_width * PYPageTitleCount, 0);
    baseScrollView.showsHorizontalScrollIndicator = NO;
    // 自动分页
    baseScrollView.pagingEnabled = YES;
    // 设置代理
    baseScrollView.delegate = self;
    [self.view addSubview:baseScrollView];
    self.baseScrollView = baseScrollView;
}

- (void)setupPageTitleView
{
    PYPageTitleContentView *pageTitleContentView = [[PYPageTitleContentView alloc] init];
    pageTitleContentView.delegate = self;
    [self.view addSubview:pageTitleContentView];
    self.pageTitleContentView = pageTitleContentView;
    NSInteger pageTitleViewCount = PYPageTitleCount;
    CGFloat margin = 5 / 2.0 * [UIScreen mainScreen].scale;
    CGFloat width = (self.view.bounds.size.width - margin * (pageTitleViewCount + 1)) / pageTitleViewCount;
    CGFloat height = width * 1.72;
    pageTitleContentView.frame = CGRectMake(0, self.view.bounds.size.height - height + 20, self.view.bounds.size.width, height);
    // 获取图片资源
    NSArray *imageNames = self.pageTitleImageNames;
    for (NSInteger i = 0; i < pageTitleViewCount; i++) {
        CGFloat x = i * (margin + width) + margin;
        CGFloat y = 10;
        PYPageTitleView *pageTitleView = [[PYPageTitleView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        pageTitleView.pageTitleImageView.image = [UIImage imageNamed:imageNames[i]];
        pageTitleView.tag = i;
        pageTitleView.backgroundColor = [UIColor whiteColor];
        [pageTitleContentView addSubview:pageTitleView];
    }
}

- (void)selectedPageTitleView:(NSInteger)index
{
    // 避免数组越界
    index = MIN(index, PYPageTitleCount-1);
    for (UIView *subView in [self.pageTitleContentView subviews]) {
        PYPageTitleView *pageTitleView = (PYPageTitleView *)subView;
        [pageTitleView touchEnd:index];
        // 设置控制器背景色
        self.view.backgroundColor = self.colorPol[index];
        self.sideMenuController.view.backgroundColor = self.view.backgroundColor;
        // 设置标题
        ((UILabel *)(self.navigationItem.titleView)).text = self.pageTitles[index];
    }
    // 添加相应的子控制器的view
    self.baseScrollView.contentOffset = CGPointMake(self.baseScrollView.py_width * index, self.baseScrollView.contentOffset.y);
    PYCardViewController *selectedVC = self.childViewControllers[index];
    selectedVC.typeColor = self.view.backgroundColor;
    UIScrollView *childVcView = (UIScrollView *)selectedVC.view;
    childVcView.py_x = self.baseScrollView.contentOffset.x;
    self.selectedIndex = index;
    [self.baseScrollView addSubview:childVcView];
}

#pragma  mark UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 计算偏移量获取下标
    NSInteger index = scrollView.contentOffset.x / scrollView.py_width;
    // 选中
    [self selectedPageTitleView:index];
    // 调用消失方法
    // 取出消失控制器
    for (UIViewController *childController in self.childViewControllers) {
        if (childController != self.childViewControllers[_selectedIndex]) {
            [childController viewWillDisappear:YES];
        } else {
            [childController viewWillAppear:YES];
        }
    }
}

// 开始减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - PYPageTitleContentViewDelegate
- (void)pageTitleContentView:(PYPageTitleContentView *)pageTitleContentView selectedPageTitleView:(NSInteger)index
{
    [self selectedPageTitleView:index];
}

#pragma mark - YQContentViewControllerDelegate
- (void)didHiddenMenu
{
    self.navigationController.navigationBar.alpha = 1.0;
    self.pageTitleContentView.alpha = 1.0;
    self.navigationController.navigationBar.hidden = NO;
    self.pageTitleContentView.hidden = NO;
}

- (void)didShowMenu
{
    [UIView animateWithDuration:0.15 animations:^{
        self.navigationController.navigationBar.alpha = 0.0;
        self.pageTitleContentView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.navigationController.navigationBar.hidden = YES;
        self.pageTitleContentView.hidden = YES;
    }];
}

@end

