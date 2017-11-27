//
//  GoodsBuyerViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-1.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "MJRefresh.h"
@interface GoodsBuyerViewController : XDBaseViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    UITableView * myTableView;
    NSMutableArray * dataArray;
    MJRefreshHeaderView * headerView;
    MJRefreshFooterView * footerView;
    int currentPage;
    int currentCount;
    BOOL isFirst;
}
@property (nonatomic,copy) NSString * goodsId;
@end

