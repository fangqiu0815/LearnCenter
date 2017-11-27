//
//  PayHistoryViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-17.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "MJRefresh.h"

@interface PayHistoryViewController : XDBaseViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    UITableView * myTableView;
    NSMutableArray * dataArray;

    MJRefreshHeaderView * headerView;
    MJRefreshFooterView * footerView;
    
    int currentPage;
    int currentCount;
    BOOL notFirst;

}
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * orderId;
@end
