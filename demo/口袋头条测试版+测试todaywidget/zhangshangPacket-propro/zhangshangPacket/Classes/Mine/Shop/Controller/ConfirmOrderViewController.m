//
//  ConfirmOrderViewController.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/1.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ConfirmHeadView.h"
#import "ConfirmListCell.h"
#import "ShoppingViewController.h"

#import "AddressModel.h"
#import "DeleteAddressModel.h"

#import "SaveAddressViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "ConfirmModel.h"
#import "UIImage+CH.h"


#import "ShoppingViewController.h"
//#import "DepositViewController.h"

@interface ConfirmOrderViewController ()
<
DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource
>
@property (nonatomic, strong) ConfirmHeadView *headView;
@property (nonatomic, strong) UIButton *addAddressBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, assign) NSInteger tempNumber;
@property (nonatomic, assign) NSInteger allNumber;
@property(nonatomic,strong) NSString *CelectNum;

@end

@implementation ConfirmOrderViewController

//-(void)viewWillAppear:(BOOL)animated{
//    [self askForData];
//}

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
    [super viewWillAppear:animated];

    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.barTintColor = MainRedColor;
    [self askForData];
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"订单确认";
    label.font = [UIFont systemFontOfSize:18];
    
    self.navigationItem.titleView = label;
    
    
    
}


#pragma mark addTheView
-(void)addTheView
{
    
    //self.title = @"订单确认";
    self.tempNumber = 1;
    self.allNumber = [self.dataModels.cash intValue];
   
    self.headView.maxNumber = [self.dataModels.num integerValue];
     NSString *urlstr = [NSString stringWithFormat:@"%@%@",STUserDefaults.imgurlpre,self.dataModels.img];
    [self.headView.photoImageView  sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:MyImage(@"login_default")];
    self.headView.titleLab.text = self.dataModels.name;
    self.headView.integralLab.text = [NSString stringWithFormat:@"价格:%.2f元",[self.dataModels.cash floatValue ]/100.0];
    self.headView.allIntegralLab.text = [NSString stringWithFormat:@"%.2f元",[self.dataModels.cash floatValue ]/100.0];
    [self.headView.allIntegralLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.headView.allIntegralLab.text widthWithfont:self.headView.allIntegralLab.font]);
    }];
    self.headView.balanceLab.text = [NSString stringWithFormat:@"当前余额:%@元",STUserDefaults.cash];
    
    self.tableView.backgroundColor = MainBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-47*AdaptiveScale_W);
    }];
    [self.view addSubview:self.addAddressBtn];
    [self.addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(47*AdaptiveScale_W);
        make.width.mas_equalTo(IPHONE_W/2-1);
    }];
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(47*AdaptiveScale_W);
        make.width.mas_equalTo(IPHONE_W/2-1);
        make.left.mas_equalTo(self.addAddressBtn.mas_right).offset(2);
    }];
}
-(void)askForData
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [STRequest AddressListWithDataBlock:^(id ServersData, BOOL isSuccess) {

        AddressModel *dataModelss = [AddressModel mj_objectWithKeyValues:ServersData];
        if (isSuccess)
        {
            if (dataModelss.c == 1)
            {
                [self.infoArr removeAllObjects];
                for (AddressList *tempModel in dataModelss.d.reapAddress)
                {

                    [self.infoArr addObject:tempModel];
                }
                [self.tableView reloadData];
                [SVProgressHUD dismiss];
            }else
            {
                [SVProgressHUD showErrorWithStatus:dataModelss.m];
            }
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"网络故障，请重试"];
        }
    }];
}
#pragma mark btnAction
-(void)reloadData
{
    [self askForData];
}

-(void)delayToPay
{
//    DepositViewController *depositVC  = [DepositViewController new];
//    [self.navigationController pushViewController:depositVC animated:YES];
    NSLog(@"充值");
    
}
-(void)confirmBtnAction
{
    if ((int)STUserDefaults.cash<self.allNumber)
    {
        [SVProgressHUD showErrorWithStatus:@"您的余额不足"];
       // [self performSelector:@selector(delayToPay) withObject:nil afterDelay:0.5];
        return;
    }
    if (self.infoArr.count == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"还没有添加地址，请添加地址!"];
        return;
    }
    
    
    AddressList *dataModel;
    for (AddressList *tempModel in self.infoArr)
    {
        if (tempModel.isSlected == YES)
        {
            dataModel = tempModel;
        }
    }
    if (dataModel == nil ||dataModel.isSlected != YES )
    {
        [SVProgressHUD showErrorWithStatus:@"没有选中地址"];
        return;
    }
    
  
    NSDictionary *params = @{@"goodsid":self.dataModels.id,
                             @"reapid":dataModel.reapid,
                             @"nums":@(self.tempNumber)};
    
    [STRequest ConfirmOrderWithParam:params andDataBlock:^(id ServersData, BOOL isSuccess) {
        ConfirmModel *dataModel = [ConfirmModel mj_objectWithKeyValues:ServersData];
        if (isSuccess)
        {
            if (dataModel.c == 1)
            {
                [SVProgressHUD showSuccessWithStatus:@"兑换成功"];
                
                STUserDefaults.cash = [NSString stringWithFormat:@"%d",[dataModel.d.cash intValue] + [STUserDefaults.cash intValue]];
                
                JLLog(@"%ld",(long)STUserDefaults.cash);
                self.headView.balanceLab.text = [NSString stringWithFormat:@"当前余额:%@元",STUserDefaults.cash];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadscore" object:nil];
//                NSArray *arr = [self.navigationController viewControllers];
//                for (UIViewController *vc in arr)
//                {
//                    if ([vc isKindOfClass:[ShoppingViewController class]])
//                    {
//                        [self.navigationController popToViewController:vc animated:YES];
//                        break;
//                    }
//                }
                [self performSelector:@selector(delayBack) withObject:nil afterDelay:1.0f];

            }else
            {
                [SVProgressHUD showErrorWithStatus:dataModel.m];
            }
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"网络故障，请稍后重试"];
        }
    }];
    
}
-(void)delayBack
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadGoodsList" object:nil];
    ShoppingViewController *shopVC = [[ShoppingViewController alloc]init];
    [self.navigationController popToViewController:shopVC animated:YES];

