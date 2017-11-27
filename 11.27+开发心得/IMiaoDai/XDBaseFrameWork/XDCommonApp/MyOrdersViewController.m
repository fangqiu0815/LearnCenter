//
//  MyOrdersViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-11.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "OrderListCell.h"
@interface MyOrdersViewController ()

@end

@implementation MyOrdersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backPrePage{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [XDTools setPushInfoType:@"4" andValue:@"0"];
    [XDTools setPushInfoType:@"3" andValue:@"0"];

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleLabel.text = @"我的订单";

    isFirst = YES;

    dataArray = [[NSMutableArray alloc] init];

    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:myTableView];

    headerView = [[MJRefreshHeaderView alloc] initWithScrollView:myTableView];
    headerView.delegate = self;

    footerView = [[MJRefreshFooterView alloc] initWithScrollView:myTableView];
    footerView.delegate = self;

    

    noGoodsView = [[UIView alloc] initWithFrame:myTableView.frame];
    noGoodsView.backgroundColor = [UIColor clearColor];
    noGoodsView.hidden = YES;
    [self.contentView addSubview:noGoodsView];

    UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake((640-405)/4, 80, 405/2.0f, 133)];
    iv.image = [UIImage imageNamed:@"nogoods"];
    [noGoodsView addSubview:iv];

    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(85, height_y(iv)+20, 150, 40) nomalTitle:@"看看商品" hlTitle:@"看看商品" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf28d01) nbgImage:nil hbgImage:nil action:@selector(gotoGoods) target:self buttonTpye:UIButtonTypeCustom];
    [noGoodsView addSubview:btn];

    [self getDataWithPageNum:@"1" api:API_GETORDERLIST];

}


- (void)getDataWithPageNum:(NSString *)page api:(NSString *)api{
    if ([XDTools NetworkReachable])
    {

        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

        NSDictionary * dic = @{@"uid": infoDic[@"uid"],
                               @"token": infoDic[@"token"],
                               @"userName": infoDic[@"userName"],
                               @"pn": page,
                               @"rn":@"10"};


        ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:api];

        __weak ASIHTTPRequest * mrequest = request;

        [request setCompletionBlock:^{

            [XDTools hideProgress:self.contentView];
            [headerView endRefreshing];
            [footerView endRefreshingWithoutIdle];

            NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

//            tempDic = @{
//                        @"result" : @"0",//0：返回正确，此时msg未空，1：出错了，此时msg未提示的错误信息
//                        @"msg" : @"",
//                        @"data" : @{
//                                @"list":@[@{
//                                              @"orderId":@"223435345",
//                                              @"productId" : @"23",
//                                              @"productName" : @"xxxxxx",
//                                              @"pic" : @"http://xxxxx.jpg",
//                                              @"price" : @"2000",//售价
//                                              @"marketPrice":@"2500",//市场价
//                                              @"tag":@"白色/联通/4G",
//                                              @"payment" : @{
//                                                      @"paymentId":@"6",
//                                                      @"titel":@"6个月",
//                                                      @"shoufu":@"0",//首付款
//                                                      @"yuefu":@"370",//月供金额
//                                                      },
//                                              @"status":@"7",//0：1：订单提交，2：审核中，3:审核未通过，4:商家已发货、5：商品已签收、6：拒收
//                                              @"remark":@"失败原因",
//                                              @"createTime":@"20140819152020"
//                                              },@{@"orderId":@"223435345",
//                                                  @"productId" : @"23",
//                                                  @"productName" : @"xxxxxx",
//                                                  @"pic" : @"http://xxxxx.jpg",
//                                                  @"price" : @"2000",//售价
//                                                  @"marketPrice":@"2500",//市场价
//                                                  @"tag":@"白色/联通/4G",
//                                                  @"payment" : @{
//                                                          @"paymentId":@"6",
//                                                          @"titel":@"6个月",
//                                                          @"shoufu":@"0",//首付款
//                                                          @"yuefu":@"370",//月供金额
//                                                          },
//                                                  @"status":@"B",//0：1：订单提交，2：审核中，3:审核未通过，4:商家已发货、5：商品已签收、6：拒收
//                                                  @"remark":@"失败原因",
//                                                  @"createTime":@"20140819152020"
//                                                  }],
//                                @"count":@"23"//订单总数
//                                }
//                        };


            if ([[tempDic objectForKey:@"result"] intValue] == 0)
            {

                if (page.intValue == 1) {
                    dataArray = [NSMutableArray arrayWithArray:tempDic[@"data"][@"list"]];
                    currentCount = dataArray.count;
                }else{
                    [dataArray addObjectsFromArray:tempDic[@"data"][@"list"]];
                    currentCount = dataArray.count;
                }

                if (currentCount == [tempDic[@"data"][@"count"] intValue]) {
                    currentCount = -1;
                }
                if (!dataArray.count) {
                    noGoodsView.hidden = NO;
                }else
                [myTableView reloadData];
            }
            else
            {
                [XDTools hideProgress:self.contentView];
                [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];

            }
        }];

        [request setFailedBlock:^{
            [headerView endRefreshing];
            [footerView endRefreshingWithoutIdle];
            [XDTools hideProgress:self.contentView];
            NSError *error = [mrequest error];
            DDLOG_CURRENT_METHOD;
            DDLOG(@"error=%@",error);
            if (mrequest.error.code == 2) {
                [XDTools showTips:@"网络请求超时" toView:self.view];
            }
        }];
        if (isFirst) {
            [XDTools showProgress:self.contentView];
            isFirst = NO;
        }
        [request startAsynchronous];

    }
    else
    {
        [XDTools showTips:brokenNetwork toView:self.view];
        [headerView endRefreshing];
        [footerView endRefreshingWithoutIdle];
    }

}

