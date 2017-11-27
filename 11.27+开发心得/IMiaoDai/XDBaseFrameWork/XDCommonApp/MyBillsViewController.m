//
//  MyBillsViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-11.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "MyBillsViewController.h"
#import "UIImageView+WebCache.h"
#import "MySystemCell.h"
#import "SingelBillViewController.h"
#import "PayingViewController.h"
#import "PayHistoryViewController.h"
@interface MyBillsViewController ()

@end

@implementation MyBillsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [XDTools setPushInfoType:@"1" andValue:@"0"];
    [XDTools setPushInfoType:@"2" andValue:@"0"];
    [self getData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleLabel.text = @"我的账单";
    

    dataDic = [[NSMutableDictionary alloc] init];//WithDictionary:@{
//                                                                 @"billDate":@"2014-8-10",//账单日期
//                                                                 @"billAmount":@"460",//账单金额
//                                                                 @"overdueFine":@"20",//滞纳金
//                                                                 @"payedAmount":@"230",//已归还金额
//                                                                 @"surplusDays":@"10",//剩余多少天
//                                                                 @"orderList":@[
//                                                                         @{@"orderId":@"223435345",
//                                                                           @"productName" : @"taobaotaobaotaobaotaobaotaobaotaobaotaobaotaobaotaobaotaobaotaobaotaobaotaobaotaobao小广告",
//                                                                           @"productPic":@"http://gtms01.alicdn.com/tps/i1/TB1T.b0FVXXXXaAXVXXXK5zTVXX-520-280.png",
//                                                                           @"isOverdue":@"1",//1:逾期，0：不逾期
//                                                                           @"overdueDayCount":@"3",//逾期天数
//                                                                           @"overdueFine":@"20",//滞纳金
//                                                                           @"payedAmount":@"230",//已归还金额
//                                                                           @"periodNum":@"4",//当前是第几期账单
//                                                                           @"payment" : @{
//                                                                                   @"paymentId":@"6",
//                                                                                   @"titel":@"6个月",//分期数
//                                                                                   @"shoufu":@"0",//首付款
//                                                                                   @"yuefu":@"370"//月供金额
//                                                                                   }
//                                                                           }
//                                                                         ]
//                                                                 }];

    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.hidden = YES;
    [self.contentView addSubview:myTableView];


    noGoodsView = [[UIView alloc] initWithFrame:myTableView.frame];
    noGoodsView.backgroundColor = BGCOLOR;
    noGoodsView.hidden = YES;
    [self.contentView addSubview:noGoodsView];

    UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake((640-384)/4, 80, 384/2.0f, 93)];
    iv.image = [UIImage imageNamed:@"noBills"];
    [noGoodsView addSubview:iv];

    UILabel * lb = [XDTools addAlabelForAView:noGoodsView withText:@"还没有账单哦，去看看商品吧" frame:CGRectMake(0, height_y(iv), UI_SCREEN_WIDTH, 20) font:[UIFont systemFontOfSize:16] textColor:RGBA(102, 102, 102, 1)];
    lb.textAlignment = NSTextAlignmentCenter;
    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(85, height_y(lb)+20, 150, 40) nomalTitle:@"看看商品" hlTitle:@"看看商品" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf28d01) nbgImage:nil hbgImage:nil action:@selector(gotoGoods) target:self buttonTpye:UIButtonTypeCustom];
    [noGoodsView addSubview:btn];

}

