//
//  XBYTableView.m
//  XBYTableView
//
//  Created by xiebangyao on 2017/12/25.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYTableView.h"

@implementation XBYTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _from = 0;
        _page = -1;
        _pageSize = 10;
        _pageAddOne = YES;

        [self setUpRefreshComponents];

        _refreshEnable = YES;
    }
    
    return self;
}

#pragma mark - Target Selector
/**
 <#Description#>
 */
- (void)loadNewData {
    [self resetPage];
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:loadNewDataWithPage:)]) {
        [self.refreshDelegate refreshTableView:self loadNewDataWithPage:self.page];
    }
}

- (void)loadMoreData {
    if (self.isPageAddOne) {
        self.page ++ ;
    } else {
        self.page += self.pageSize;
    }
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:loadMoreDataWithPage:)]) {
        [self.refreshDelegate refreshTableView:self loadMoreDataWithPage:self.page];
    }
}

#pragma mark - Private Method
/**
 生成刷新组件
 */
- (void)setUpRefreshComponents {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.mj_header.automaticallyChangeAlpha = YES;
    self.mj_footer.automaticallyChangeAlpha = YES;
    
    [self customSetting];
}

/**
 做一些自定义设置，视具体项目而定
 */
- (void)customSetting {
    //隐藏最后加载数据的时间label
//    ((MJRefreshNormalHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = YES;
}

/**
 计算已加载数据条数

 @return <#return value description#>
 */
- (NSInteger)dataCount {
    NSInteger sectionCount = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sectionCount = [self.dataSource numberOfSectionsInTableView:self];
    }
    NSInteger sum = 0;
    for (int i = 0;i< sectionCount;i++) {
        sum += [self.dataSource tableView:self numberOfRowsInSection:i];
    }
    
    return sum;
}

#pragma mark - Setter
- (void)setRefreshEnable:(BOOL)refreshEnable {
    _refreshEnable = refreshEnable;
    if (_refreshEnable) {
        [self setUpRefreshComponents];
    } else {
        self.mj_header = nil;
        self.mj_footer = nil;
    }
}

/**
 设置总数据条数，这个条数肯定是服务端返回的，设置以后需要让header或者footer停止刷新动画

 @param totalSize <#totalSize description#>
 */
- (void)setTotalSize:(NSInteger)totalSize {
    NSAssert(totalSize<0, @"数据总条数不能小于0");
    _totalSize = totalSize;
    NSInteger dataCount = [self dataCount];
    
    if ([self.mj_footer isRefreshing]) {
        if (dataCount < _totalSize) {
            [self.mj_footer endRefreshing];
        } else {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    } else if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
        if (dataCount < _totalSize) {
            [self.mj_footer resetNoMoreData];
        } else {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    } else {
        if (dataCount < _totalSize) {
            [self.mj_footer resetNoMoreData];
        } else {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

/**
 调用totalSize的setter方法去判定停止哪个刷新动画
 */
- (void)endRefreshing {
    self.totalSize = [self dataCount] + 1;
}

- (void)endRefreshingWithNoMoreData {
    self.totalSize = [self dataCount];
}

/**
 页面数减一
 */
- (void)pageDecreaseOne {
    if (self.isPageAddOne) {
        if (self.page > self.from) {
            self.page--;
        }
    } else {
        if (self.page > self.from) {
            self.page -= self.pageSize;
        }
    }
}

- (void)resetPage {
    self.page = self.from;
}

- (BOOL)isLoadingData {
    return self.mj_header.isRefreshing || self.mj_footer.isRefreshing;
}

#pragma mark - Getter
- (NSInteger)page {
    if (_page < 0) {
        _page = _from;
    }
    
    if (!_pageAddOne) {
        NSInteger dataCount = [self dataCount];
        NSInteger pageCount = _pageAddOne ? (_page - _from) * _pageSize : (_pageSize - _from);//区分接口的两种请求
        if (dataCount < pageCount) {
            return dataCount;
        } else {
            return _pageSize;
        }
    } else {
        return _page;
    }
}

- (NSInteger)pageSize {
    if (_page < 0) {
        _page = _from;
    }
    
    if (!_pageAddOne) {
        NSInteger dataCount = [self dataCount];
        NSInteger pageCount = _pageAddOne ? (_page - _from) * _pageSize : (_page - _from);
        if (dataCount < pageCount) {
            return pageCount - dataCount;
        } else {
            return _pageSize;
        }
    } else {
        return _pageSize;
    }
}

@end
