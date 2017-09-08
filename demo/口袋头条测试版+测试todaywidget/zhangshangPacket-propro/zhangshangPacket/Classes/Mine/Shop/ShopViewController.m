//
//  ShopViewController.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/2/21.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopCategoryCell.h"
#import "ShopListCell.h"


#import "UIScrollView+EmptyDataSet.h"

#import "GoodsListModel.h"
#import "GoodsDetailViewController.h"

@interface ShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource>
{
    NSArray *categoryArr;
    NSInteger selectIndex;
    int _currPage;
    int _maxPage;
    NSInteger _type;
    BOOL isFirstGet;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, strong) GoodsListModel *dataModel;
@property (nonatomic, strong) NSMutableArray *firstArr;
@property (nonatomic, strong) NSMutableArray *secondArr;
@property (nonatomic, strong) NSMutableArray *thirdArr;
@property (nonatomic, strong) NSMutableArray *fourthArr;
@property (nonatomic, strong) NSMutableArray *fifthArr;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTheView];
    [self.collectionView.mj_header beginRefreshing];
    
}
#pragma mark addTheView
-(void)addTheView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadGoodsList) name:@"rssseloadGoodsList" object:nil];
    NSLog(@"123");
    categoryArr = @[@"全部",@"居家",@"配件",@"饰品",@"零食",@"出行"];
    selectIndex = 0;
    _type = -1;
    self.tableView.backgroundColor = MainBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.infoArr removeAllObjects];
        [self.firstArr removeAllObjects];
        [self.secondArr removeAllObjects];
        [self.thirdArr removeAllObjects];
        [self.fourthArr removeAllObjects];
        [self.fifthArr removeAllObjects];
        _currPage = 1;
        [self askForDataWithPage:_currPage];
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tableView.mas_right);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.right.mas_equalTo(0);
    }];
}
-(void)reloadGoodsList
{
    [self.infoArr removeAllObjects];
    [self.firstArr removeAllObjects];
    [self.secondArr removeAllObjects];
    [self.thirdArr removeAllObjects];
    [self.fourthArr removeAllObjects];
    [self.fifthArr removeAllObjects];
    _currPage = 1;
    isFirstGet = NO;
    [self askForDataWithPage:_currPage];
}
-(void)askForDataWithCategoryPage:(int)page
{
    self.tableView.userInteractionEnabled = NO;
    _currPage = page;
    NSDictionary *param = @{@"pagenum":@(_currPage)};
    [STRequest ShopListWithParam:param andDataBlock:^(id ServersData, BOOL isSuccess) {
        self.dataModel = [GoodsListModel mj_objectWithKeyValues:ServersData];
        self.tableView.userInteractionEnabled = YES;
     
        NSLog(@"商品列表%@",self.dataModel.d.goods);
        //        NSLog(@"商品列表%@",ServersData);
        
        if (isSuccess)
        {
            if (self.dataModel.c == 1)
                {
                    if (isFirstGet == NO)
                    {
                        for (ItemDetail *temp in self.dataModel.d.goods) {
                            
                            
                            switch ([ServersData[@"d"][@"pagenum"] intValue])
                            {
                                case 1:
                                    
                                    [self.firstArr addObject:temp];
                                    
                                    break;
                                case 2:
                                    [self.secondArr addObject:temp];
                                    
                                    break;
                                case 3:
                                    [self.thirdArr addObject:temp];
                                    
                                    break;
                                case 4:
                                    [self.fourthArr addObject:temp];
                                    
                                    break;
                                case 5:
                                    [self.fifthArr addObject:temp];
                                    break;
                                    
                                default:
                                    break;
                            }
                            
                        }
                    }
                    for (ItemDetail *temp in ServersData[@"d"][@"goods"]) {
                        [self.infoArr addObject:temp];
                        
                    }
                    NSLog(@"XXXXX%@",self.infoArr);
                    _maxPage =[ServersData[@"d"][@"totalpage"]integerValue] ;
                    
                    //                GoodsListData *tempItem;
                    if (page<_maxPage) {
                        _currPage++;
                        NSLog(@"max   =  %d   , page = %d",_maxPage,_currPage);
                        [self askForDataWithPage:_currPage];
                    }else{
                        isFirstGet = YES;
                        [self.collectionView.mj_header endRefreshing];
                        [self.collectionView.mj_footer endRefreshing];
                        [self.collectionView reloadData];
                    }
                }else
                    {
                        [self.collectionView.mj_header endRefreshing];
                        [self.collectionView.mj_footer endRefreshing];
                        [SVProgressHUD showErrorWithStatus:self.dataModel.m];
                    }
                
        }else
        {
            self.tableView.userInteractionEnabled = YES;
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            [SVProgressHUD showErrorWithStatus:@"网络故障，请稍后"];
        }
    }];
}
-(void)askForDataWithPage:(int)page
{
    self.tableView.userInteractionEnabled = NO;
    _currPage = page;
    NSLog(@"page  === %@",@(_currPage));
    NSDictionary *param = @{@"pagenum":@(_currPage)};
    [STRequest ShopListWithParam:param andDataBlock:^(id ServersData, BOOL isSuccess) {
        self.dataModel = [GoodsListModel mj_objectWithKeyValues:ServersData];
        self.tableView.userInteractionEnabled = YES;
        NSLog(@"商品列表%@",self.dataModel.d.goods);
//        NSLog(@"商品列表%@",ServersData);

        if (isSuccess)
        {
            if (self.dataModel.c == 1)
            {
            
                    NSLog(@"tempitem ========%@",ServersData[@"d"][@"pagenum"] );
                    if (isFirstGet == NO)
                    {
                        for (ItemDetail *temp in self.dataModel.d.goods) {
                            
                        
                        switch ([ServersData[@"d"][@"pagenum"] intValue])
                        {
                            case 1:
                               
                                    [self.firstArr addObject:temp];
                                NSLog(@"1111%@",temp);
                                break;
                            case 2:
                                [self.secondArr addObject:temp];

                                break;
                            case 3:
                                [self.thirdArr addObject:temp];

                                break;
                            case 4:
                                [self.fourthArr addObject:temp];

                                break;
                            case 5:
                               [self.fifthArr addObject:temp];
                                break;
                                
                            default:
                                break;
                        }
                        
                    }
                    }
                for (ItemDetail *temp in self.dataModel.d.goods) {
                    [self.infoArr addObject:temp];

                }
                NSLog(@"XXXXX%@",self.infoArr);
                    _maxPage =[ServersData[@"d"][@"totalpage"]integerValue] ;
                
//                GoodsListData *tempItem;
                if (page<_maxPage) {
                    _currPage++;
                    NSLog(@"max   =  %d   , page = %d",_maxPage,_currPage);
                    [self askForDataWithPage:_currPage];
                }else{
                    isFirstGet = YES;
                    [self.collectionView.mj_header endRefreshing];
                    [self.collectionView.mj_footer endRefreshing];
                    [self.collectionView reloadData];
                }

         
            }else
            {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer endRefreshing];
                [SVProgressHUD showErrorWithStatus:self.dataModel.m];
            }
        }else
        {
            self.tableView.userInteractionEnabled = YES;
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            [SVProgressHUD showErrorWithStatus:@"网络故障，请稍后"];
        }
    }];
    
    
}
#pragma mark btnAction

