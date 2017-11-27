//
//  PayHistoryViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-17.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "PayHistoryViewController.h"
#import "MySystemCell.h"
@interface PayHistoryViewController ()

@end

@implementation PayHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backPrePage{
    if (headerView) {
        [headerView free];
    }
    if (footerView) {
        [footerView free];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([_type isEqualToString:@"all"]) {
        self.titleLabel.text = @"还款历史明细";
    }else if ([_type isEqualToString:@"singel"]) {
        self.titleLabel.text = @"还款明细";
    }

    dataArray = [[NSMutableArray alloc] init];
    currentPage = 1;
    currentCount = 0;

    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_TAB_BAR_HEIGHT)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:myTableView];

    if (![_type isEqualToString:@"singel"]) {
        headerView = [[MJRefreshHeaderView alloc] initWithScrollView:myTableView];
        headerView.delegate = self;

        footerView = [[MJRefreshFooterView alloc] initWithScrollView:myTableView];
        footerView.delegate = self;
    }

    [self getData];
}

- (void)getDataWithDic:(NSDictionary *)dic api:(NSString *)api{
    ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:api];

    __weak ASIHTTPRequest * mrequest = request;

    [request setCompletionBlock:^{

        [XDTools hideProgress:self.contentView];

        if (![_type isEqualToString:@"singel"]) {
            [headerView endRefreshing];
            [footerView endRefreshingWithoutIdle];
        }

        NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

//        if (![_type isEqualToString:@"singel"]) {
//            tempDic = @{
//                        @"result" : @"0", //返回码
//                        @"msg" : @"" ,//返回信息
//                        @"data" : @{
//                                @"list":@[@{
//                                              @"uid":@"23",
//                                              @"userName":@"15101121091",
//                                              @"billDate":@"2014-10-5",//账单日
//                                              @"billAmount":@"1000",//账单金额
//                                              @"overdueFine":@"20",//滞纳金
//                                              @"payedAmount":@"230",//已归还金额
//                                              @"billId":@"201410",//账期
//                                              @"repayDate":@"2014-10-20",//到期还款日
//                                              @"repayStat":@"0",//还款状态：0，未还；1，部分；2，还清
//                                              @"overdueStat": @"1",//逾期状态：0，未逾期；1，逾期
//                                              },
//                                          @{
//                                              @"uid":@"23",
//                                              @"userName":@"15101121091",
//                                              @"billDate":@"2014-10-5",//账单日
//                                              @"billAmount":@"1",//账单金额
//                                              @"overdueFine":@"0",//滞纳金
//                                              @"payedAmount":@"1",//已归还金额
//                                              @"billId":@"201410",//账期
//                                              @"repayDate":@"2014-10-20",//到期还款日
//                                              @"repayStat":@"2",//还款状态：0，未还；1，部分；2，还清
//                                              @"overdueStat": @"0",//逾期状态：0，未逾期；1，逾期
//                                              }],
//                                @"count":@"2"
//                                }
//                        };
//        }


        if ([[tempDic objectForKey:@"result"] intValue] == 0) {
            
                if (currentPage == 1) {
                    dataArray = [NSMutableArray arrayWithArray:tempDic[@"data"][@"list"]];
                }else
                    [dataArray addObjectsFromArray:[NSMutableArray arrayWithArray:tempDic[@"data"][@"list"]]];
                
                [myTableView reloadData];
                
                currentCount = dataArray.count;
                if (currentCount == [tempDic[@"data"][@"count"] intValue]) {
                    currentCount = -1;
                }
            



        }else{
            [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];
        }
    }];

    [request setFailedBlock:^{
        if (![_type isEqualToString:@"singel"]) {
            [headerView endRefreshing];
            [footerView endRefreshingWithoutIdle];
        }
        [XDTools hideProgress:self.contentView];
        NSError *error = [mrequest error];
        DDLOG_CURRENT_METHOD;
        DDLOG(@"error=%@",error);
        if (mrequest.error.code == 2) {
            [XDTools showTips:@"网络请求超时" toView:self.view];
        }
    }];
    if (!notFirst) {
        [XDTools showProgress:self.contentView];
        notFirst = YES;
    }

    [request startAsynchronous];
}