- (void)gotoGoods{
    XDTabBarViewController * tabBar = self.navigationController.viewControllers.firstObject;
    [tabBar confirmSelectTabBar:0];
    [tabBar setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)getData{
    if ([XDTools NetworkReachable]){

        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

        NSDictionary * dic = @{@"uid": infoDic[@"uid"],
                               @"token":infoDic[@"token"],
                               @"userName":infoDic[@"userName"]};

        ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:API_USERBILLS];

        __weak ASIHTTPRequest * mrequest = request;

        [request setCompletionBlock:^{

            [XDTools hideProgress:self.contentView];

            NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

//            tempDic = @{
//                        @"result" : @"0", //返回码
//                        @"msg" : @"" ,//返回信息
//                        @"data" : @{
//                            @"uid":@"23",
//                            @"userName":@"15101121091",
//                            @"billDate":@"20141005",//账单日
//                            @"billAmount":@"460",//账单金额
//                            @"overdueFine":@"20",//滞纳金
//                            @"payedAmount":@"230",//已归还金额
//                            @"billId":@"201410",//账期
//                            @"repayDate":@"20141020",//到期还款日
//                            @"repayStat":@"0",//还款状态：0，未还；1，部分；2，还清
//                            @"overdueStat": @"1",//逾期状态：0，未逾期；1，逾期
//                            @"surplusDays": @"5",//距离还款日的天数，当逾期时，该值为空
//                            @"orderList":@[@{
//                                @"orderId":@"223435345",
//                                @"productName" : @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
//                                @"shouFu": @"0",       //首付
//                                @"paymentNum":@"6",  //分期数
//                                @"yuefu":@"370",//月供金额
//                                @"overdueDayCount":@"3",//逾期天数
//                                @"overdueFine":@"20",//滞纳金
//                                @"payedAmount":@"230",//已归还金额
//                                @"periodNum":@"4",//当前是第几期账单
//                                @"repayDate":@"2014-10-20",//到期还款日
//                                @"repayStat":@"0"//还款状态：0，未还；1，部分；2，还清
//                            }]
//                        }
//                        };

            if ([[tempDic objectForKey:@"result"] intValue] == 0) {
                if ([tempDic[@"data"] isKindOfClass:[NSDictionary class]]) {
                    dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic[@"data"]];
                }
                if (dataDic.count) {
                    myTableView.hidden = NO;
                    [myTableView reloadData];
                }else{
                    noGoodsView.hidden = NO;
                }
            }else{
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

        [XDTools showProgress:self.contentView];
        [request startAsynchronous];
        
    }
    else
    {
        [XDTools showTips:brokenNetwork toView:self.view];
    }
    
}



#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.section || indexPath.section == 2) {
        return 40;
    }else if (indexPath.section == 1) {
        return 75;
    }else{
        return 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!section) {
        return 2;
    }else  if (section == 1) {
        return [dataDic[@"orderList"] count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 3) {
        NSString * cellIde1 = @"cell1";
        MySystemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde1];
        if (cell == nil) {
            cell = [[MySystemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        //    cell.textLabel.text = nil;
        //    cell.detailTextLabel.text = nil;
        //    cell.imageView.image = nil;
        cell.firstLB.font = [UIFont systemFontOfSize:14];
        cell.secondLB.font = [UIFont systemFontOfSize:13];

        if (dataDic.count) {

            NSString * time = dataDic[@"billDate"];
            NSMutableString * month = [NSMutableString stringWithFormat:@"%@",[time substringWithRange:NSMakeRange(4,2)]];
            if ([month hasPrefix:@"0"]) {
                [month deleteCharactersInRange:NSMakeRange(0, 1)];
            }
            myMonth = month;
            //[time componentsSeparatedByString:@"-"][1];

            if (!indexPath.row) {
                cell.topLine.hidden = NO;
            }else{
                cell.topLine.hidden = YES;
            }

            if (!indexPath.section) {
                cell.secondLB.hidden = NO;
                cell.headIV.hidden = YES;
                cell.bottomLine.frame = CGRectMake(0, 40-.5f, 320, .5f);

                [cell.firstLB setFrame:CGRectMake(10, 10, 280, 20)];
                [cell.secondLB setFrame:CGRectMake(250, 10, 150, 20)];
                cell.accessoryType = UITableViewCellAccessoryNone;
                if (!indexPath.row) {

                    if ([dataDic[@"overdueFine"] intValue] > 0) {
                        cell.firstLB.text = [NSString stringWithFormat:@"%@月账单：%.2f元+%.2f元滞纳金",month,[dataDic[@"billAmount"] floatValue]/100,[dataDic[@"overdueFine"] floatValue]/100];
                    }else{
                        cell.firstLB.text = [NSString stringWithFormat:@"%@月账单：%.2f元",month,[dataDic[@"billAmount"] floatValue]/100];
                    }
                    if (dataDic[@"billAmount"] && dataDic[@"overdueFine"]) {
                        cell.firstLB.attributedText = [XDTools getAcolorfulStringWithTextArray:@[[NSString stringWithFormat:@"%.2f",[dataDic[@"billAmount"] floatValue]/100],[NSString stringWithFormat:@"%.2f",[dataDic[@"overdueFine"] floatValue]/100]] Color:UIColorFromRGB(0xfb8f20) Font:[UIFont systemFontOfSize:15] AllText:cell.firstLB.text];
                    }

                    if ([dataDic[@"repayStat"] intValue] == 2) {
                        cell.secondLB.text = @"已还";
                        cell.secondLB.frame = CGRectMake(270, 7, 40, 26);
                        cell.secondLB.textColor = [UIColor whiteColor];
                        cell.secondLB.textAlignment = NSTextAlignmentCenter;
                        cell.secondLB.backgroundColor = UIColorFromRGB(0x00912f);
                        cell.secondLB.hidden = NO;
                    }else{
                        cell.secondLB.hidden = YES;
                    }

                }else if (indexPath.row == 1) {
//                    int needPayStr = [dataDic[@"billAmount"] intValue] + [dataDic[@"overdueFine"] intValue] - [dataDic[@"payedAmount"] intValue];
//                    cell.firstLB.text = [NSString stringWithFormat:@"%@月账单已还：%@元，还需还款%d元",month,dataDic[@"payedAmount"],needPayStr];
//                    cell.firstLB.attributedText = [XDTools getAcolorfulStringWithText1:dataDic[@"payedAmount"] Color1:UIColorFromRGB(0xfb8f20) Font1:[UIFont systemFontOfSize:15] Text2:[NSString stringWithFormat:@"%d",needPayStr]
//                                                                                Color2:UIColorFromRGB(0xd10000) Font2:[UIFont systemFontOfSize:16] AllText:cell.firstLB.text];
                    NSMutableString * time = [NSMutableString stringWithFormat:@"%@",dataDic[@"repayDate"]];
                    [time insertString:@"-" atIndex:4];
                    [time insertString:@"-" atIndex:7];
                    billDate = time;
                    cell.firstLB.text = [NSString stringWithFormat:@"%@月账单还款日：%@",month,time];
                    if ([dataDic[@"overdueStat"] intValue] == 1) {
                        cell.secondLB.text = @"逾期";
                        cell.secondLB.frame = CGRectMake(270, 7, 40, 26);
                        cell.secondLB.textColor = [UIColor whiteColor];
                        cell.secondLB.backgroundColor = UIColorFromRGB(0xc80000);
                        cell.secondLB.textAlignment = NSTextAlignmentCenter;
                    }else{
                        cell.secondLB.text = [NSString stringWithFormat:@"还有%@天",dataDic[@"surplusDays"]];
                        cell.secondLB.frame = CGRectMake(230, 7, 80, 26);
                        cell.secondLB.textColor = [UIColor grayColor];
                        cell.secondLB.backgroundColor = [UIColor clearColor];
                        cell.secondLB.attributedText = [XDTools getAcolorfulStringWithTextArray:@[dataDic[@"surplusDays"]] Color:UIColorFromRGB(0xfb8f20) Font:[UIFont systemFontOfSize:15] AllText:cell.secondLB.text];
                    }

                }else{


                }
            }else if (indexPath.section == 1) {
                cell.secondLB.hidden = NO;
                cell.headIV.hidden = NO;

                cell.bottomLine.frame = CGRectMake(0, 75-.5f, 320, .5f);
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.headIV.frame = CGRectMake(10, 10, 55, 55);
                [cell.firstLB setFrame:CGRectMake(75, 10, 200, 30)];

                NSDictionary * dic = dataDic[@"orderList"][indexPath.row];

                [cell.headIV setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:[UIImage imageNamed:@"headerPlaceholder"]];

//                cell.headIV.backgroundColor = [UIColor orangeColor];
                cell.firstLB.text = dic[@"productName"];
                [cell.firstLB sizeToFit];
                if (cell.firstLB.frame.size.height > 40) {
                    [cell.firstLB setFrame:CGRectMake(75, 10, 200, 40)];
                }
                [cell.secondLB setFrame:CGRectMake(75, 47, 200, 20)];

                float mainMoney = [dic[@"overdueFine"] floatValue]/100 + [dic[@"yuefu"] floatValue]/100;
                if ([dic[@"payedAmount"] floatValue]) {
                    cell.secondLB.text = [NSString stringWithFormat:@"%@月应还%.2f元，已还%.2f元",month,mainMoney,[dic[@"payedAmount"] floatValue]/100];
                    cell.secondLB.attributedText = [XDTools getAcolorfulStringWithTextArray:@[[NSString stringWithFormat:@"%.2f",mainMoney],dic[@"payedAmount"]] Color:UIColorFromRGB(0xfb8f20) Font:[UIFont systemFontOfSize:13] AllText:cell.secondLB.text];
                }else{
                    cell.secondLB.text = [NSString stringWithFormat:@"%@月应还%.2f元",month,mainMoney];
                    cell.secondLB.attributedText = [XDTools getAcolorfulStringWithTextArray:@[[NSString stringWithFormat:@"%.2f",mainMoney]] Color:UIColorFromRGB(0xfb8f20) Font:[UIFont systemFontOfSize:13] AllText:cell.secondLB.text];
                }
                
                
            }else if (indexPath.section == 2) {
                cell.headIV.hidden = YES;
                cell.bottomLine.frame = CGRectMake(0, 40-.5f, 320, .5f);
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.firstLB.frame = CGRectMake(10, 10, 200, 20);
                cell.firstLB.text = @"还款历史明细";
                cell.secondLB.hidden = YES;
                
            }



        }
        
        return cell;
    }else{

        NSString * cellIde2 = @"cell2";
        MySystemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde2];
        if (cell == nil) {
            cell = [[MySystemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(10, 0, 300, 40) nomalTitle:@"马上还款" hlTitle:@"马上还款" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf28d01) nbgImage:nil hbgImage:nil action:@selector(payNow) target:self buttonTpye:UIButtonTypeCustom];
            btn.tag = 1826831;
            [cell.contentView addSubview:btn];
        }

        //    cell.textLabel.text = nil;
        //    cell.detailTextLabel.text = nil;
        //    cell.imageView.image = nil;
        cell.firstLB.font = [UIFont systemFontOfSize:14];
        cell.secondLB.font = [UIFont systemFontOfSize:13];

        if (!indexPath.row) {
            cell.topLine.hidden = NO;
        }else{
            cell.topLine.hidden = YES;
        }

        cell.headIV.hidden = YES;
        cell.backgroundColor = [UIColor clearColor];
        cell.topLine.hidden = YES;
        cell.bottomLine.frame = CGRectMake(0, 80-.5f, 320, 0);
        cell.accessoryType = UITableViewCellAccessoryNone;

        UIButton * btn = (UIButton *)[cell.contentView viewWithTag:1826831];

        if (dataDic.count) {
            if ([dataDic[@"billAmount"] floatValue] + [dataDic[@"overdueFine"] floatValue] == 0 || [dataDic[@"repayStat"] intValue] == 2) {
                [btn setBackgroundColor:UIColorFromRGB(0xcbcbcb)];
                btn.userInteractionEnabled = NO;
            }
        }

        return cell;
    }

}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        NSDictionary * dic = dataDic[@"orderList"][indexPath.row];
        SingelBillViewController * bill = [[SingelBillViewController alloc] init];
        bill.picStr = dic[@"pic"];
        bill.titleStr = dic[@"productName"];
        bill.payNum = dic[@"paymentNum"];
        bill.leftDays = dataDic[@"surplusDays"];
        bill.orderId = dic[@"orderId"];
        bill.dataDic = dataDic[@"orderList"][indexPath.row];
        bill.myMonth = myMonth;
        bill.billDate = billDate;
        [self.navigationController pushViewController:bill animated:YES];
    }else if (indexPath.section == 2) {
        PayHistoryViewController * history = [[PayHistoryViewController alloc] init];
        history.type = @"all";
        [self.navigationController pushViewController:history animated:YES];
    }
}


