# XBYTableView
自定义TableView
1、针对常用的两种数据列表请求格式进行封装；
2、将MJRefresh封装到tableView中，让tableView自带MJRefresh的上拉加载更多和下拉刷新功能，实现刷新代理方法，就能实现上拉加载更多和下拉刷新功能；
3、自定义`mj_header`和`mj_footer`的设置只需要重写`- (void)customSetting;`方法

## Requirements 要求
* iOS 8+
* Xcode 8+

## Installation 安装
### 手动安装:
`下载DEMO后，将子文件夹XBYTableView拖入到项目中, 导入头文件XBYTableView.h开始使用, 注意: 项目中需要有MJRefresh 3.x第三方库!`

## Usage 使用方法
```objc
//在ViewController中新建一个XBYTabelView，设置刷新代理
XBYTableView *tableView = [XBYTableView new];
tableView.refreshDelegate = self;
//在ViewController中实现刷新代理方法
//下拉刷新
- (void)refreshTableView:(XBYTableView *)tableView loadNewDataWithPage:(NSInteger)page {

}

//上拉加载更多
- (void)refreshTableView:(XBYTableView *)tableView loadMoreDataWithPage:(NSInteger)page {

}
```
## 其他
见下面头文件描述：

```objc
//XBYTableView.h
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
```

## 联系方式
* [掘金 - Adrenine](https://juejin.im/user/57c39bfb79bc440063e5ad44)
* [简书 - Adrenine](https://www.jianshu.com/users/ac413919c89c/timeline)
* [Blog - Adrenine](https://adrenine.github.io/)


## 许可证
XBYTableView 使用 MIT 许可证，详情见 LICENSE 文件。
