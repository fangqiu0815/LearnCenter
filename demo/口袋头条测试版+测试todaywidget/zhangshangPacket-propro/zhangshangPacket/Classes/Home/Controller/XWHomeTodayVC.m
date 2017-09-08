//
//  XWHomeTodayVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeTodayVC.h"
#import "XWHomeTodayCell.h"
#import "XWHomeTodayModel.h"
#import "XWWKWebTodayVC.h"
@interface XWHomeTodayVC ()
{
    NSInteger _cellType;
    int _page;  //当前页
    int _totalpage;  // 总页数
    NSString *_timeStr;
}
@property (nonatomic, strong) NSMutableArray *infoArr;
/** 上一次选中 tabBar 的索引*/
@property (nonatomic, strong) UIViewController *lastSelectedIndex;
@end

@implementation XWHomeTodayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    //通知方式去监测点击tabbar
    // 监听 tabBar 点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:@"TabRefresh" object:nil];
}

- (void)tabBarSelected{
    
    //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
    if (self.lastSelectedIndex != self.tabBarController.selectedViewController && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
        NSLog(@"%@--%@",self,self.parentViewController);
    };
    
    self.lastSelectedIndex = self.tabBarController.selectedViewController;
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (!self.lastSelectedIndex) {
        self.lastSelectedIndex = self.tabBarController.selectedViewController;
    }
}

- (void)setupUI
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 25)];
    label.textColor = BlackColor;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    label.text = [NSString stringWithFormat:@"历史上的%@",dateTime];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = WhiteColor;
    label.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightHeaderMainColor,MainRedColor);
    label.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
    
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    self.tableView.backgroundColor = MainBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    //    self.tableView.emptyDataSetDelegate = self;
    //    self.tableView.emptyDataSetSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(25);
        make.bottom.mas_equalTo(0);
    }];
    
    if (STUserDefaults.isLogin) {
    
        _page = 1;
        [self loadDataWithPage:_page];
        
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
    }
    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (STUserDefaults.isLogin) {
//            _page = 1;
//            [_infoArr removeAllObjects];
//            [self loadDataWithPage:_page];
//            
//        }else{
//            
//            [self.tableView.mj_header endRefreshing];
//            [SVProgressHUD showErrorWithStatus:@"请先登录"];
//            
//        }
//        
//        
//    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (STUserDefaults.isLogin){
            NSLog(@"数据加载总数:%ld",(unsigned long)self.infoArr.count);
            
            if (_page == _totalpage) {
                [self.tableView.mj_footer endRefreshing];
                [SVProgressHUD showSuccessWithStatus:@"没有更多资讯了"];
            }else{
                _page++;
                [self loadDataWithPage:_page];
            }
            
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"请先登录"];
            
        }
        
        
    }];
    
    if (STUserDefaults.isLogin){
    
        [self loadDataWithPage:_page];
    
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        
    }

    

}

- (void)loadDataWithPage:(int)page
{
    [SVProgressHUD showWithStatus:@"获取数据中"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [STRequest TodayInfoDataWithPageNum:page andDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            
            JLLog(@"ServersData---%@",ServersData);
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if (ServersData[@"c"]) {
                    [self.tableView.mj_footer endRefreshing];
                    
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSArray *arrtemp = [NSArray arrayWithArray:dictemp[@"todayhistorylist"]];
                    
                    if (arrtemp.count == 0) {
                        JLLog(@"无更多数据");
                    } else {
                        NSMutableArray *todayArr = [TodayData mj_objectArrayWithKeyValuesArray:arrtemp];
                        for (int i = 0; i<arrtemp.count; i++) {
                            [self.infoArr addObject:todayArr[i]];
                        }
                        [self.tableView reloadData];
                    }
                    
                    _page = [dictemp[@"pagenum"] intValue];
                    _totalpage = [dictemp[@"totalpage"] intValue];
                    JLLog(@"self.infoArr---%@",self.infoArr);
                    
                    [SVProgressHUD dismiss];
                    
                }
                else
                {
                    
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                }
               
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"网络故障"];
                
            }
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"无网络"];
            
            
        }
    }];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.infoArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identity = @"XWHomeTodayCell";
   // TodayData *model = self.infoArr[indexPath.row];
    TodayData *model = self.infoArr[indexPath.row];
    
    XWHomeTodayCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil)
    {
        cell = [[XWHomeTodayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
 
    cell.todayModel = model;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodayData *model = self.infoArr[indexPath.row];
    XWWKWebTodayVC *detailsController = [[XWWKWebTodayVC alloc] init];
    [detailsController loadWebURLSring:model.href];
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    label.text = model.title;
    detailsController.navigationItem.titleView = label;
    
    [self setHidesBottomBarWhenPushed:YES];//隐藏tabbar
    [self.navigationController pushViewController:detailsController animated:YES];
    [self setHidesBottomBarWhenPushed:NO];


}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray array] ;
    }
    return _infoArr;
}



@end
