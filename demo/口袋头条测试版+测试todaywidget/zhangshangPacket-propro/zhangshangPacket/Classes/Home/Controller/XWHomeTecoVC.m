//
//  XWHomeTecoVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeTecoVC.h"
#import "XWOtherThreeImageCell.h"
#import "XWCommonCell.h"
#import "XWOtherBigImageCell.h"
#import "XWHomeTecoModel.h"
#import "XWTecoCell.h"
#import "XWBigPicCell.h"
#import "XWTripleImageCell.h"

@interface XWHomeTecoVC ()
{
    NSInteger _cellType;
    NSInteger isFirstGet;
    NSInteger isreading;
    NSString *readingID;
}
@property (nonatomic, strong) NSMutableArray *infoArr;
/** 上一次选中 tabBar 的索引*/
@property (nonatomic, strong) UIViewController *lastSelectedIndex;

@property (nonatomic, assign) NSInteger artidFirst;

@property (nonatomic, assign) NSInteger artidLast;

@property (nonatomic, assign) NSInteger artidMaxid;

@property (nonatomic, assign) NSInteger artidMinid;

@property (nonatomic, strong) NSMutableArray *muarray;

@property (nonatomic, strong) XWHomeModel *dataModel;

@property (nonatomic, strong) NSMutableArray *newsArr;

@property (nonatomic, assign) NSInteger artidFirstData;
@property (nonatomic, assign) NSInteger isfinishTask;


@end

@implementation XWHomeTecoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    //通知方式去监测点击tabbar
    // 监听 tabBar 点击的通知
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:@"TabRefresh" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendSuccessFinishTask:) name:@"sendSuccessFinishTask" object:nil];
}

//- (void)tabBarSelected{
//
//    //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
//    if (self.lastSelectedIndex != self.tabBarController.selectedViewController && self.view.isShowingOnKeyWindow) {
//        if (STUserDefaults.isLogin){
//            [self.tableView.mj_header beginRefreshing];
//            NSLog(@"%@--%@",self,self.parentViewController);
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"请先登录"];
//        }
//    };
//
//    self.lastSelectedIndex = self.tabBarController.selectedViewController;
//
//}
//
//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    if (!self.lastSelectedIndex) {
//        self.lastSelectedIndex = self.tabBarController.selectedViewController;
//    }
//}

- (void)setupUI
{
    
    [self.tableView xw_setDayMode:^(UIView *view) {
        UITableView *tableview = (UITableView *)view;
        tableview.backgroundColor = MainBGColor;
        tableview.separatorColor = MainBGColor;
    } nightMode:^(UIView *view) {
        UITableView *tableview = (UITableView *)view;
        tableview.backgroundColor = NightMainBGColor;
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }];
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self setupRefresh];
    
    [self.tableView registerClass:[XWBigPicCell class] forCellReuseIdentifier:@"XWBigPicCell"];

}

- (void)setupRefresh
{
    
    if (STUserDefaults.isLogin){
        JLLog(@"isfirst");
        self.artidLast = 0;
        [self loadNewFirstDataWithParam:self.artidLast];
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTecoData)];
        
        self.tableView.mj_header.automaticallyChangeAlpha = YES;
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadTecoMoreData)];
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        
    }

}

- (void)loadTecoData
{
    JLLog(@"self.muarray----%@",self.muarray);
    
    if (STUserDefaults.isLogin) {
#pragma mark ========== 处理 下拉刷新 无数据的 ===========
        
        [self loadNewDataWithParam:self.artidLast];
        
    }else{
        
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
    }

    
}


- (void)loadTecoMoreData
{
    if (STUserDefaults.isLogin) {
    
#pragma mark ============= 处理 上拉加载更多 无数据的 =============
        
        if (isFirstGet) {
            JLLog(@"artidfirstData---%ld---isfirstget--%d",(long)_artidFirstData,isFirstGet);
            [self loadOldDataWithParam:_artidFirstData];
            
        } else {
            [self loadOldDataWithParam:self.artidFirst];
            
        }
        
//        [self loadOldDataWithParam:self.artidFirst];
        [self.tableView.mj_footer beginRefreshing];
        
    } else {
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
    }

}

/**
 *  提示用户最新的资讯数量
 *
 *  @param count 最新资讯数量
 */
- (void)showNewStatusesCount:(int)count
{
    UILabel *label = [[UILabel alloc] init];
    if (count) {
        label.text = [NSString stringWithFormat:@"口袋头条为您推荐%d条更新", count];
    } else {
        label.text = @"没有更多更新";
    }
    
    label.backgroundColor = CUSTOMCOLOR(255, 150, 150);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    label.textColor = WhiteColor;
    label.yj_width = self.view.yj_width;
    label.yj_height = 40;
    label.yj_x = 0;
    label.yj_y = 64 - label.yj_height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    CGFloat duration = 0.25;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.yj_height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}

