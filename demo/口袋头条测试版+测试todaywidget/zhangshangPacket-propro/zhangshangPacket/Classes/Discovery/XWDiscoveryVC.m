//
//  XWDiscoveryVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWDiscoveryVC.h"
#import "XWSearchVC.h"
#import "XWShareButton.h"
#import "XWDiscoveryModel.h"
#import "XWNewestenterCell.h"
#import "WKWebViewController.h"
#import "XWMidButton.h"
#import "XWDisMoreDataVC.h"
#import "XWDisEditRecommendModel.h"
#import "XWTodayHotVC.h"
#import "XWDisBestAblumVC.h"
#import "XWDisFastestDetailVC.h"
#import "XWDisHeaderView.h"
#import "XWMidCollectCell.h"


@interface XWDiscoveryVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    BOOL flag;
    NSInteger selectIndex;

}

@property (nonatomic, strong) NSMutableArray *headerArr;

@property (nonatomic, strong) NSMutableArray *midArr;

@property (nonatomic, strong) NSMutableArray *bottomArr;

@property (nonatomic, strong) NSMutableArray *bottomListArr;

@property (nonatomic, strong) XWDiscoveryModel *dataModel;

@property (nonatomic, strong) UIButton *otherData;

@property (nonatomic, strong) NSMutableArray *midOtherArr;

@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation XWDiscoveryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBGColor;
    //设置tableview
    [self setupTableView];
    [self loadData];
    
}

- (void)loadData{
    [self.headerArr removeAllObjects];
    [self.midArr removeAllObjects];
    [self.bottomArr removeAllObjects];
    
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];
    [STRequest DiscoverInfoDataBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"serdata---%@",ServersData);
        
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                NSString *cStr = [NSString stringWithFormat:@"%@",ServersData[@"c"]];
                if ([cStr isEqualToString:@"1"]) {
                    
                    [SVProgressHUD dismiss];
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSMutableArray *tempArray1 = [XWEditSelected mj_objectArrayWithKeyValuesArray:dictemp[@"editselection"]];
                    NSMutableArray *tempArray2 = [XWEditRecommend mj_objectArrayWithKeyValuesArray:dictemp[@"editrecommend"]];
                    NSMutableArray *tempArray3 = [XWNewestenter mj_objectArrayWithKeyValuesArray:dictemp[@"newestenter"]];

                    for (int i = 0; i<tempArray1.count; i++) {
                        [self.headerArr addObject:tempArray1[i]];
                    }
                    for (int i = 0; i<tempArray2.count; i++) {
                        [self.midArr addObject:tempArray2[i]];
                        [self.collectView reloadData];
                    }
                    for (int i = 0; i<tempArray3.count; i++) {
                        [self.bottomArr addObject:tempArray3[i]];
                        [self.tableView reloadData];
                    }
                    [self setupheaderView];

                    JLLog(@"headerArr--%@ midArr--%@ bottomArr---%@",self.headerArr,self.midArr,self.bottomArr);
                   
                } else {
                    [SVProgressHUD dismiss];
                    JLLog(@"错误：%@",ServersData[@"m"]);
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];

            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
            
        }
        
    }];
    
    
}


- (void)setupTableView
{

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , ScreenW, ScreenH-60) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
}