- (void)getData{
    if ([XDTools NetworkReachable]){

        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

        NSDictionary * dic;

        if ([_type isEqualToString:@"singel"]) {
            dic = @{@"uid": infoDic[@"uid"],
                    @"token":infoDic[@"token"],
                    @"userName":infoDic[@"userName"],
                    @"orderId":_orderId};

            [self getDataWithDic:dic api:API_ORDERBILL];

        }else{
            dic = @{@"uid": infoDic[@"uid"],
                    @"token":infoDic[@"token"],
                    @"userName":infoDic[@"userName"],
                    @"pn":[NSString stringWithFormat:@"%d",currentPage],
                    @"rn":@"10"};

            [self getDataWithDic:dic api:API_BILLMONTH];

        }

    }
    else
    {
        [XDTools showTips:brokenNetwork toView:self.view];
    }
    
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = dataArray[indexPath.row];
    if ([_type isEqualToString:@"singel"]) {
        if ([dic[@"overdueDayCount"] intValue]) {
            return 65;
        }else{
            return 40;
        }
    }else{
        if ([dic[@"overdueStat"] intValue]) {
            return 65;
        }else{
            return 40;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIde0 = @"cell0";
    MySystemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde0];
    if (cell == nil) {
        cell = [[MySystemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor clearColor];
        cell.bottomLine.hidden = NO;
        cell.firstLB.font = [UIFont systemFontOfSize:14];
        cell.secondLB.font = [UIFont systemFontOfSize:14];

        UILabel * thirdLB = [XDTools addAlabelForAView:cell.contentView withText:@"" frame:CGRectMake(170, 10, 140, 20) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x626262)];
        thirdLB.tag = 626714;
    }

    if (!indexPath.row) {
        cell.topLine.hidden = NO;
    }else{
        cell.topLine.hidden = YES;
    }

    NSDictionary * dic = dataArray[indexPath.row];

    if ([_type isEqualToString:@"singel"]) {
        cell.firstLB.frame = CGRectMake(10, 10, 150, 20);
        NSString * status = @"";
        if ([dic[@"status"] intValue] != 2) {
            status = @"未还";
        }else{
            status = @"已还";
        }
        if ([dic[@"periodNum"] length] == 1) {
            cell.firstLB.text = [NSString stringWithFormat:@"第%@期        %.2f元",dic[@"periodNum"],[dic[@"billAmount"] floatValue]/100];
        }else if ([dic[@"periodNum"] length] == 2) {
            cell.firstLB.text = [NSString stringWithFormat:@"第%@期      %.2f元",dic[@"periodNum"],[dic[@"billAmount"] floatValue]/100];
        }
        UILabel * thirdLB = (UILabel *)[cell.contentView viewWithTag:626714];
        NSMutableString * time = [NSMutableString stringWithFormat:@"%@",dic[@"billDate"]];
        [time insertString:@"-" atIndex:4];
        [time insertString:@"-" atIndex:7];
        thirdLB.text = [NSString stringWithFormat:@"%@        %@",status,time];
        thirdLB.attributedText = [XDTools getAcolorfulStringWithText1:@"已还" Color1:UIColorFromRGB(0x46af6a) Font1:[UIFont systemFontOfSize:14] Text2:nil Color2:nil Font2:nil AllText:thirdLB.text];

        if ([dic[@"overdueDayCount"] intValue]) {
            cell.secondLB.hidden = NO;
            cell.secondLB.frame = CGRectMake(10, 35, UI_SCREEN_WIDTH-20, 20);
            cell.secondLB.textAlignment = NSTextAlignmentCenter;
            cell.secondLB.text = [NSString stringWithFormat:@"逾期%@天，滞纳金%.2f元",dic[@"overdueDayCount"],[dic[@"overdueFine"] floatValue]/100];
            cell.bottomLine.frame = CGRectMake(0, 64.5f, UI_SCREEN_WIDTH, .5f);
            cell.secondLB.textColor = UIColorFromRGB(0xc64047);
        }else{
            cell.secondLB.hidden = YES;

            cell.bottomLine.frame = CGRectMake(0, 39.5f, UI_SCREEN_WIDTH, .5f);
        }
    }else{
        cell.firstLB.frame = CGRectMake(10, 10, UI_SCREEN_WIDTH-20, 20);
        NSString * status = @"";
        if ([dic[@"repayStat"] intValue] != 2) {
            status = @"未还";
        }else{
            status = @"已还";
        }

        NSString * time = dic[@"billDate"];
        NSMutableString * month = [NSMutableString stringWithFormat:@"%@",[time substringWithRange:NSMakeRange(4,2)]];
        if ([month hasPrefix:@"0"]) {
            [month deleteCharactersInRange:NSMakeRange(0, 1)];
        }


        NSString * mainMoney = [NSString stringWithFormat:@"%.2f",[dic[@"billAmount"] floatValue]/100 + [dic[@"overdueFine"] floatValue]/100];
        if (month.length == 1) {
            cell.firstLB.text = [NSString stringWithFormat:@"%@月账单       %@元",month,mainMoney];
        }else if (month.length == 2) {
            cell.firstLB.text = [NSString stringWithFormat:@"%@月账单     %@元",month,mainMoney];
        }

        UILabel * thirdLB = (UILabel *)[cell.contentView viewWithTag:626714];
        NSMutableString * time1 = [NSMutableString stringWithFormat:@"%@",dic[@"repayDate"]];
        [time1 insertString:@"-" atIndex:4];
        [time1 insertString:@"-" atIndex:7];
        thirdLB.text = [NSString stringWithFormat:@"%@        %@",status,time1];
        thirdLB.attributedText = [XDTools getAcolorfulStringWithText1:@"已还" Color1:UIColorFromRGB(0x46af6a) Font1:[UIFont systemFontOfSize:14] Text2:nil Color2:nil Font2:nil AllText:thirdLB.text];


        if ([dic[@"overdueStat"] intValue]) {
            cell.secondLB.hidden = NO;
            cell.secondLB.frame = CGRectMake(10, 35, UI_SCREEN_WIDTH-20, 20);
            cell.secondLB.textAlignment = NSTextAlignmentCenter;
            cell.secondLB.text = [NSString stringWithFormat:@"已逾期，滞纳金%.2f元",[dic[@"overdueFine"] floatValue]/100];
            cell.bottomLine.frame = CGRectMake(0, 64.5f, UI_SCREEN_WIDTH, .5f);
            cell.secondLB.textColor = UIColorFromRGB(0xc64047);
        }else{
            cell.secondLB.hidden = YES;

            cell.bottomLine.frame = CGRectMake(0, 39.5f, UI_SCREEN_WIDTH, .5f);
        }
    }
//    "periodNum":4,//当前是第几期账单
//    "billDate":"2014-10-5",//账单日期
//    "billAmount":460,//账单金额
//    "overdueDayCount":3,//逾期天数
//    "overdueFine":20,//滞纳金
//    "status":1,//0：未还，1：还了部分款项，2：已还
//    "payedAmount":230,//已归还金额



    return cell;
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
    [self getData];
}


- (void)getNextData{
    if (currentCount < 0)
    {
        [headerView endRefreshing];
        [footerView endRefreshingWithoutIdle];
        [XDTools showTips:@"没有更多数据" toView:self.view];
        [self yoffset:dataArray andTableview:myTableView];
    }
    else
    {
        currentPage++;
        [self getData];
    }
}

- (void)yoffset:(NSMutableArray *)arr andTableview:(UITableView *)tableview
{
    //        if ([arr count]>10){
    CGFloat y = tableview.contentOffset.y;
    tableview.contentOffset = CGPointMake(0, y-60);
    //        }

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
