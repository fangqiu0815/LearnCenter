//
//  ShoppingViewController.m
//  zhangshangPacket
//
//  Created by zhenhui huang on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "ShoppingViewController.h"
#import "shopCollectionViewCell.h"
#import "UIScrollView+EmptyDataSet.h"
#import "HomeHeadView.h"

#import "GoodsListModel.h"
#import "GoodsDetailViewController.h"
#import "XWPacketNewVC.h"
#import "XWRecordListVC.h"

@interface ShoppingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    int _currPage;
    int _maxPage;
    UIImageView *navBarHairlineImageView;
}
@property (nonatomic, strong) UICollectionView *myCollectionV;
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, strong) GoodsListModel *dataModel;
@property (nonatomic, strong) HomeHeadView *headView;


@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadGoodsList) name:@"reloadGoodsList" object:nil];
    self.view.backgroundColor = MainBGColor;
    self.title = @"商城";
    [self addTheView];
    [self.myCollectionV.mj_header beginRefreshing];

    // 删除navigationbar下的横线
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

-(void)reloadGoodsList
{
    [self.infoArr removeAllObjects];

    _currPage = 1;

    [self askForDataWithPage:_currPage];
}

-(void)addTheView{
    self.myCollectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.infoArr removeAllObjects];
        _currPage = 1;
        [self askForDataWithPage:_currPage];
    }];
  
    self.myCollectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (_currPage<_maxPage) {
            _currPage++;
            [self askForDataWithPage:_currPage];
            }else{
                [self.myCollectionV.mj_footer endRefreshing];
                [SVProgressHUD showSuccessWithStatus:@"数据已完"];
            }
    }];
    [self.view addSubview:self.myCollectionV];

}

//获取商品数组信息
-(void)askForDataWithPage:(int)page{
    self.myCollectionV.userInteractionEnabled = NO;
    _currPage = page;
    
    NSDictionary *param = @{@"pagenum":@(_currPage)};
    
    [STRequest ShopListWithParam:param andDataBlock:^(id ServersData, BOOL isSuccess) {
        self.dataModel = [GoodsListModel mj_objectWithKeyValues:ServersData];
        //JLLog(@"ServersData---%@",ServersData);
        self.myCollectionV.userInteractionEnabled = YES;
        if (isSuccess) {
            if (self.dataModel.c == 1) {
          
                    if ([ServersData[@"d"][@"pagenum"]intValue] == 1) {
                        [self.infoArr removeAllObjects];
                    }
                        for (ItemDetail *temp in self.dataModel.d.goods)   {
                            [self.infoArr addObject:temp];
                    }
                
                _maxPage = [self.dataModel.d.totalpage intValue];
                [self.myCollectionV.mj_header endRefreshing];
                [self.myCollectionV.mj_footer endRefreshing];
                [self.myCollectionV reloadData];
            }else{
                [self.myCollectionV.mj_header endRefreshing];
                [self.myCollectionV.mj_footer endRefreshing];
                [SVProgressHUD showErrorWithStatus:self.dataModel.m];
            }
        }else{
            self.myCollectionV.userInteractionEnabled = YES;
            
            [self.myCollectionV.mj_header endRefreshing];
            [self.myCollectionV.mj_footer endRefreshingWithNoMoreData];
            [SVProgressHUD showErrorWithStatus:@"网络故障，请稍后"];
        }
    }  ];

}

//#pragma mark Empty_Data
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return MyImage(@"wushuju_");
//}

#pragma mark collectionV的代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.infoArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    shopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([shopCollectionViewCell class]) forIndexPath:indexPath];
    ItemDetail *temp;
    temp = self.infoArr[indexPath.row];
    if (temp!=nil) {
        [cell setTheCellDataWithModel:temp andPhotoPre:STUserDefaults.imgurlpre];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailViewController *detailVC = [GoodsDetailViewController new];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.dataModels = self.infoArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"HomeHeadView"
                                                                        forIndexPath:indexPath];
    [headView addSubview:self.headView];
    return headView;
}

#pragma mark 懒加载
-(UICollectionView *)myCollectionV{
    if (_myCollectionV == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((ScreenW-2)/2, 185*AdaptiveScale_W);
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.headerReferenceSize = CGSizeMake(ScreenW, 285*AdaptiveScale_W);
        _myCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) collectionViewLayout:flowLayout];
        _myCollectionV.backgroundColor = MainBGColor;
        _myCollectionV.delegate = self;
        _myCollectionV.dataSource = self;
        _myCollectionV.emptyDataSetSource = self;
        _myCollectionV.emptyDataSetDelegate = self;
        
        //注册头视图
        [_myCollectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeadView"];
        [_myCollectionV registerClass:[shopCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([shopCollectionViewCell class])];
    }
    return _myCollectionV;
}

- (NSMutableArray *)infoArr
{
    if (_infoArr == nil)
    {
        _infoArr = [NSMutableArray new];
    }
    return _infoArr;
}

- (HomeHeadView *)headView{
    if (_headView == nil) {
        _headView = [[HomeHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 285*AdaptiveScale_W)];
        NSArray *arr = @[@"icon_turntable_1080"];
        _headView.bannerScrollView.imageURLStringsGroup = arr;
        _headView.NumLab.text = [NSString stringWithFormat:@"%@",STUserDefaults.cash];
        [_headView.exchangeBtn addTarget:self action:@selector(exchangeRecordClick) forControlEvents:UIControlEventTouchUpInside];
        WeakType(self);
        //轮播图点击事件
        self.headView.AdClickBlock = ^(NSInteger tempIndex) {
            
            XWPacketNewVC *turnTableVC = [[XWPacketNewVC alloc]init];
            turnTableVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:turnTableVC animated:YES];
            
        };
    }
    return _headView;
}

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
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.barTintColor = MainRedColor;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNumLab" object:nil];
    navBarHairlineImageView.hidden = YES;

    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我的商城";
    label.font = [UIFont systemFontOfSize:18];
    
    self.navigationItem.titleView = label;
    

}

- (void)exchangeRecordClick
{
    XWRecordListVC *recordListVC = [[XWRecordListVC alloc]init];
    [self.navigationController pushViewController:recordListVC animated:YES];

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