- (void)setupheaderView
{
    UIView *allHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 270*AdaptiveScale_W)];
    allHeaderView.backgroundColor = [UIColor clearColor];
    
    //头部view
    XWDisHeaderView *headerView = [[XWDisHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 100*AdaptiveScale_W)];
    [allHeaderView addSubview:headerView];
    headerView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainNaviColor,MainRedColor);
    XWEditSelected *selected1 = self.headerArr[0];
    XWEditSelected *selected2 = self.headerArr[1];

    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(todayHotClick:)];
    [headerView.leftView addGestureRecognizer:leftTap];
    [headerView.ablumImgLeft sd_setImageWithURL:[NSURL URLWithString:selected1.pic] placeholderImage:MyImage(@"bg_default") options:SDWebImageRefreshCached];
    headerView.titleLabLeft.text = selected1.title;
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreAbulmClick:)];
    [headerView.rightView addGestureRecognizer:rightTap];
    [headerView.ablumImgRight sd_setImageWithURL:[NSURL URLWithString:selected2.pic] placeholderImage:MyImage(@"bg_default") options:SDWebImageRefreshCached];
    headerView.titleLabRight.text = selected2.title;
    
    //中部view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100*AdaptiveScale_W, ScreenW, 45*AdaptiveScale_W)];
    [allHeaderView addSubview:view];
    view.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainNaviColor,MainRedColor);
    UILabel *label = [[UILabel alloc]init];
    label.text = @"小编推荐";
    label.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    label.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.width.mas_equalTo(80*AdaptiveScale_W);
        make.height.mas_equalTo(35*AdaptiveScale_W);
    }];
    
    UIButton *otherData = [[UIButton alloc]init];
    self.otherData = otherData;
    [otherData setTitle:@"换一批" forState:0];
    otherData.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    [otherData setTitleColor:MainTextColor forState:0];
    [otherData setImage:MyImage(@"icon_update") forState:0];
    [otherData setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [otherData addTarget:self action:@selector(ChangeOtherDataClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:otherData];
    [otherData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(15*AdaptiveScale_W);
        make.centerY.mas_equalTo(label.mas_centerY);
        make.width.mas_equalTo(120*AdaptiveScale_W);
        make.height.mas_equalTo(45*AdaptiveScale_W);
    }];
    
    UIView *bottom = [[UIView alloc]init];
    bottom.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainBGColor,MainRedColor);
    [view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.itemSize = CGSizeMake((ScreenW - 4*10)/3, 120*AdaptiveScale_W);
//    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 50);
//    layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 50);
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 145*AdaptiveScale_W, ScreenW, 120*AdaptiveScale_W) collectionViewLayout:layout];
    
    self.collectView = collectView;
    [allHeaderView addSubview:collectView];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    [collectView registerClass:[XWMidCollectCell class] forCellWithReuseIdentifier:NSStringFromClass([XWMidCollectCell class])];
    self.tableView.tableHeaderView = allHeaderView;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
};

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.midArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XWMidCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XWMidCollectCell class]) forIndexPath:indexPath];
    DisEditRecModel *temp;
    temp = self.midArr[indexPath.row];
    if (temp!=nil) {
        [cell setTheCellDataWithModel:temp ];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    // 取消选中状态
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    DisEditRecModel *dataModel = self.midArr[indexPath.row];
    
    XWDisFastestDetailVC *detailVC = [[XWDisFastestDetailVC alloc]init];
    detailVC.artid = dataModel.id;
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC setHidesBottomBarWhenPushed:YES];
    
}


- (void)todayHotClick:(id)sender
{
    //热点文章
    JLLog(@"todayHotClick");
    XWTodayHotVC *todayHotVC = [[XWTodayHotVC alloc]init];
    [self.navigationController pushViewController:todayHotVC animated:YES];
}

- (void)moreAbulmClick:(id)sender
{
    //更多专辑
    JLLog(@"moreAbulmClick");
    XWDisBestAblumVC *bestAblumVC = [[XWDisBestAblumVC alloc]init];
    [self.navigationController pushViewController:bestAblumVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bottomArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWNewestenter *enterModel = self.bottomArr[indexPath.row];
    XWNewestenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XWNewestenterCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell) {
        cell = [[XWNewestenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWNewestenterCell"];
    }
    cell.dataModel = enterModel;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XWNewestenter *enterModel = self.bottomArr[indexPath.row];
    
    XWDisFastestDetailVC *detailVC = [[XWDisFastestDetailVC alloc]init];
    detailVC.artid = enterModel.id;
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC setHidesBottomBarWhenPushed:YES];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 45*AdaptiveScale_W)];
    view.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainNaviColor,MainRedColor);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15*AdaptiveScale_W, 0, ScreenW*0.4, 45*AdaptiveScale_W)];
    label.text = @"上升最快";
    label.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    label.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
    [view addSubview:label];
    
    UIButton *otherData = [[UIButton alloc]xw_initWithFrame:CGRectMake(ScreenW-80*AdaptiveScale_W, 0, 65*AdaptiveScale_W, 45*AdaptiveScale_W)];