#pragma mark ================  第一次刷新 取新数据 ================
- (void)loadNewFirstDataWithParam:(NSInteger)artid
{
    NSInteger direDown = 1;
    [self.muarray removeAllObjects];
    [STRequest TecoInfoNewDataParam:artid andDireParam:direDown andDataBlock:^(id ServersData, BOOL isSuccess) {
        self.dataModel = [XWHomeModel mj_objectWithKeyValues:ServersData];
        if (isSuccess) {
            if ([ServersData[@"c"] intValue] == 1) {
                
                
                NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                NSMutableArray *arrtemp = [NSMutableArray arrayWithArray:dictemp[@"techlist"]];
                
                [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
                    [self showNewStatusesCount:arrtemp.count];
                }];
                
                [self.tableView.mj_footer endRefreshing];
                if (arrtemp.count == 0) {
                    
//                    [SVProgressHUD showSuccessWithStatus:@"暂无更多数据"];
                    JLLog(@"暂无更多数据");

                } else {
                    //                    if (self.infoArr.count > 10) {
                    //                       // [self.infoArr removeObject];
                    //
                    //                    } else {
                    //
                    //                    }
                    
                    self.newsArr = [NewsListDataModel mj_objectArrayWithKeyValuesArray:arrtemp];
                    for (int i = arrtemp.count - 1 ; i >= 0; i--) {
                        //[NewsListDataModel mj_objectArrayWithKeyValuesArray:arrtemp];
                        
                        [self.infoArr insertObject:self.newsArr[i] atIndex:0];
                        
                        if ([arrtemp[i][@"id"] integerValue] < SYS_AD_MINID || [arrtemp[i][@"id"] integerValue] > SYS_AD_MAXID) {
                            [self.muarray addObject:arrtemp[i][@"id"]];
                        }
                        
                    }
                    JLLog(@"第一次取-----%@",self.muarray);
                    //                    _artidLast = [[self.muarray valueForKeyPath:@"@max.self"] integerValue];
                    //                    _artidFirstData = [[self.muarray valueForKeyPath:@"@min.self"] integerValue];
                    _artidMaxid = [dictemp[@"maxid"] integerValue];
                    _artidMinid = [dictemp[@"minid"] integerValue];
                    if (_artidMaxid > 0) {
                        _artidFirstData = [dictemp[@"minid"] integerValue];
                        _artidLast = _artidMaxid;
                        
                    } else {
                        //                        _artidFirstData = [[self.muarray valueForKeyPath:@"@min.self"] integerValue];
                        _artidFirstData = _artidMinid;
                        _artidLast = _artidMaxid;
                        
                    }
                    isFirstGet = 1;
                    JLLog(@"first ----- self.artidlast---%ld",(long)_artidLast);
                    [self.tableView reloadData];
                    
                }
                
                
            }else
            {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
            }
            
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
        }
        
    }];
    
}



#pragma mark ================  下拉刷新 取新数据 ================
- (void)loadNewDataWithParam:(NSInteger)artid
{
    NSInteger direDown = 1;
    [self.muarray removeAllObjects];

    [STRequest TecoInfoNewDataParam:artid andDireParam:direDown andDataBlock:^(id ServersData, BOOL isSuccess) {
        self.dataModel = [XWHomeModel mj_objectWithKeyValues:ServersData];
//        JLLog(@"ServersData---%@",ServersData);
        if (isSuccess) {
            if ([ServersData[@"c"] intValue] == 1) {
                
                NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                NSMutableArray *arrtemp = [NSMutableArray arrayWithArray:dictemp[@"techlist"]];
                
                [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
                    [self showNewStatusesCount:arrtemp.count];
                }];
                [self.tableView.mj_footer endRefreshing];
                
                if (arrtemp.count == 0) {
                    
                    [SVProgressHUD showSuccessWithStatus:@"暂无更多数据"];
                    
                } else {
                    self.newsArr = [NewsListDataModel mj_objectArrayWithKeyValuesArray:arrtemp];
                    
                    for (int i = arrtemp.count - 1; i >= 0; i--) {
                        //[NewsListDataModel mj_objectArrayWithKeyValuesArray:arrtemp];
                        
                        [self.infoArr insertObject:self.newsArr[i] atIndex:0];
                        
                        if ([arrtemp[i][@"id"] integerValue] < SYS_AD_MINID || [arrtemp[i][@"id"] integerValue] > SYS_AD_MAXID) {
                            [self.muarray addObject:arrtemp[i][@"id"]];
                        }
                        
                    }
                    
                    _artidMaxid = [dictemp[@"maxid"] integerValue];
                    
                    if (_artidMaxid > 0) {
                        _artidLast = _artidMaxid;
                        
                    } else {
                        //                        _artidLast = [[self.muarray valueForKeyPath:@"@max.self"] integerValue];
                        _artidLast = _artidMaxid;
                        
                    }

                    
                    JLLog(@"first ----- self.artidlast---%ld",self.artidLast);
                   
                    JLLog(@"168-----%@",self.muarray);
                    [self.tableView reloadData];

                }
                
            }else
            {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
            }
            
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
        }
        
    }];
    
}

