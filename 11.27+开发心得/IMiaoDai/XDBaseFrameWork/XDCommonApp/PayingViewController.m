//
//  PayingViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-16.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "PayingViewController.h"
#import "MySystemCell.h"
@interface PayingViewController ()

@end

@implementation PayingViewController

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

    self.titleLabel.text = @"我要还款";

//    UITableView * myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT-UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
//    myTableView.delegate = self;
//    myTableView.dataSource = self;
//    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    myTableView.backgroundColor = [UIColor clearColor];
//    [self.contentView addSubview:myTableView];

    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT-UI_NAVIGATION_BAR_HEIGHT)];
    myWebView.delegate = self;
    [self.contentView addSubview:myWebView];

    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIde = @"cell";
    MySystemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (cell == nil) {
        cell = [[MySystemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor clearColor];
        UIButton * rightBtn = [XDTools getAButtonWithFrame:CGRectMake(300, 13.5f, 13.5f, 13.5f) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:@"dis_selected" hbgImage:nil action:@selector(chooseIt:) target:self buttonTpye:UIButtonTypeCustom];
        rightBtn.tag = 888800+indexPath.section;
        [cell.contentView addSubview:rightBtn];
    }

    if (!indexPath.section) {
        cell.firstLB.text = [NSString stringWithFormat:@"%@月账单：%@元",_month,_cost];
        cell.firstLB.frame = CGRectMake(10, 10, 250, 20);
        UIButton * btn = (UIButton *)[cell.contentView viewWithTag:888800];
        btn.enabled = NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"pencel"] forState:UIControlStateNormal];

        cell.topLine.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, .5f);
        cell.bottomLine.frame = CGRectMake(0, 39.5f, UI_SCREEN_WIDTH, .5f);
    }else if (indexPath.section == 1) {
        cell.bottomLine.frame = CGRectMake(0, 39.5f, UI_SCREEN_WIDTH, .5f);
        if (!indexPath.row) {
            cell.headIV.image = [UIImage imageNamed:@"zhifubao"];
            cell.headIV.frame = CGRectMake(10, 10.5f, 26.5f, 19);
            cell.firstLB.text = @"支付宝支付";
            cell.firstLB.frame = CGRectMake(VIEW_POINT_MAX_X(cell.headIV)+10, 10, 200, 20);
            UIButton * btn = (UIButton *)[cell.contentView viewWithTag:888801];
            btn.tag = 888805;
            [btn setBackgroundImage:[UIImage imageNamed:@"dis_selected"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];

        }else{
            cell.headIV.image = [UIImage imageNamed:@"caifutong"];
            cell.headIV.frame = CGRectMake(10, 6.5f, 26.5f, 26.5f);
            cell.firstLB.text = @"财付通支付";
            cell.firstLB.frame = CGRectMake(VIEW_POINT_MAX_X(cell.headIV)+10, 10, 200, 20);
            cell.topLine.hidden = YES;
            UIButton * btn = (UIButton *)[cell.contentView viewWithTag:888801];
            btn.tag = 888806;
            [btn setBackgroundImage:[UIImage imageNamed:@"dis_selected"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];

        }
    }else{
        cell.backgroundColor = [UIColor clearColor];
        cell.topLine.hidden = YES;
        cell.bottomLine.frame = CGRectMake(0, 80-.5f, 320, 0);
        cell.accessoryType = UITableViewCellAccessoryNone;
        UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(10, 0, 300, 40) nomalTitle:@"马上还款" hlTitle:@"马上还款" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf28d01) nbgImage:nil hbgImage:nil action:@selector(payNow:) target:self buttonTpye:UIButtonTypeCustom];
        [cell.contentView addSubview:btn];

        UIButton * btn1 = (UIButton *)[cell.contentView viewWithTag:888802];
        btn1.hidden = YES;
    }




    return cell;
}

#pragma mark - TableView Delegate


- (void)payNow:(UIButton *)sender{
    UIButton * btn1 = (UIButton *)[self.view viewWithTag:888805];
    UIButton * btn2 = (UIButton *)[self.view viewWithTag:888806];

    if (!btn1.selected && !btn2.selected) {
        [XDTools showTips:@"请选择支付类型" toView:self.contentView];
        return;
    }

    if (![XDTools NetworkReachable]) {
        [XDTools showTips:brokenNetwork toView:self.view];
        return;
    }

//    uid	string	是	用户id
//    token	string	是	用户token，用来验证用户是否登录
//    userName	string	是	用户名
//    payAmt	string	是	还款金额
//    paymentId	string	是	alipay:支付宝
//weixin:微信支付
//tenpay:财付通
//
//    billDate	string	否	账单日期
//    orderId	string	否	购买订单号，针对单笔订单还款的时候有此字段

    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
    NSString * paymentId = @"";
    if (btn1.selected) {
        paymentId = @"alipay";
    }else{
        paymentId = @"tenpay";
    }
    NSDictionary * parms = @{@"uid": infoDic[@"uid"],
                             @"token":infoDic[@"token"],
                             @"userName":infoDic[@"userName"],
                             @"payAmt":_cost,
                             @"paymentId":paymentId,
                             @"billDate":_billDate};

    __block  ASIFormDataRequest *request = [XDTools postRequestWithDict:parms API:API_PAY];

    [request setCompletionBlock:^{
        [XDTools hideProgress:self.view];

        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
        if([[tempDic objectForKey:@"result"]intValue] == 0){
            if (btn1.selected) {
                //选择支付宝

            }else{
                //选择财付通
                
            }
        }else{
            [XDTools showTips:tempDic[@"msg"] toView:self.view];

        }
    }];

    [request setFailedBlock:^{

        [XDTools hideProgress:self.view];
        NSError *error = [request error];
        DDLOG(@"error=%@",error);
    }];
    
    [XDTools showProgress:self.view];
    [request startAsynchronous];


}

- (void)chooseIt:(UIButton *)sender{
    UIButton * btn1 = (UIButton *)[self.view viewWithTag:888805];
    UIButton * btn2 = (UIButton *)[self.view viewWithTag:888806];
    btn1.selected = NO;
    btn2.selected = NO;
    sender.selected = YES;

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