#pragma mark Empty_Data
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return MyImage(@"wushuju_");
}
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSDictionary *attribs = @{NSFontAttributeName: [UIFont systemFontOfSize:RemindFont(13, 15, 17)],
//                              NSForegroundColorAttributeName:[UIColor redColor]};
//    NSMutableAttributedString *attributedText =[[NSMutableAttributedString alloc] initWithString:@"暂无该此类商品！"attributes:attribs];
//    return attributedText;
//}
#pragma mark UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return categoryArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identity = @"ShopCategoryCell";
    ShopCategoryCell *cell = [[ShopCategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    if (categoryArr[indexPath.row] != nil)
    {
        [cell setTheCellData:categoryArr[indexPath.row] andIndexPath:indexPath.row andSelectIndexPath:selectIndex];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*AdaptiveScale_W;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView.mj_footer resetNoMoreData];
    if (indexPath.row == 0)
    {
        _type = -1;
        selectIndex = indexPath.row;
        [self.tableView reloadData];
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.infoArr removeAllObjects];
            [self.firstArr removeAllObjects];
            [self.secondArr removeAllObjects];
            [self.thirdArr removeAllObjects];
            [self.fourthArr removeAllObjects];
            [self.fifthArr removeAllObjects];
            _currPage = 1;
            isFirstGet = NO;
            [self askForDataWithPage:_currPage];
        }];
        self.collectionView.mj_footer = nil;
        [self.collectionView.mj_header beginRefreshing];
        
    }else
    {
        _type = indexPath.row;
        selectIndex = indexPath.row;
        [self.tableView reloadData];
        self.collectionView.mj_header = nil;
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            _currPage++;
//            if (_currPage < _maxPage) {
//                
//                [self askForDataWithCategoryPage:_currPage];
//                
//            }else{
//                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//                self.collectionView.mj_footer.automaticallyHidden = YES;
//            }
            [self askForDataWithCategoryPage:_currPage];
        }];
        [self.collectionView reloadData];
        
    }
    
    
}
#pragma mark UICollectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (selectIndex == 0)
    {
        return self.infoArr.count;
    }else if (selectIndex == 1)
    {
        return self.firstArr.count;
    }else if (selectIndex == 2)
    {
        return self.secondArr.count;
    }else if (selectIndex == 3)
    {
        return self.thirdArr.count;
    }else if (selectIndex == 4)
    {
        return self.fourthArr.count;
    }else
    {
        return self.fifthArr.count;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShopListCell class]) forIndexPath:indexPath];
    ItemDetail *tempModel;
    if (selectIndex == 0)
    {
        if (self.infoArr[indexPath.row] != nil)
        {
            tempModel = self.infoArr[indexPath.row];
        }
    }else if (selectIndex == 1)
    {
        if (self.firstArr[indexPath.row] != nil)
        {
            tempModel = self.firstArr[indexPath.row];
        }
    }else if (selectIndex == 2)
    {
        if (self.secondArr[indexPath.row] != nil)
        {
            tempModel = self.secondArr[indexPath.row];
        }
    }else if (selectIndex == 3)
    {
        if (self.thirdArr[indexPath.row] != nil)
        {
            tempModel = self.thirdArr[indexPath.row];
        }
    }else if (selectIndex == 4)
    {
        if (self.fourthArr[indexPath.row] != nil)
        {
            tempModel = self.fourthArr[indexPath.row];
        }
    }else
    {
        if (self.fifthArr[indexPath.row] != nil)
        {
            tempModel = self.fifthArr[indexPath.row];
        }
    }
    if (tempModel != nil)
    {
        NSLog(@"XXXXXXX%@",tempModel);
        [cell setTheCellDataWithModel:tempModel andPhotoPre:STUserDefaults.imgurlpre];
    }
    
    WeakType(self);
    cell.comeBtnBlock = ^{
        GoodsDetailViewController *detailVC = [GoodsDetailViewController new];
        detailVC.hidesBottomBarWhenPushed = YES;
        
//        if (tempModel.imgUrl.length == 0)
//        {
//            tempModel.imgUrl = [NSString stringWithFormat:@"%@%@",STUserDefaults.goods_pre,tempModel.img];
//        }
        detailVC.dataModels = tempModel;
        [weakself.navigationController pushViewController:detailVC animated:YES];
        
    };
    return cell;
}
#pragma mark UICollectionView delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController *detailVC = [GoodsDetailViewController new];
    detailVC.hidesBottomBarWhenPushed = YES;
    ItemDetail *tempModel;
    if (selectIndex == 0)
    {
        if (self.infoArr[indexPath.row] != nil)
        {
            tempModel = self.infoArr[indexPath.row];
        }
    }else if (selectIndex == 1)
    {
        if (self.firstArr[indexPath.row] != nil)
        {
            tempModel = self.firstArr[indexPath.row];
        }
    }else if (selectIndex == 2)
    {
        if (self.secondArr[indexPath.row] != nil)
        {
            tempModel = self.secondArr[indexPath.row];
        }
    }else if (selectIndex == 3)
    {
        if (self.thirdArr[indexPath.row] != nil)
        {
            tempModel = self.thirdArr[indexPath.row];
        }
    }else if (selectIndex == 4)
    {
        if (self.fourthArr[indexPath.row] != nil)
        {
            tempModel = self.fourthArr[indexPath.row];
        }
    }else
    {
        if (self.fifthArr[indexPath.row] != nil)
        {
            tempModel = self.fourthArr[indexPath.row];
        }
    }
