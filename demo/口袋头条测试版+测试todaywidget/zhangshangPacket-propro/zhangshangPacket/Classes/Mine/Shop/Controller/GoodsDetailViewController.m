//
//  GoodsDetailViewController.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/2/24.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "ConfirmOrderViewController.h"

#import "DetailHeadView.h"
#import "DetailListCell.h"
#import "GoodsDetailModel.h"

@interface GoodsDetailViewController ()
@property (nonatomic, strong) UIButton *changeBtn;
@property (nonatomic, strong) DetailHeadView *headView;
@property (nonatomic, strong) GoodsDetailModel *infoModels;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTheView];
    [self askForData];
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
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"商品详情";
    label.font = [UIFont systemFontOfSize:18];
    
    self.navigationItem.titleView = label;
    
}


-(void)askForData
{

    NSString *urlstr = [NSString stringWithFormat:@"%@%@",STUserDefaults.imgurlpre,self.dataModels.img];
    [self.headView.photoImage sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:MyImage(@"login_default")];
    self.headView.titleLab.text = self.dataModels.name;
    self.headView.integralLab.text = [NSString stringWithFormat:@"价格:%.2f元",[self.dataModels.cash floatValue]/100.0];
    self.headView.repertoryLab.text = [NSString stringWithFormat:@"库存：%@",self.dataModels.num];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    NSDictionary *params = @{@"goodsid":self.dataModels.id};
    [STRequest DetailGoodsWithParams:params andDataBlock:^(id ServersData, BOOL isSuccess){
        self.infoModels = [GoodsDetailModel mj_objectWithKeyValues:ServersData];
        if (isSuccess)
        {
//            NSLog(@"商品详情%@",self.infoModels.d.desc_);
            if (self.infoModels.c == 1)
            {
                
                [self.tableView reloadData];
                [SVProgressHUD dismiss];
            }else
            {
                [SVProgressHUD showErrorWithStatus:self.infoModels.m];
            }
            
        }
    }];
    
//    [STRequest InventoryGoodsWithID:self.dataModel.id andDataBlock:^(id ServersData, BOOL isSuccess) {
//        
//    }];
    
}
#pragma mark addTheView
-(void)addTheView
{
    self.title = @"商品详情";
    self.navigationController.navigationBar.tintColor  = WhiteColor;

    self.view.backgroundColor = WhiteColor;
    
    [self.view addSubview:self.changeBtn];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(49*AdaptiveScale_W);
    }];
    
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*AdaptiveScale_W);
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.changeBtn.mas_top);
    }];
}
#pragma mark btnAction
-(void)mangeAddressBtnAction
{
    
}
-(void)changeBtnAction
{
    if (STUserDefaults.isLogin)
    {
        ConfirmOrderViewController *confirmVC = [ConfirmOrderViewController new];
        confirmVC.dataModels = self.dataModels;
        [self.navigationController pushViewController:confirmVC animated:YES];
        
    }else
    {
        if (STUserDefaults.ischeck == 0) {
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
            
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            }]];
        
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
}
#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSString *tempStr  = self.infoModels.d.desc_;
        CGFloat titleHeight = [tempStr sizeOfTextWithMaxSize:Size(IPHONE_W, MAXFLOAT) font:[UIFont systemFontOfSize:RemindFont(12, 14, 16)]].height+30;
        
        CGFloat cellHeight = 20+5+25*AdaptiveScale_W+titleHeight;
        return cellHeight;
    }else
    {
        NSString *tempStr =@"1.除港澳台外，全国包邮;\n2.商品兑换成功后，3日内发货，快递需要3-4天，偏远地区需要5-7天，请注意查收。";
        CGFloat titleHeight = [tempStr sizeOfTextWithMaxSize:Size(IPHONE_W, MAXFLOAT) font:[UIFont systemFontOfSize:RemindFont(12, 14, 16)]].height+30;
        
        CGFloat cellHeight = 20+5+25*AdaptiveScale_W+titleHeight;
        
        return cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identity = @"DetailListCell";
    DetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil)
    {
        cell = [[DetailListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    if (indexPath.row == 0)
    {
//        NSLog(@"222222%@",self.infoModels.d.desc_);

        if (self.infoModels.d.desc_.length != 0)
        {
            [cell setTheCellDataWithName:self.infoModels.d.desc_ andTitle:@"商品详情"];
        }
    }else
    {
        NSString *tempStr =@"1.除港澳台外，全国包邮;\n2.商品兑换成功后，3日内发货，快递需要3-4天，偏远地区需要5-7天，请注意查收。";
        [cell setTheCellDataWithName:tempStr andTitle:@"商品配送"];
    }
    return cell;
}
#pragma mark get
-(UIButton *)changeBtn
{
    if (_changeBtn == nil)
    {
        _changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
        _changeBtn.backgroundColor = MainRedColor;
        [_changeBtn setTitle:@"兑换" forState:0];
        [_changeBtn setTitleColor:WhiteColor forState:0];
        [_changeBtn addTarget:self action:@selector(changeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}


-(DetailHeadView *)headView
{
    if (_headView == nil)
    {
        _headView = [[DetailHeadView alloc]initWithFrame:Frame(0, ALL_NAVIGATION_HEIGHT, IPHONE_W-13*2*AdaptiveScale_W, 430*AdaptiveScale_W)];
    }
    return _headView;
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
