//
//  XWRecordListVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWRecordListVC.h"
#import "XWShopRecordCell.h"
#import "XWUserGoodsList.h"
@interface XWRecordListVC ()<DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource>

{
    int _page;  //当前页
    int _totalpage;  // 总页数
}
@property (nonatomic, strong) NSMutableArray *infoArr;

@property (nonatomic, strong) UserGoodsList *dataModel;

@end

@implementation XWRecordListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addView];
    
}

- (void)addView
{
    self.tableView.backgroundColor = MainBGColor;
    self.tableView.separatorStyle = UITableViewCellStyleSubtitle;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    _page = 1;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (STUserDefaults.isLogin) {
            _page = 1;
            [_infoArr removeAllObjects];
            [self loadData];
            
        }else{
            
            [self.tableView.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"请先登录"];
            
        }
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (STUserDefaults.isLogin){
            NSLog(@"数据加载总数:%ld",self.infoArr.count);
            
            if (_page == _totalpage) {
                [self.tableView.mj_footer endRefreshing];
                [SVProgressHUD showSuccessWithStatus:@"数据已完"];
            }else{
                _page++;
                [self loadData];
            }
            
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"请先登录"];
            
        }
    }];
    
    if (STUserDefaults.isLogin){
        
        [self loadData];
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        
    }

}


- (void)loadData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    [STRequest UserGetGoodsRecordListDataWithPage:_page andDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if (ServersData[@"c"]) {
                    JLLog(@"%@",ServersData);
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSArray *arrtemp = [NSArray arrayWithArray:dictemp[@"pagedata"]];
                    NSMutableArray *dataArr = [UserGoodsList mj_objectArrayWithKeyValuesArray:arrtemp];
                    
                    for (int i = 0; i<arrtemp.count; i++) {
                        
                        [self.infoArr addObject:dataArr[i]];
                    }
                    JLLog(@"self.infoarr ---- %@",self.infoArr);
                    
                    [self.tableView reloadData];
                    _page = [dictemp[@"pagenum"] intValue];
                    JLLog(@"_page---%d",_page);
                    _totalpage = [dictemp[@"totalpage"] intValue];
                    JLLog(@"_totalpage---%d",_totalpage);

                    [SVProgressHUD dismiss];
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                    
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                    
                }
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络故障"];
                
            }
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"无网络"];
            
        }
    }];
    
}

#pragma mark Empty_Data
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return MyImage(@"wushuju_");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.infoArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identity = @"XWShopRecordCell";
    
    XWShopRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    UserGoodsList *goodsModel = self.infoArr[indexPath.row];

    if (cell == nil)
    {
        cell = [[XWShopRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }
    cell.goodsModel = goodsModel;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165*AdaptiveScale_W;
}


- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}


//  设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = MainRedColor;
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"兑换记录";
    label.font = [UIFont systemFontOfSize:18];
    
    self.navigationItem.titleView = label;
    
}

- (void)dealloc
{
    JLLog(@"shoppingVC---dealloc");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