//    
//    if (tempModel.imgUrl.length == 0)
//    {
//        tempModel.imgUrl = [NSString stringWithFormat:@"%@%@",STUserDefaults.goods_pre,tempModel.img];
//    }
    detailVC.dataModels = tempModel;
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark get
-(UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(IPHONE_W-70, 80);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = WhiteColor;
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        [_collectionView registerClass:[ShopListCell class] forCellWithReuseIdentifier:NSStringFromClass([ShopListCell class])];
    }
    return _collectionView;
}
-(NSMutableArray *)infoArr
{
    if (_infoArr == nil)
    {
        _infoArr = [NSMutableArray new];
    }
    return _infoArr;
}
-(NSMutableArray *)firstArr
{
    if (_firstArr == nil)
    {
        _firstArr = [NSMutableArray new];
    }
    return _firstArr;
}
-(NSMutableArray *)secondArr
{
    if (_secondArr == nil)
    {
        _secondArr = [NSMutableArray new];
    }
    return _secondArr;
}
-(NSMutableArray *)thirdArr
{
    if (_thirdArr == nil)
    {
        _thirdArr = [NSMutableArray new];
    }
    return _thirdArr;
}
-(NSMutableArray *)fourthArr
{
    if (_fourthArr == nil)
    {
        _fourthArr = [NSMutableArray new];
    }
    return _fourthArr;
}
-(NSMutableArray *)fifthArr
{
    if (_fifthArr == nil)
    {
        _fifthArr = [NSMutableArray new];
    }
    return _fifthArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
