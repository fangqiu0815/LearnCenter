//
//  XWDisWeekVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWDisWeekVC.h"
#import "XWTodayDetailCell.h"
#import "XWDisHeaderModel.h"

@interface XWDisWeekVC ()
<DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource>

{
    int _page;  //当前页
    int _totalpage;  // 总页数
    UIImageView *navBarHairlineImageView;
    
}
@property (nonatomic, strong) NSMutableArray *infoArr;
@end

@implementation XWDisWeekVC

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//黑色
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
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setupTableView
{
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
            [self loadDataWithPage:_page];
            
        }else{
            
            [self.tableView.mj_header endRefreshing];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
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
                [self loadDataWithPage:_page];
            }
            
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
        }
        
    }];
    
    if (STUserDefaults.isLogin){
        
        [self loadDataWithPage:_page];
        
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
    }
    
    
}

- (void)showNewStatusesCount:(NSInteger )count
{
    UILabel *label = [[UILabel alloc] init];
    if (count) {
        label.text = [NSString stringWithFormat:@"口袋头条为您推荐%ld条数据", count];
    } else {
        label.text = @"没有更多数据";
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

#pragma mark askForData
-(void)loadDataWithPage:(int )page
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSDictionary *dict = @{
                           @"pn":@(page),
                           @"type":@(2)

                           };
    
    [STRequest DiscoverTodayHotItem:dict andDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            JLLog(@"ServersData---%@",ServersData);
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if (ServersData[@"c"]) {
                    
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSMutableArray *arrtemp = [DisHeaderModel mj_objectArrayWithKeyValuesArray:dictemp[@"selectlist"]];
                    
//                    [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
//                        [self showNewStatusesCount:arrtemp.count];
//                    }];
//                    [self.tableView.mj_footer endRefreshingWithCompletionBlock:^{
//                        [self showNewStatusesCount:arrtemp.count];
//                    }];
                    
                    if (arrtemp.count == 0) {
                        [SVProgressHUD showErrorWithStatus:@"更多推荐敬请期待"];
                    } else {
                        for (int i = 0; i<arrtemp.count; i++) {
                            [self.infoArr addObject:arrtemp[i]];
                        }
                        [self.tableView reloadData];
                        _page = [dictemp[@"pn"] intValue];
                        _totalpage = [dictemp[@"pnmax"] intValue];
                        [SVProgressHUD dismiss];
                    }
                    
                }
                else
                {
                    
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                }
                
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"网络故障"];
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

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    if(section == 0 ){
    //        return 1;
    //    }else{
    return self.infoArr.count;
    //    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identity = @"XWTodayDetailCell";
    DisHeaderModel *model = self.infoArr[indexPath.row];
    XWTodayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil)
    {
        cell = [[XWTodayDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    cell.dataModel = model;
    return cell;
    //    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DisHeaderModel *enterModel = self.infoArr[indexPath.row];
    WKWebViewController *wkVC = [[WKWebViewController alloc]init];
    [wkVC loadWebURLSring:enterModel.url];
    [self.navigationController pushViewController:wkVC animated:YES];
    [wkVC setHidesBottomBarWhenPushed:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == 0)
    //    {
    //        return 100*AdaptiveScale_W;
    //
    //    }else
    //    {
    return 110*AdaptiveScale_W;
    //    }
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