- (void)payNow{
    [self getPayingUrl];
}

- (void)getPayingUrl{
    if (![XDTools NetworkReachable]) {
        [XDTools showTips:brokenNetwork toView:self.contentView];
        return;
    }

    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
    float payNum = [dataDic[@"billAmount"] floatValue] + [dataDic[@"overdueFine"] floatValue];
    int payNum2 = (int)payNum;
    NSDictionary * dic = @{@"uid": infoDic[@"uid"],
                           @"token":infoDic[@"token"],
                           @"userName":infoDic[@"userName"],
                           @"payAmt":[NSString stringWithFormat:@"%d",payNum2],
                           @"paymentId":@"ppwallet_bankpay_wap"};

    ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:API_PAY];

    __weak ASIHTTPRequest * mrequest = request;

    [request setCompletionBlock:^{

        [XDTools hideProgress:self.contentView];

        NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

        if ([[tempDic objectForKey:@"result"] intValue] == 0) {

            PayingViewController * paying = [[PayingViewController alloc] init];
            float cost1 = [dataDic[@"billAmount"] floatValue]/100 + [dataDic[@"overdueFine"] floatValue]/100;
            paying.cost = [NSString stringWithFormat:@"%.2f",cost1];
            paying.urlStr = tempDic[@"data"][@"payUrl"];
            paying.payOrderId = tempDic[@"data"][@"payOrderId"];
            [self.navigationController pushViewController:paying animated:YES];
        }else{
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
    
    [XDTools showProgress:self.contentView];
    [request startAsynchronous];

}

- (void)backPrePage
{
    if ([dataDic[@"payedAmount"] floatValue] < [dataDic[@"billAmount"] floatValue] + [dataDic[@"overdueFine"] floatValue]) {
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"" message:@"喵~还没还钱就走人吗？" delegate:self cancelButtonTitle:@"离开" otherButtonTitles:@"留下", nil];
        al.tag = 1321;
        [al show];
    }else
        [self.navigationController popViewControllerAnimated:YES];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1321){
        if (buttonIndex){

        }else{
            [self.navigationController popViewControllerAnimated:YES];

        }
    }
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
