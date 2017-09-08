//
//  SearchVC.m
//  demo
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "SearchVC.h"
#define XWSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XWSearchhistories.plist"]
#import "XWSearchHistoryCell.h"
@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *searchHistories;
//搜索记录缓存
@property (nonatomic, copy) NSString *searchHistoriesCachePath;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = _searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(searchClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

    [self setupTableView];

    
}

- (void)setupTableView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    
    UIView *hotSearchHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, ScreenW, 60)];
    hotSearchHeaderView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:hotSearchHeaderView];
    
    UILabel *hotSearchLab = [[UILabel alloc]init];
    [hotSearchHeaderView addSubview:hotSearchLab];
    hotSearchLab.text = @"热门搜索";
    hotSearchLab.textColor = [UIColor blackColor];
    [hotSearchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(hotSearchHeaderView.mas_centerY);
        
    }];
    
    UIButton *changeDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeDataBtn setImage:MyImage(@"icon_search_update") forState:0];
    [changeDataBtn setTitle:@"换一批" forState:0];
    [changeDataBtn addTarget:self action:@selector(changeDataClick) forControlEvents:UIControlEventTouchUpInside];
    [changeDataBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];

    [hotSearchHeaderView addSubview:changeDataBtn];
    [changeDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(hotSearchHeaderView.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(35);
    }];
    
    
    self.tableView.tableHeaderView = headerView;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}

- (void)searchClick
{

    NSLog(@"%s",__func__);
}

- (void)changeDataClick
{
    
    NSLog(@"%s",__func__);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XWSearchHistoryCell"];
    if (!cell) {
        cell = [[XWSearchHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWSearchHistoryCell"];
    }
    cell.titleLab.text = self.searchHistories[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.placeholder = @"搜索你感兴趣的内容";
        
        
        
        
        
        
    }
    return _searchBar;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        
    }
    return _dataArr;
}

- (NSMutableArray *)searchHistories
{
    if (!_searchHistories) {
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
        
    }
    return _searchHistories;
}

@end
