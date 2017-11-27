//
//  KFUserController.m
//  KingFamily
//
//  Created by 张强 on 16/4/15.
//  Copyright © 2016年 King. All rights reserved.
//

#define ID @"gegejia"

#import "KFUserController.h"
#import "KingFamily.h"




@interface KFUserController ()<UICollectionViewDataSource, UICollectionViewDelegate>

// vip区域头像背景
@property(nonatomic, strong)UIImageView *iconImageView;

// myOrderView部分
@property(nonatomic, strong)UIView *myOrderView;

// myOrderButton
@property(nonatomic, strong)UIButton *myOrderButton;

// collectionViewButtonItems模型数组
@property(nonatomic, strong)NSMutableArray *collectionViewButtonItemsArrayM;

// managerOrder中按钮数组
@property(nonatomic, strong)NSMutableArray *managerOrderButtonsArray;

// collectionView
@property(nonatomic, strong)UICollectionView *collectionView;

//collectionViewCell 布局方式
@property(nonatomic, strong)UICollectionViewLayout *layout;





@end

@implementation KFUserController
/*
// 懒加载collectionViewItems数组
-(NSMutableArray *)collectionViewButtonItemsArrayM{
    if (_collectionViewButtonItemsArrayM == nil) {
        _collectionViewButtonItemsArrayM = [[NSMutableArray alloc] init];
        
        [_collectionViewButtonItemsArrayM addObject:[KFCollectionCellButtonItem collectionCellButtonItemWithImageName:nil title:@"签到" detailTitle:@"领取今日奖励"]];
        [_collectionViewButtonItemsArrayM addObject:[KFCollectionCellButtonItem collectionCellButtonItemWithImageName:nil title:@"收藏" detailTitle:nil]];
        [_collectionViewButtonItemsArrayM addObject:[KFCollectionCellButtonItem collectionCellButtonItemWithImageName:nil title:@"优惠券" detailTitle:@"兑换优惠券"]];
        [_collectionViewButtonItemsArrayM addObject:[KFCollectionCellButtonItem collectionCellButtonItemWithImageName:nil title:@"积分" detailTitle:nil]];
        [_collectionViewButtonItemsArrayM addObject:[KFCollectionCellButtonItem collectionCellButtonItemWithImageName:nil title:@"新人专享" detailTitle:nil]];
        [_collectionViewButtonItemsArrayM addObject:[KFCollectionCellButtonItem collectionCellButtonItemWithImageName:nil title:@"客服与帮助" detailTitle:nil]];
        [_collectionViewButtonItemsArrayM addObject:[KFCollectionCellButtonItem collectionCellButtonItemWithImageName:nil title:@"意见与反馈" detailTitle:nil]];
        [_collectionViewButtonItemsArrayM addObject:[KFCollectionCellButtonItem collectionCellButtonItemWithImageName:nil title:@"关于格格家" detailTitle:nil]];
         [_collectionViewButtonItemsArrayM addObject:[KFCollectionCellButtonItem collectionCellButtonItemWithImageName:nil title:@"关于格格家" detailTitle:nil]];
    }
    return _collectionViewButtonItemsArrayM;
}


*/


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    设置表格表头
    [self setupHeaderView];
    [self setNavigationBar];
    
}

//    设置表格表头
-(void)setupHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    headerView.backgroundColor = [UIColor redColor];
    
    self.tableView.tableHeaderView = headerView;
}
#pragma mark - 设置“设置”界面导航条上内容
-(void)setNavigationBar
{
    self.title = @"我的";
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(settingrightBarButtonItemClick)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark - 监听“设置”见面导航条右端设置按钮点击
-(void)settingrightBarButtonItemClick
{
//    NSLog(@"监听“设置”见面导航条右端设置按钮点击");
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 21;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 2;
//}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        
//        
//        
//    }else if(indexPath.row == 1){
//        
//    }
//    return nil;
//}

@end