//    [XWCommonFunction backFromController:self toController:[ShoppingViewController class]];

}
-(void)addAddressBtnAction
{
    if (self.infoArr.count <3) {
        SaveAddressViewController *saveVC = [SaveAddressViewController new];
        [self.navigationController pushViewController:saveVC animated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"地址数已经满了"];
    }

}
#pragma mark Empty_Data
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attribs = @{NSFontAttributeName: [UIFont systemFontOfSize:RemindFont(13, 15, 17)],
                              NSForegroundColorAttributeName:[UIColor redColor]};
    NSMutableAttributedString *attributedText =[[NSMutableAttributedString alloc] initWithString:@"还没添加地址，快去添加吧！"attributes:attribs];
    return attributedText;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120*AdaptiveScale_W;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identity = @"ConfirmListCell";
    ConfirmListCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil)
    {
        cell = [[ConfirmListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    
    if (self.infoArr[indexPath.row] != nil)
    {
        
        AddressList * dataModel = self.infoArr[indexPath.row];
        NSMutableDictionary *modeldic = [[NSMutableDictionary alloc]init];
        modeldic = [dataModel mj_keyValues].mutableCopy;
        cell.dataModel = dataModel;
   
//        [modeldic setObject:[NSNumber numberWithBool:isSlected] forKey:@"isSlected"];
//  
//        cell.dataModel = modeldic;
//        cell.isSelect = isSlected;
        WeakType(self);
        cell.DeLeteBlock = ^(){
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"是否删除当前地址" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakself deleteAddressWithID:modeldic[@"reapid"] andRow:indexPath.row];
            }]];
            
            [weakself presentViewController:alertVC animated:YES completion:nil];
        };
        WeakType(cell);
        cell.SelectedBlock = ^(AddressList *tempModel){
            for (AddressList *compareModel in self.infoArr)
            {
                if (compareModel.reapid == tempModel.reapid)
                {
                    compareModel.isSlected = YES;
                }else
                {
                    compareModel.isSlected = NO;
                }
            }
            [weakself.tableView reloadData];
        };

    }
    
    
    
    return cell;
}
-(void)deleteAddressWithID:(NSString *)addressID andRow:(NSInteger )row
{
    [STRequest DeleteAddressWithID:addressID andDataBlock:^(id ServersData, BOOL isSuccess) {
        DeleteAddressModel *dataModel = [DeleteAddressModel mj_objectWithKeyValues:ServersData];
        if (isSuccess)
        {
            if (dataModel.c == 1)
            {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [self.infoArr removeObjectAtIndex:row];
                [self.tableView reloadData];
                
            }else
            {
                [SVProgressHUD showErrorWithStatus:dataModel.m];
            }
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"网络故障，请重试"];
        }
    }];
}

#pragma mark get
-(ConfirmHeadView *)headView
{
    if (_headView == nil)
    {
        _headView = [[ConfirmHeadView alloc]initWithFrame:Frame(0, ALL_NAVIGATION_HEIGHT, IPHONE_W, 195*AdaptiveScale_W)];
        _headView.backgroundColor = WhiteColor;
        WeakType(self);
        _headView.NumberChangeBlock = ^(NSString *tempNumber){
            int singleNumber = [weakself.dataModels.cash intValue];
            weakself.tempNumber = [tempNumber integerValue];
            weakself.allNumber = singleNumber * (int)weakself.tempNumber;
            weakself.headView.allIntegralLab.text = [NSString stringWithFormat:@"%ld",weakself.allNumber];
            [weakself.headView.allIntegralLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo([weakself.headView.allIntegralLab.text widthWithfont:weakself.headView.allIntegralLab.font]);
            }];
        };
        
    }
    return _headView;
}
-(UIButton *)addAddressBtn
{
    if (_addAddressBtn == nil)
    {
        _addAddressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _addAddressBtn.backgroundColor = [UIColor colorWithRed:0.98 green:0.73 blue:0.17 alpha:1.00];
        _addAddressBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
        [_addAddressBtn setTitle:@"添加地址" forState:0];
        [_addAddressBtn setTitleColor:WhiteColor forState:0];
        [_addAddressBtn addTarget:self action:@selector(addAddressBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;
}
-(UIButton *)confirmBtn
{
    if (_confirmBtn == nil)
    {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmBtn.backgroundColor = MainRedColor;
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
        [_confirmBtn setTitle:@"确认订单" forState:0];
        [_confirmBtn setTitleColor:WhiteColor forState:0];
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
-(NSMutableArray *)infoArr
{
    if (_infoArr == nil)
    {
        _infoArr = [NSMutableArray new];
    }
    return _infoArr;
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
