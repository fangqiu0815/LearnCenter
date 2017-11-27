//
//  GoodsBuyerViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-1.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "GoodsBuyerViewController.h"
#import "GoodsBuyerCell.h"
#import "UIImageView+WebCache.h"
@interface GoodsBuyerViewController ()

@end

@implementation GoodsBuyerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backPrePage{
    [headerView free];
    [footerView free];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleLabel.text = @"购买同学";

    isFirst = YES;

    dataArray = [[NSMutableArray alloc] init];

    currentCount = 0;
    currentPage = 1;

    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:myTableView];

    headerView = [[MJRefreshHeaderView alloc] initWithScrollView:myTableView];
    headerView.delegate = self;

    footerView = [[MJRefreshFooterView alloc] initWithScrollView:myTableView];
    footerView.delegate = self;

//    for (int i = 0; i < 10; i++) {
//        NSString * name = [NSString stringWithFormat:@"小%d",i];
//        NSString * info = [NSString stringWithFormat:@"0首付,月供%d元",i*100];
//        NSString * time = [NSString stringWithFormat:@"2014-8-%d",i+1];
//        NSDictionary * dic = @{@"name":name,
//                               @"info":info,
//                               @"time":time};
//        [dataArray addObject:dic];
//    }

    [self getDataWithPageNum:@"1" api:API_GOODSBUYERS];

}

- (void)getDataWithPageNum:(NSString *)page api:(NSString *)api{
    if ([XDTools NetworkReachable])
    {

        NSDictionary * dic = @{@"productId": _goodsId,
                               @"pn":page,
                               @"rn":@"10"};

        ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:api];
        __weak ASIHTTPRequest * mrequest = request;

        [request setCompletionBlock:^{

            [XDTools hideProgress:self.contentView];

            NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

            if ([[tempDic objectForKey:@"result"] intValue] == 0)
            {
                if (page.intValue == 1) {
                    dataArray = [NSMutableArray arrayWithArray:tempDic[@"data"][@"list"]];
                }else{
                    [dataArray addObjectsFromArray:tempDic[@"data"][@"list"]];
                }
                currentCount = dataArray.count;
                if (currentCount == [tempDic[@"data"][@"count"] intValue]) {
                    currentCount = -1;
                }
                [myTableView reloadData];
            }
            else
            {
                [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];
            }
            [headerView endRefreshing];
            [footerView endRefreshingWithoutIdle];
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



#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row) {
        return 50;
    }else{
        return 75;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row) {
        NSString * cellIde0 = @"cell0";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde0];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
            topView.backgroundColor = UIColorFromRGB(0xececec);
            [cell.contentView addSubview:topView];

            UILabel * label = [XDTools addAlabelForAView:cell.contentView withText:@"最近30天购买的同学" frame:CGRectMake(10,10,290,40) font:[UIFont systemFontOfSize:17] textColor:[UIColor blackColor]];

            [XDTools addLineToView:cell.contentView frame:CGRectMake(0, 10, 5, 40) color:[UIColor orangeColor]];

            UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49.5f, UI_SCREEN_WIDTH, .5F)];
            line.image = [UIImage imageNamed:@"line"];
            [cell.contentView addSubview:line];
        }
        return cell;

    }else{
        NSString * cellIde = @"cell1";
        GoodsBuyerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsBuyerCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.headIV.layer.cornerRadius = cell.headIV.bounds.size.height/2;
            cell.headIV.layer.masksToBounds = YES;
            cell.lineIV.frame = CGRectMake(0, 74.5f, 300, .5f);
        }
        NSDictionary * dic = dataArray[indexPath.row-1];//dic[@"school"]
        cell.nameLB.text = [NSString stringWithFormat:@"%@ %@同学",[self matchingSchool:dic[@"school"]],dic[@"usrName"]];
        cell.infoLB.text = [NSString stringWithFormat:@"%@首付，%@期，月供%@元",dic[@"shoufu"],dic[@"paymentType"],dic[@"yuefu"]];
        cell.infoLB.attributedText = [XDTools getAcolorfulStringWithTextArray:@[dic[@"shoufu"],dic[@"paymentType"],dic[@"yuefu"]] Color:UIColorFromRGB(0xf4a800) Font:[UIFont systemFontOfSize:14] AllText:cell.infoLB.text];
        cell.timeLB.text = dic[@"orderTime"];
//        if (![dic[@"pic"] isKindOfClass:NSNull]) {
            [cell.headIV setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:[UIImage imageNamed:@"humanHeader"]];
//        }
        return cell;
    }
}


-(NSString *)matchingSchool:(NSString *)schoolId
{
    FMDatabase * db = [XDTools getDb];
    if (![db open]){
        DDLOG(@"open fail!");
        return nil;
    }
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM T_P_COLLAGE WHERE COLLAGE_ID = %@",schoolId];

    FMResultSet * rs = [db executeQuery:queryString];
    NSString * collageName = @"";
    while ([rs next]) {
        collageName = [rs objectForColumnName:@"COLLAGE_NAME"];
    }
    [db close];

    return collageName;

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
    [self getDataWithPageNum:@"1" api:API_GOODSBUYERS];
}


- (void)getNextData{
    if (currentCount < 0)
    {
        [headerView endRefreshing];
        [footerView endRefreshingWithoutIdle];
        [XDTools showTips:@"喵~没有其他同学啦" toView:self.view];
        [self yoffset:dataArray andTableview:myTableView];
    }
    else
    {
        currentPage++;
        [self getDataWithPageNum:[NSString stringWithFormat:@"%d",currentPage] api:API_GOODSBUYERS];
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