#pragma mark ================  上拉加载更多 取老数据 ================

- (void)loadOldDataWithParam:(NSInteger)artid
{
    NSInteger direUP = 0;
    isFirstGet = 0;

    [STRequest TecoInfoNewDataParam:artid andDireParam:direUP andDataBlock:^(id ServersData, BOOL isSuccess) {
        self.dataModel = [XWHomeModel mj_objectWithKeyValues:ServersData];
        JLLog(@"serverdata----%@",ServersData);
        if (isSuccess) {
            if ([ServersData[@"c"] intValue] == 1) {
                
                NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                NSMutableArray *arrtemp = [NSMutableArray arrayWithArray:dictemp[@"techlist"]];
                
                if (arrtemp.count == 0) {
                    
                    [SVProgressHUD showSuccessWithStatus:@"已无更多数据"];
                    
                } else {
                    self.newsArr = [NewsListDataModel mj_objectArrayWithKeyValuesArray:arrtemp];
                    
                    for (int i = 0; i<arrtemp.count; i++) {
                        //[NewsListDataModel mj_objectArrayWithKeyValuesArray:arrtemp];
                        
                        [self.infoArr addObject:self.newsArr[i]];
                        
                        if ([arrtemp[i][@"id"] integerValue] < SYS_AD_MINID || [arrtemp[i][@"id"] integerValue] > SYS_AD_MAXID) {
                            [self.muarray addObject:arrtemp[i][@"id"]];
                        }
                        
                    }
                    
                    //                    _artidFirst = [[self.muarray valueForKeyPath:@"@min.self"] integerValue];
                    _artidMinid = [dictemp[@"minid"] integerValue];
                    
                    if (_artidMinid > 0) {
                        _artidFirst = _artidMinid;
                        
                    } else {
                        //                        _artidFirst = [[self.muarray valueForKeyPath:@"@min.self"] integerValue];
                        _artidFirst = _artidMinid;
                        
                    }
                    //                    _artidFirst = [[self.muarray valueForKeyPath:@"@min.self"] integerValue];
                    //                    JLLog(@"上啦-----%@",self.muarray);
                    JLLog(@"240-----%@",self.muarray);
                    [self.tableView reloadData];
                    
                }
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];

                
            }else
            {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
            }
            
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
        }
        
    }];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListDataModel *model = self.infoArr[indexPath.row];
    // NSDictionary *tempDic  = self.infoArr[indexPath.row];
    
    if ([model.showType integerValue] == 2) {
        
        static NSString *CellIdentifier1 = @"XWTripleImageCell";
        XWTripleImageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[XWTripleImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        cell.model = model;
        
        if ([model.id integerValue] <= SYS_AD_MAXID &&  [model.id integerValue] >= SYS_AD_MINID ) {
            if (!_isfinishTask) {
                
            } else {
                if (_isfinishTask == 1) {
                    cell.adRewardImage.hidden = YES;
                }else{
                    cell.adRewardImage.hidden = NO;
                }
            }
            
        }
        
        if (isreading == 1 && [model.id isEqualToString:readingID]) {
            cell.lblTitle.textColor = MainGrayTextColor;
        }
        
        return cell;
        
    }else if ([model.showType integerValue] == 3){
        
        static NSString *CellIdentifier = @"XWBigPicCell";
        XWBigPicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[XWBigPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.model = model;
        if ([model.id integerValue] <= SYS_AD_MAXID &&  [model.id integerValue] >= SYS_AD_MINID ) {
            
            if (!_isfinishTask) {
                
            } else {
                
                if (_isfinishTask == 1) {
                    cell.adRewardImage.hidden = YES;
                }else{
                    cell.adRewardImage.hidden = NO;
                    
                }
            }
            
        }
        if (isreading == 1 && [model.id isEqualToString:readingID]) {
            cell.titleLab.textColor = MainGrayTextColor;
        }
        
        return cell;
        
    } else {
        static NSString *cellID = @"XWCommonCell";
        XWCommonCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[XWCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.model = model;
        if ([model.id integerValue] <= SYS_AD_MAXID &&  [model.id integerValue] >= SYS_AD_MINID ) {
            if (!_isfinishTask) {
                
            } else {
                
                if (_isfinishTask == 1) {
                    cell.adRewardImage.hidden = YES;
                }else{
                    cell.adRewardImage.hidden = NO;
                    
                }
            }
        }
        if (isreading == 1 && [model.id isEqualToString:readingID]) {
            cell.lblTitle.textColor = MainGrayTextColor;
        }
        return cell;
    }


}

#pragma mark - UITableViewDeletage
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathA,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    NewsListDataModel *model = self.infoArr[indexPath.row];
    
    WKWebViewController *detailsController = [[WKWebViewController alloc] init];
    //文章类型
    detailsController.isAd = [model.type integerValue];
    
    //文章类型
    detailsController.newstype = model.type;
    //地址
    detailsController.urlStr = model.url;
    //是否有奖励
    detailsController.hasNewsReward = [model.hasReward integerValue];
    //图片首图
    detailsController.imageStr = model.imgsUrl[@"imgsUrl1"];
    //新闻或广告title
    detailsController.titleStr = model.title;
    //新闻或是广告ad
    detailsController.artid = [model.id intValue];
    JLLog(@"url ---- %@",model.url);
    
    if ([model.id integerValue] <= SYS_AD_MAXID &&  [model.id integerValue] >= SYS_AD_MINID ) {
        //model.showurl = 1 是外链
        if ([model.showurl integerValue] == 1) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
            
        }else{
            // 设置导航栏标题变大
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:18];
            label.text = model.title;
            detailsController.navigationItem.titleView = label;
            if ([model.type integerValue] == 2) {
                NSString *str = [NSString stringWithFormat:@"%@&r=x",model.url];
                //地址
                [detailsController loadWebURLSring:str];
                
            } else {
                [detailsController loadWebURLSring:model.url];
                
            }
            
            [self setHidesBottomBarWhenPushed:YES];//隐藏tabbar
            [self.navigationController pushViewController:detailsController animated:YES];
        }
    }else{
        
        // 设置导航栏标题变大
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:18];
        label.text = model.title;
        detailsController.navigationItem.titleView = label;
        [detailsController loadWebURLSring:model.url];

        [self setHidesBottomBarWhenPushed:YES];//隐藏tabbar
        [self.navigationController pushViewController:detailsController animated:YES];
        
    }
    
    if ([model.showType integerValue] == 2) {
        XWTripleImageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([model.id integerValue] <= SYS_AD_MAXID &&  [model.id integerValue] >= SYS_AD_MINID) {
            if (_isfinishTask) {
                cell.adRewardImage.hidden = YES;
            }else{
                cell.adRewardImage.hidden = NO;
                
            }
        }
        cell.lblTitle.textColor = MainGrayTextColor;
        isreading = 1;
        readingID = model.id;
        
    }else if ([model.showType integerValue] == 3){
        XWBigPicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([model.id integerValue] <= SYS_AD_MAXID &&  [model.id integerValue] >= SYS_AD_MINID) {
            if (_isfinishTask) {
                cell.adRewardImage.hidden = YES;
            }else{
                cell.adRewardImage.hidden = NO;
                
            }
        }
        cell.titleLab.textColor = MainGrayTextColor;
        isreading = 1;
        readingID = model.id;
    }else{
        XWCommonCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([model.id integerValue] <= SYS_AD_MAXID &&  [model.id integerValue] >= SYS_AD_MINID) {
            if (_isfinishTask) {
                cell.adRewardImage.hidden = YES;
            }else{
                cell.adRewardImage.hidden = NO;
                
            }
        }
        cell.lblTitle.textColor = MainGrayTextColor;
        isreading = 1;
        readingID = model.id;
    }

    
}

- (void)sendSuccessFinishTask:(NSNotification *)noti
{
    _isfinishTask = [noti.userInfo[@"isFinishTask"] integerValue];
    
    JLLog(@"_isfinishTask---%ld",(long)_isfinishTask);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsListDataModel *model = self.infoArr[indexPath.row];
    
    if ([model.showType integerValue] == 2) {
        return 170*AdaptiveScale_W;
    }else if ([model.showType integerValue] == 3){
        return [tableView fd_heightForCellWithIdentifier:@"XWBigPicCell"  configuration:^(XWBigPicCell *cell) {
            cell.model = self.infoArr[indexPath.row];
        }] ;
    }else{
    
        return 110*AdaptiveScale_W;
    }
    
}


- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

- (NSMutableArray *)muarray
{
    if (!_muarray) {
        _muarray = [NSMutableArray array];
    }
    return _muarray;
}

- (void)dealloc
{
    JLLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

@end