//"list":[{
//    "orderId","223435345",
//    "productId" : 23,
//    "productName" : "xxxxxx",
//    "pic" : "http://xxxxx.jpg",
//    "price" : 2000,//售价
//    "marketPrice":2500,//市场价
//    "tag":"白色/联通/4G",
//    "payment" : {
//        "paymentId",6
//        "titel":"6个月",
//        "shoufu":0,//首付款
//        "yuefu":370,//月供金额
//    },
//    "status":0,//0：1：订单提交，2：审核中，3:审核未通过，4:商家已发货、5：商品已签收、6：拒收
//    “remark”:”失败原因”
//    "createTime":"2014-8-19 15:20:20"
//}],

- (void)gotoGoods{
    XDTabBarViewController * tabBar = self.navigationController.viewControllers.firstObject;
    [tabBar confirmSelectTabBar:0];
    [tabBar setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([dataArray[indexPath.row][@"status"] intValue] == 7) {
        return 245;
    }
    return 205;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIde = @"cell";
    OrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderListCell" owner:self options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.checkGoodsBtn addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
        cell.checkGoodsBtn.hidden = YES;
    }
    DDLOG(@"%d",indexPath.row);

    cell.checkGoodsBtn.tag = 777700+indexPath.row;

    NSDictionary * dic = dataArray[indexPath.row];
    [cell getDataWithDict:dic];

    return cell;

}


- (void)showAlert:(UIButton *)sender{

    NSString * status = dataArray[sender.tag - 777700][@"status"];

    if ([status isEqualToString:@"B"] || [status isEqualToString:@"D"]) {
        alertMessage = @"确认要签收订单吗？";
    }else if ([status isEqualToString:@"0"] || [status isEqualToString:@"6"] || [status isEqualToString:@"2"] || [status isEqualToString:@"3"]) {
        alertMessage = @"确认要取消订单吗？";
    }
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:alertMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = sender.tag + 111100;
    [alert show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self checkGoodsAndOrders:alertView.tag];
    }
}



- (void)checkGoodsAndOrders:(int)sender{

    if ([XDTools NetworkReachable])
    {
        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

        NSString * orderId = dataArray[sender - 888800][@"orderId"];
        NSString * status = dataArray[sender - 888800][@"status"];
        NSString * api = @"";

        if ([status isEqualToString:@"B"] || [status isEqualToString:@"D"]) {
            api = API_ORDERSIGN;
        }else if ([status isEqualToString:@"0"] || [status isEqualToString:@"6"] || [status isEqualToString:@"2"] || [status isEqualToString:@"3"]) {
            api = API_CANCLEORDER;
        }

        NSDictionary * dic = @{@"uid": infoDic[@"uid"],
                               @"token":infoDic[@"token"],
                               @"userName":infoDic[@"userName"],
                               @"orderId":orderId};

        ASIHTTPRequest * request = [XDTools postRequestWithDict:dic API:api];


        __weak ASIHTTPRequest * mrequest = request;

        [request setCompletionBlock:^{

            [XDTools hideProgress:self.contentView];

            NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

            if ([[tempDic objectForKey:@"result"] intValue] == 0)
            {
                [self getDataWithPageNum:@"1" api:API_GETORDERLIST];

            }
            else
            {
                [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];

            }
        }];

        [request setFailedBlock:^{
            
            [XDTools hideProgress:self.contentView];
            NSError *error = [mrequest error];
            DDLOG_CURRENT_METHOD;
            DDLOG(@"error=%@",error);
            if (mrequest.error.code == 2) {
                [XDTools showTips:@"网络请求超时" toView:self.view];
            }
        }];
        if (isFirst) {
            [XDTools showProgress:self.contentView];
            isFirst = NO;
        }
        [request startAsynchronous];
        [XDTools showProgress:self.contentView];
        
    }
    else
    {
        [XDTools showTips:brokenNetwork toView:self.view];
        
    }
    
}

#pragma mark - MJRefreshView Delegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if (refreshView == headerView) {
        [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(getNewData) userInfo:nil repeats:NO];
    }else if (refreshView == footerView) {
        [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(getNextData) userInfo:nil repeats:NO];
    }
}

- (void)getNewData{
    currentPage = 1;
    [self getDataWithPageNum:@"1" api:API_GETORDERLIST];
}


- (void)getNextData{
    if (currentCount < 0)
    {
        [headerView endRefreshing];
        [footerView endRefreshingWithoutIdle];
        [XDTools showTips:@"喵~没有更多订单啦" toView:self.view];
        [self yoffset:dataArray andTableview:myTableView];
    }
    else
    {
        currentPage++;
        [self getDataWithPageNum:[NSString stringWithFormat:@"%d",currentPage] api:API_GETORDERLIST];
    }
}

- (void)yoffset:(NSMutableArray *)arr andTableview:(UITableView *)tableview
{
    //        if ([arr count]>10){
    CGFloat y = tableview.contentOffset.y;
    tableview.contentOffset = CGPointMake(0, y-60);
    //        }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [headerView free];
    [footerView free];
    [super viewWillDisappear:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