//    otherData.yj_centerY = view.yj_centerY;
    [otherData setTitle:@"更多" forState:0];
    otherData.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    [otherData setTitleColor:MainTextColor forState:0];
    [otherData setImagePosition:LXMImagePositionRight spacing:10];
    [otherData setImage:MyImage(@"icon_discovery_more") forState:0];
    [otherData addTarget:self action:@selector(moreDataClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:otherData];
    
    UIView *bottom = [[UIView alloc]init];
    bottom.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainBGColor,MainRedColor);
    [view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    return view;
    
}

- (void)ChangeOtherDataClick:(id)sender
{
    JLLog(@"ChangeOtherDataClick");

    if (flag) {
        [UIView animateWithDuration:1 animations:^{
            _otherData.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            flag = NO;
        }];
    }
    else {
        [UIView animateWithDuration:1 animations:^{
            _otherData.imageView.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            flag = YES;
        }];
    }
    [self.midArr removeAllObjects];
    [STRequest DiscoverEditRecommendInfoDataBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"serversdata---%@",ServersData);
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                NSString *cStr = [NSString stringWithFormat:@"%@",ServersData[@"c"]];
                if ([cStr isEqualToString:@"1"]) {
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSMutableArray *tempArr = [DisEditRecModel mj_objectArrayWithKeyValuesArray:dictemp[@"editrecommend"]];
                    
                    for (int i = 0; i < tempArr.count; i++) {
                        [self.midArr addObject:tempArr[i]];
                        [self.collectView reloadData];

                    }
                    
                } else {
                    JLLog(@"错误：%@",ServersData[@"m"]);
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
                
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
            
        }
        
    }];
    
    
    
}

- (void)moreDataClick:(id)sender
{
    JLLog(@"moreDataClick");
    XWDisMoreDataVC *moreDataVC = [[XWDisMoreDataVC alloc]init];
    [self.navigationController pushViewController:moreDataVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45*AdaptiveScale_W;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return 150*AdaptiveScale_W;
//    }else{
    return 75*AdaptiveScale_W;
//    }

}

- (NSMutableArray *)headerArr
{
    if (!_headerArr) {
        _headerArr = [NSMutableArray array];
    }
    return _headerArr;
}

- (NSMutableArray *)midArr
{
    if (!_midArr) {
        _midArr = [NSMutableArray array];
    }
    return _midArr;
}
- (NSMutableArray *)midOtherArr
{
    if (!_midOtherArr) {
        _midOtherArr = [NSMutableArray array];
    }
    return _midOtherArr;
}
- (NSMutableArray *)bottomArr
{
    if (!_bottomArr) {
        _bottomArr = [NSMutableArray array];
    }
    return _bottomArr;
}
- (NSMutableArray *)bottomListArr
{
    if (!_bottomListArr) {
        _bottomListArr = [NSMutableArray array];
    }
    return _bottomListArr;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    //    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    //    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
    //        statusBar.backgroundColor = color;
    //    }
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self preferredStatusBarStyle];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
    [self setStatusBarBackgroundColor:MainRedColor];
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW*0.4, 10, ScreenW*0.8, 50)];
    [searchBtn setImage:MyImage(@"icon_discover_search") forState:0];
    searchBtn.adjustsImageWhenHighlighted = NO;
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.titleView = searchBtn;

}

- (void)searchClick
{
    [self.navigationController pushViewController:[XWSearchVC new] animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)deleteImageFromImage:(UIImage *)image
{
    CGImageRef imageRef = image.CGImage;
    CGRect rect = CGRectMake(170, 170, 91, 91);
    CGImageRef image1 = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage *newImage = [[UIImage alloc] initWithCGImage:image1];
    return newImage;
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
