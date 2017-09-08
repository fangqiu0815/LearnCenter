//
//  XWMineApprenticeVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineApprenticeVC.h"
#import "XWAppreListCell.h"
#import "XWMineTudiListModel.h"
#import "XWAppreHeaderCell.h"


@interface XWMineApprenticeVC ()
<DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource>

{
    int _page;  //当前页
    int _totalpage;  // 总页数
    UIImageView *navBarHairlineImageView;

}
@property (nonatomic, strong) NSMutableArray *infoArr;

@end

@implementation XWMineApprenticeVC

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
    navBarHairlineImageView.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"我的推荐";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    [self addView];
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


- (void)addView
{
    
    XWAppreHeaderCell *cell = [[XWAppreHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWAppreHeaderCell"];
    cell.frame = CGRectMake(0, 0, ScreenW, 100*AdaptiveScale_W);
    cell.dk_backgroundColorPicker = DKColorPickerWithColors(MainRedColor,NightMainBGColor,MainRedColor);

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:cell];
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainColor,MainRedColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(100*AdaptiveScale_W);
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
                [self loadData];
            }
                
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
        }
        
        
    }];
    
    if (STUserDefaults.isLogin){
        
        [self loadData];
        
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
    }

}

#pragma mark askForData
-(void)loadData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [STRequest GetPlayerTudiListDataAndPageNum:_page WithBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            JLLog(@"ServersData---%@",ServersData);
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if (ServersData[@"c"]) {
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSArray *arrtemp = [NSArray arrayWithArray:dictemp[@"discs"]];
                    
                    if (arrtemp.count == 0) {
                        [SVProgressHUD showErrorWithStatus:@"推荐更多好友，获得更多奖励哦！"];
                    } else {
                        for (int i = 0; i<arrtemp.count; i++) {
                            [self.infoArr addObject:arrtemp[i]];
                        }
                        [self.tableView reloadData];
                        _page = [dictemp[@"pagenum"] intValue];
                        _totalpage = [dictemp[@"totalpage"] intValue];
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
    static NSString *identity = @"XWAppreListCell";
    
//    if (indexPath.section == 0) {
    
        
//    }else{
    
        XWAppreListCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (cell == nil)
        {
            cell = [[XWAppreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            
        }
        [cell setcell:_infoArr[indexPath.row] withindex:indexPath.row+1];

        return cell;
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100*AdaptiveScale_W;
        
    }else
    {
        return 90*AdaptiveScale_W;
    }
}


- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray new] ;
    }
    return _infoArr;
}

@end
