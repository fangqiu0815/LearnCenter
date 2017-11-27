//
//  SingelBillViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-12.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "SingelBillViewController.h"
#import "MySystemCell.h"
#import "UIImageView+WebCache.h"
#import "PayHistoryViewController.h"
@interface SingelBillViewController ()

@end

@implementation SingelBillViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleLabel.text = @"我的账单";

//    dataArray = [[NSMutableArray alloc] init];
//                 WithArray:@[@{
//        @"periodNum":@"4",//当前是第几期账单
//        @"billDate":@"2014-10-5",//账单日期
//        @"billAmount":@"230",//账单金额
//        @"overdueDayCount":@"3",//逾期天数
//        @"overdueFine":@"20",//滞纳金
//        @"status":@"2",//0：未还，1：还了部分款项，2：已还
//        @"payedAmount":@"230",//已归还金额
//    }]];

    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:myTableView];


//    [self getData];
}

- (void)getData{
    if ([XDTools NetworkReachable]){

        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

        NSDictionary * dic = @{@"uid": infoDic[@"uid"],
                               @"token":infoDic[@"token"],
                               @"userName":infoDic[@"userName"],
                               @"orderId":@"2014081215324800000001"};

        ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:API_ORDERBILL];

        __weak ASIHTTPRequest * mrequest = request;

        [request setCompletionBlock:^{

            [XDTools hideProgress:self.contentView];

            NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

            if ([[tempDic objectForKey:@"result"] intValue] == 0) {
//                _dataArray = [NSMutableArray arrayWithArray:tempDic[@"data"]];
                [myTableView reloadData];
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
    return 3;
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
    if (!indexPath.section) {
        return 75;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            return 30;
        }
        return 40;
    }else{
        return 40;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        if ([_dataDic[@"overdueDayCount"] intValue]) {
            return 3;
        }else
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIde = @"cell";
    MySystemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (cell == nil) {
        cell = [[MySystemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    //    cell.textLabel.text = nil;
    //    cell.detailTextLabel.text = nil;
    //    cell.imageView.image = nil;
    NSDictionary * dic = [NSDictionary dictionaryWithDictionary:_dataDic];

    cell.firstLB.font = [UIFont systemFontOfSize:14];
    cell.secondLB.font = [UIFont systemFontOfSize:13];

    NSString * time = dic[@"billDate"];
    NSMutableString * month = [NSMutableString stringWithFormat:@"%@",[time substringWithRange:NSMakeRange(4,2)]];
    if ([month hasPrefix:@"0"]) {
        [month deleteCharactersInRange:NSMakeRange(0, 1)];
    }


    if (!indexPath.row) {
        cell.topLine.hidden = NO;
    }else{
        cell.topLine.hidden = YES;
    }

    if (!indexPath.section) {

        cell.bottomLine.frame = CGRectMake(0, 75-.5f, 320, .5f);
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.headIV.frame = CGRectMake(10, 10, 55, 55);
        [cell.firstLB setFrame:CGRectMake(75, 10, 200, 30)];

        [cell.headIV setImageWithURL:[NSURL URLWithString:_picStr] placeholderImage:[UIImage imageNamed:@"headerPlaceholder"]];

//        cell.headIV.backgroundColor = [UIColor orangeColor];
        cell.firstLB.text = _titleStr;
        [cell.firstLB sizeToFit];
        if (cell.firstLB.frame.size.height > 40) {
            [cell.firstLB setFrame:CGRectMake(75, 10, 200, 40)];
        }
        [cell.secondLB setFrame:CGRectMake(75, 47, 200, 20)];
        cell.secondLB.text = [NSString stringWithFormat:@"%.2f元X%@期",[dic[@"yuefu"] floatValue]/100,_payNum];
        cell.secondLB.attributedText = [XDTools getAcolorfulStringWithTextArray:@[[NSString stringWithFormat:@"%.2f",[dic[@"yuefu"] floatValue]/100]] Color:UIColorFromRGB(0xfb8f20) Font:[UIFont systemFontOfSize:13] AllText:cell.secondLB.text];

    }else if (indexPath.section == 1) {

        cell.bottomLine.frame = CGRectMake(0, 40-.5f, 320, .5f);

        [cell.firstLB setFrame:CGRectMake(10, 10, 280, 20)];
        [cell.secondLB setFrame:CGRectMake(250, 10, 150, 20)];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (!indexPath.row) {
            if ([dic[@"overdueFine"] intValue] > 0) {
                cell.firstLB.text = [NSString stringWithFormat:@"%@月账单：%.2f元+%.2f元滞纳金",_myMonth,[dic[@"yuefu"] floatValue]/100,[dic[@"overdueFine"] floatValue]/100];
            }else{
                cell.firstLB.text = [NSString stringWithFormat:@"%@月账单：%.2f元",_myMonth,[dic[@"yuefu"] floatValue]/100];
            }
            cell.firstLB.attributedText = [XDTools getAcolorfulStringWithTextArray:@[[NSString stringWithFormat:@"%.2f",[dic[@"yuefu"] floatValue]/100],[NSString stringWithFormat:@"%.2f",[dic[@"overdueFine"] floatValue]/100]] Color:UIColorFromRGB(0xfb8f20) Font:[UIFont systemFontOfSize:15] AllText:cell.firstLB.text];
        }else if (indexPath.row == 1) {
//            int needPayStr = [dic[@"billAmount"] intValue] + [dic[@"overdueFine"] intValue] - [dic[@"payedAmount"] intValue];
//            cell.firstLB.text = [NSString stringWithFormat:@"%@月账单已还：%@元，还需还款%d元",_myMonth,dic[@"payedAmount"],needPayStr];
//            cell.firstLB.attributedText = [XDTools getAcolorfulStringWithText1:dic[@"payedAmount"] Color1:UIColorFromRGB(0xfb8f20) Font1:[UIFont systemFontOfSize:15] Text2:[NSString stringWithFormat:@"%d",needPayStr]
//                                                                        Color2:UIColorFromRGB(0xd10000) Font2:[UIFont systemFontOfSize:16] AllText:cell.firstLB.text];


            cell.firstLB.text = [NSString stringWithFormat:@"%@月账单还款日：%@",_myMonth,_billDate];
            if (_leftDays.intValue > 0) {
                cell.frame = CGRectMake(230, 10, 80, 20);
                cell.secondLB.text = [NSString stringWithFormat:@"还有%@天",_leftDays];
                cell.secondLB.textColor = [UIColor grayColor];
                cell.secondLB.attributedText = [XDTools getAcolorfulStringWithTextArray:@[_leftDays] Color:UIColorFromRGB(0xfb8f20) Font:[UIFont systemFontOfSize:15] AllText:cell.secondLB.text];
                cell.secondLB.textAlignment = NSTextAlignmentLeft;
                cell.secondLB.hidden = NO;

            }else{
                cell.secondLB.frame = CGRectMake(270, 10, 40, 20);
                cell.secondLB.text = @"";
                cell.secondLB.textColor = RGBA(206, 0, 18, 1);
                cell.secondLB.textAlignment = NSTextAlignmentRight;
                cell.secondLB.hidden = NO;
            }

        }else{

            cell.contentView.backgroundColor = RGBA(254, 254, 208, 1);
            cell.firstLB.text = [NSString stringWithFormat:@"本期账单逾期%@天，产生滞纳金%.2f元",_dataDic[@"overdueDayCount"],[_dataDic[@"overdueFine"] floatValue]/100];
            cell.firstLB.textColor = RGBA(204, 0, 18, 1);
            cell.firstLB.frame = CGRectMake(10, 5, 300, 20);
            cell.bottomLine.frame = CGRectMake(0, 30-.5f, 320, .5f);
        }


    }else {
        cell.bottomLine.frame = CGRectMake(0, 40-.5f, 320, .5f);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.firstLB.frame = CGRectMake(10, 10, 200, 20);
//        if ([_dataDic[@"repayStat"] intValue] == 2) {
//            cell.firstLB.text = [NSString stringWithFormat:@"待还期数：%d期",_payNum.intValue-[dic[@"periodNum"] intValue]];
//        }else{
//            cell.firstLB.text = [NSString stringWithFormat:@"待还期数：%d期",_payNum.intValue-[dic[@"periodNum"] intValue]+1];
//        }
        cell.firstLB.text = [NSString stringWithFormat:@"待还期数：%@期",_dataDic[@"notPayedPeriods"]];
        cell.secondLB.frame = CGRectMake(200, 10, 90, 20);
        cell.secondLB.text = @"查看明细";
        cell.secondLB.textAlignment = NSTextAlignmentRight;
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

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        PayHistoryViewController * history = [[PayHistoryViewController alloc] init];
        history.type = @"singel";
        history.orderId = _dataDic[@"orderId"];
        [self.navigationController pushViewController:history animated:YES];
    }
}


- (void)payNow{
    
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
