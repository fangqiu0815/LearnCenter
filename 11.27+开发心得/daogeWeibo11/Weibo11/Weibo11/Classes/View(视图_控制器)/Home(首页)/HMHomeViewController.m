//
//  HMHomeViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMHomeViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HMTempViewController.h"
#import "HMStatusCell.h"
#import "HMStatusListViewModel.h"
#import "HMRefreshControl.h"

#define kStatusNormalCellID @"kStatusNormalCellID"

@interface HMHomeViewController ()
/// 微博列表视图模型
@property (nonatomic, strong) HMStatusListViewModel *statusListViewModel;
/// 上拉刷新视图
@property (nonatomic, strong) UIActivityIndicatorView *pullupView;
/// 下拉刷新控件
@property (nonatomic, strong) HMRefreshControl *pulldownRefreshControl;
/// 下拉提示标签
@property (nonatomic, strong) UILabel *pulldownTipLabel;
@end

@implementation HMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIWithImageName:nil message:@"关注一些人，回这里看看有什么惊喜" logonSuccessedBlock:^{
        
        // 设置导航栏按钮
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:nil imageName:@"navigationbar_friendsearch" target:self action:@selector(friendSearch)];
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:nil imageName:@"navigationbar_pop" target:nil action:nil];
        
        // 准备表格
        [self prepareTableView];
        
        // 加载数据
        [self loadData];
    }];
}

/// 准备表格
- (void)prepareTableView {
    [self.tableView registerClass:[HMStatusCell class] forCellReuseIdentifier:kStatusNormalCellID];
    
    // 设置行高
    self.tableView.estimatedRowHeight = 300;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 取消分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置上拉提示视图
    self.tableView.tableFooterView = self.pullupView;
    // 设置下拉刷新控件
    self.pulldownRefreshControl = [[HMRefreshControl alloc] init];
    [self.tableView addSubview:self.pulldownRefreshControl];
    [self.pulldownRefreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - 监听方法
- (void)friendSearch {
    HMTempViewController *vc = [[HMTempViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 加载数据
/// 加载数据
- (void)loadData {
    
    [self.statusListViewModel loadStatusWith:self.pullupView.isAnimating completed:^(BOOL isSuccessed) {
        // 停止上拉刷新控件
        [self.pullupView stopAnimating];
        // 停止下拉刷新
        [self.pulldownRefreshControl endRefreshing];
        
        if (!isSuccessed) {
            DDLogError(@"加载数据错误");
            [SVProgressHUD showInfoWithStatus:@"您的网络不给力" maskType:SVProgressHUDMaskTypeGradient];
            return;
        }
        
        // 显示下拉刷新数量提示
        [self showPullDownTips];
        
        // 刷新表格
        [self.tableView reloadData];
    }];
}

/// 显示下拉刷新提示标签
- (void)showPullDownTips {
    if (self.statusListViewModel.pulldownTipMesage == nil) {
        return;
    }
    
    // 设置文字
    self.pulldownTipLabel.text = self.statusListViewModel.pulldownTipMesage;
    
    // 设置位置
    CGRect rect = self.navigationController.navigationBar.bounds;
    CGFloat height = rect.size.height;
    self.pulldownTipLabel.frame = CGRectOffset(rect, 0, -2 * height);
    
    // 动画
    [UIView animateWithDuration:1.0 animations:^{
        self.pulldownTipLabel.frame = CGRectOffset(rect, 0, height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.pulldownTipLabel.frame = CGRectOffset(rect, 0, -2 * height);
        }];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusListViewModel.statusList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:kStatusNormalCellID forIndexPath:indexPath];
    
    HMStatusViewModel *viewModel = self.statusListViewModel.statusList[indexPath.row];
    
    cell.viewModel = viewModel;
    
    return cell;
}

/// Cell 将要显示 - 如果当前将要显示的是最后一行，就去加载上拉刷新数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == (self.statusListViewModel.statusList.count - 1) && !self.pullupView.isAnimating)  {
        DDLogInfo(@"加载最后一条数据");
        // 设置上拉刷新状态
        [self.pullupView startAnimating];
        
        // 加载数据
        [self loadData];
    }
}

#pragma mark - 懒加载属性
- (HMStatusListViewModel *)statusListViewModel {
    if (_statusListViewModel == nil) {
        _statusListViewModel = [[HMStatusListViewModel alloc] init];
    }
    return _statusListViewModel;
}

- (UIActivityIndicatorView *)pullupView {
    if (_pullupView == nil) {
        _pullupView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

        _pullupView.color = [UIColor darkGrayColor];
    }
    return _pullupView;
}

- (UILabel *)pulldownTipLabel {
    if (_pulldownTipLabel == nil) {
        _pulldownTipLabel = [[UILabel alloc] init];
        
        _pulldownTipLabel.backgroundColor = [UIColor orangeColor];
        _pulldownTipLabel.textColor = [UIColor whiteColor];
        _pulldownTipLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.navigationController.navigationBar insertSubview:_pulldownTipLabel atIndex:0];
    }
    return _pulldownTipLabel;
}

@end
