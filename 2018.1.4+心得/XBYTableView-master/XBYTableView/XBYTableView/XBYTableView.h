//
//  XBYTableView.h
//  XBYTableView
//
//  Created by xiebangyao on 2017/12/25.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

/**
 此封装适配了两种接口返回数据类型：
 1、根据页码数以及每个页面数据条数去计算有多少条数据（总数据条数做乘法：page * pageSize）
 2、加载的数据直接是fromIndex,toIndex，此次加载数据条数为toIndex - fromIndex(总数据条数做加法，从原起点到toIndex)
 注意：最后一次获取数据可能存在小于pageSize的情况
 */
@class XBYTableView;

/**
 将下拉刷新和上拉加载更多封装成代理方法，使用时可以不用再做刷新配置，自定义刷新除外
 */
@protocol XBYTableViewDelegate <NSObject>

/**
 下拉刷新数据

 @param tableView <#tableView description#>
 @param page 加载第几页的数据
 */
- (void)refreshTableView:(XBYTableView *)tableView loadNewDataWithPage:(NSInteger)page;

/**
 上拉加载更多数据

 @param tableView <#tableView description#>
 @param page 加载第几页的数据
 */
- (void)refreshTableView:(XBYTableView *)tableView loadMoreDataWithPage:(NSInteger)page;

@end


@interface XBYTableView : UITableView

/**
 兼容一些只需要加载一次数据的页面，不需要刷新操作
 */
@property (nonatomic, assign) BOOL refreshEnable;

/**
 page每次是否递增1 默认是YES，针对分页的接口，不是分页的接口应将这个属性设为NO
 */
@property (nonatomic, assign, getter=isPageAddOne) BOOL pageAddOne;

/**
 第一页的页码，数据从第几页开始 默认是0
 */
@property (nonatomic, assign) NSInteger from;

/**
 当前页页码
 */
@property (nonatomic, assign) NSInteger page;

/**
 每一页的数据条数，默认一页10条
 */
@property (nonatomic, assign) NSInteger pageSize;

/**
 总数据条数，当已加载数等于总数据条数，会显示：没有更多数据，小于的时候显示加载更多
 */
@property (nonatomic, assign) NSInteger totalSize;

@property (nonatomic, weak) id<XBYTableViewDelegate> refreshDelegate;

/**
 手动停止加载
 */
- (void)endRefreshing;

/**
 手动停止加载（已无更多数据）
 */
- (void)endRefreshingWithNoMoreData;

/**
 重设当前页数，即调用from属性的setter方法
 */
- (void)resetPage;

/**
 当设置了页面自动加一，但是接口错误，或者网络请求失败，需要将自动加一减去一，此时才是已拿到
 数据的正确页数
 */
- (void)pageDecreaseOne;

/**
 是否正在加载数据，一般加载数据时不让用户操作
 */
- (BOOL)isLoadingData;

/**
 mj_header和mj_footer个性化设置
 */
- (void)customSetting;

@end
