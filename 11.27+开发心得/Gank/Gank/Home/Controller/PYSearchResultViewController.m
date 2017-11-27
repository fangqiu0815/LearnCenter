//
//  PYSearchResultViewController.m
//  Gank
//
//  Created by 谢培艺 on 2017/3/7.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYSearchResultViewController.h"
#import <AFHTTPSessionManager.h>
#import "PYResource.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "PYSearchResourceCell.h"
#import "PYWebController.h"
#import "PYHUD.h"

@interface PYSearchResultViewController ()

/** 搜索结果 */
@property (nonatomic, strong) NSMutableArray<PYResource *> *searchResources;
/** 当前页数 */
@property (nonatomic, assign) NSInteger currentPage;
/** 搜索结果为空 */
@property (nonatomic, strong) PYHUD *emptyResultView;

/** 网络加载失败提示 */
@property (nonatomic, strong) PYHUD *loadFailView;
/** 网络加载提示 */
@property (nonatomic, strong) PYHUD *loadingView;
/** 记录当前网络状态 */
@property (nonatomic, assign) AFNetworkReachabilityStatus currentNetworkStatus;
/** 类型 */
@property (nonatomic, copy) NSArray<NSString *> *types;

@end

@implementation PYSearchResultViewController

- (PYHUD *)emptyResultView
{
    if (!_emptyResultView) {
        PYHUD *emptyResultView = [[PYHUD alloc]initWithFrame:CGRectMake(15, 5, self.view.bounds.size.width - 10, self.view.bounds.size.height)];
        emptyResultView.indicatorBackGroundColor = [UIColor clearColor];
        emptyResultView.messageLabel.text = @"换个词、有惊喜！";
        emptyResultView.backgroundColor = [UIColor whiteColor];
        emptyResultView.customImage = [UIImage imageNamed:@"empty"];
        _emptyResultView = emptyResultView;
    }
    return _emptyResultView;
}

- (PYHUD *)loadFailView
{
    if (!_loadFailView) {
        PYHUD *loadFailView = [[PYHUD alloc]initWithFrame:CGRectMake(15, 5, self.view.bounds.size.width - 10, self.view.bounds.size.height)];
        loadFailView.indicatorBackGroundColor = [UIColor clearColor];
        loadFailView.messageLabel.text = @"网络迷路了...\n快点我刷新下";
        loadFailView.backgroundColor = [UIColor whiteColor];
        loadFailView.customImage = [UIImage imageNamed:@"networkError"];
        __weak typeof(self) weakSelf = self;
        [loadFailView refreshWhenNwrworkError:^(PYHUD *hud) {
            [weakSelf loadMoreData:self.searchResources.count == 0];
        }];
        _loadFailView = loadFailView;
    }
    return _loadFailView;
}

- (PYHUD *)loadingView
{
    if (!_loadingView) {
        PYHUD *loadingView = [[PYHUD alloc]initWithFrame:self.view.bounds];
        loadingView.indicatorBackGroundColor = [UIColor clearColor];
        loadingView.indicatorForegroundColor = [UIColor darkGrayColor];
        loadingView.messageLabel.text = nil;
        loadingView.backgroundColor = [UIColor whiteColor];
        _loadingView = loadingView;
    }
    return _loadingView;
}

- (NSMutableArray *)searchResources
{
    if (!_searchResources) {
        _searchResources = [NSMutableArray array];
    }
    return _searchResources;
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText copy];
    [self.searchResources removeAllObjects];
    [self.tableView reloadData];
    // 刷新
    [self loadMoreData:YES];
}

- (void)loadMoreData:(BOOL)refresh
{
    self.currentPage = refresh ? 1 : self.currentPage + 1;
    if (refresh) _searchResources = nil;
    
    // 显示加载
    if (self.searchResources.count == 0) {
        [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeDot];
        [self.loadFailView hide];
    }
    [self.emptyResultView hide];
    // 发送搜索
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSString *URLStr = [NSString stringWithFormat:@"http://gank.io/api/search/query/%@/category/all/count/10/page/%zd", self.searchText, self.currentPage];
    if ([self.types containsObject:self.searchText]) { // 包含分类
        URLStr = [NSString stringWithFormat:@"http://gank.io/api/search/query/listview/category/%@/count/10/page/%zd", self.searchText, self.currentPage];
    }
    NSString *encodedString = [URLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mgr GET:encodedString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 取出数组
        NSArray *results = responseObject[@"results"];
        if (results.count == 0) {
            if (self.searchResources.count > 0) { // 没有更多数据了
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.tableView.mj_footer.hidden = NO;
            } else { // 没有数据（没有搜索到）
                [self.emptyResultView showAtView:self.view hudType:JHUDLoadingTypeCustomAnimations];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.tableView.mj_footer.hidden = YES;
                [self.loadingView hide];
                [self.loadFailView hide];
            }
            return ;
        }
        self.tableView.mj_footer.hidden = NO;
        [self.tableView.mj_footer endRefreshing];
        // 转化成模型
        NSArray *resources = [PYResource mj_objectArrayWithKeyValuesArray:results];
        // 添加模型
        [self.searchResources addObjectsFromArray:resources];
        // 隐藏加载
        [self.loadingView hide];
        // 刷新
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.currentPage--;
        [self.loadingView hide];
        [self.tableView.mj_footer endRefreshing];
        if (self.searchResources.count == 0) { // 还没有内容
            [self.loadFailView showAtView:self.view hudType:JHUDLoadingTypeCustomAnimations];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    self.types = @[@"iOS", @"Android", @"前端", @"瞎推荐", @"拓展资源", @"App", @"休息视频"];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData:NO];
    }];
    // 加载数据
    [self loadMoreData:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = self.searchResources.count == 0;
    return self.searchResources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PYSearchResourceCell *cell = [PYSearchResourceCell cellWithTableView:tableView];
    cell.resource = self.searchResources[indexPath.row];
    return cell;
}

#pragma mark - Table view dalegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取链接
    PYResource *resource = self.searchResources[indexPath.row];
    // 加载网页
    PYWebController *webVC = [[PYWebController alloc] init];
    webVC.url = resource.url;
    webVC.progressColor = [UIColor darkGrayColor];
    webVC.resource = resource;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
