//
//  XWJinBiVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/21.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWJinBiVC.h"
#import "XWYuanBaoListCell.h"
#import "XWCountInfoVC.h"
#import "XWPacketModel.h"
#import "XWCashInfoHeaderCell.h"
@interface XWJinBiVC ()<DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource>

{
    int _stype;
    int _pagenum;
    int _totalpage;  // 总页数

}

@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, strong) XWPacketModel *dataModel;


@end

@implementation XWJinBiVC

//设置字体颜色
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
//！！！重点在viewWillAppear方法里调用下面两个方法
-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
    
}

- (void)setupTableView
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadGoodsList) name:@"reloadGoodsList" object:nil];
//    
    //添加头部标签
    XWCashInfoHeaderCell *headerCell = [[XWCashInfoHeaderCell alloc]init];
    headerCell.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    [headerCell setCellMidTitle:@"元宝"];
    [self.view addSubview:headerCell];
    [headerCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.bottom.mas_equalTo(0);
    }];

    _pagenum = 1;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (STUserDefaults.isLogin) {
            [self.infoArr removeAllObjects];
            [self loadDataWithPage:1];
            
        }else{
            
            [self.tableView.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"请先登录"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];

        }
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (STUserDefaults.isLogin) {
        
            if (_pagenum == _totalpage) {
                [self.tableView.mj_footer endRefreshing];
                [SVProgressHUD showSuccessWithStatus:@"数据已完"];
            }else{
                _pagenum++;
                [self loadDataWithPage:_pagenum];
            }
            
        }else{
            
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"请先登录"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
        }

    }];
    
    self.tableView.mj_footer.automaticallyHidden = YES;
    
    if (STUserDefaults.isLogin){
    
        [self loadDataWithPage:_pagenum];
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];

    }
    
}


- (void)loadDataWithPage:(int)pagenum
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [STRequest CoinDetailInfoDataWithParam:pagenum andDataBlock:^(id ServersData, BOOL isSuccess)  {
    
        XWPacketModel *dataModel = [XWPacketModel mj_objectWithKeyValues:ServersData];
        
        if (isSuccess) {
            JLLog(@"ServersData---%@",ServersData);
            if (dataModel.c == 1)
            {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                
                if (dataModel.d.detain.count == 0) {
                    [SVProgressHUD showErrorWithStatus:@"无更多数据"];
                } else {
                    for (XWPacketInfoDetail *detailModel in dataModel.d.detain) {
                        [self.infoArr addObject:detailModel];
                        
                        [self.tableView reloadData];
                        [SVProgressHUD dismiss];
                        
                    }
                }
                
                _pagenum = dataModel.d.pagenum;
                _totalpage  = dataModel.d.totalpage;
            }else
            {
                [SVProgressHUD showErrorWithStatus:dataModel.m];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"无网络"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];

}

#pragma mark Empty_Data
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return MyImage(@"wushuju_");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        XWYuanBaoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XWYuanBaoListCell"];
        if (cell == nil)
        {
            cell = [[XWYuanBaoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWYuanBaoListCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setCellWithDic: self.infoArr[indexPath.row]];

        return cell;

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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0)
//    {
//        return 100*AdaptiveScale_W;
//        
//    }else
//    {
        return 60*AdaptiveScale_W;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 1;
//    }else{
        return 1;
 //   }
}


- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray new];
    }
    return _infoArr;
}



- (void)dealloc
{
    JLLog(@"---dealloc----");
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}



@end
