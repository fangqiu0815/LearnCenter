//
//  FirstViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//



#import "FirstViewController.h"
#import "XDHeader.h"
#import "XDTools.h"
#import "UIButton+Category.h"
#import "UIImageView+WebCache.h"
#import "MainGoodsCell.h"
#import "GoodsDetailViewController.h"
#import "ASIHTTPRequest.h"

#import "AboutViewController.h"
//#import "APService.h"
#import "MyOrdersViewController.h"
#import "MyBillsViewController.h"

#import "chooseCityModel.h"

#import "MaterialsViewController.h"
#define image_tag 10000

@interface FirstViewController ()
{
    UIButton * zdButton;
    UILabel * cityLB;
    UIImageView * jiantouIV;
    UIButton * chooseBtn;
    
    NSString * cityId;
}
@end

@implementation FirstViewController

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
    [super viewWillAppear:YES];
    DDLOG_CURRENT_METHOD;
//    [pageView openTimerTask];

    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"firstEnter"]){
        [self showChooseCityView:YES];
    }else{
        [self showChooseCityView:NO];
    }
    
    if ((![XDTools getPushValueWithType:@"1"])&&
        (![XDTools getPushValueWithType:@"2"])&&
        (![XDTools getPushValueWithType:@"3"])&&
        (![XDTools getPushValueWithType:@"4"])){
        [XDTabBarViewController sharedXDTabBarViewController].reminder_IV.hidden = YES;
    }else{
        [XDTabBarViewController sharedXDTabBarViewController].reminder_IV.hidden = NO;
    }
    if ([XDTools getPushValueWithType:@"2"]){
        messageTool2.hidden = NO;
    }else{
        messageTool2.hidden = YES;
    }
    if ([XDTools getPushValueWithType:@"3"]){
        if (messageTool2.isHidden){
            messageTool.hidden = NO;
        }else{
            messageTool.hidden = YES;
        }
    }else{
        messageTool.hidden = YES;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewWithPushinfo:) name:@"pushNotificationName" object:nil];

}

-(void)showChooseCityView:(BOOL)isShow
{
    if (isShow){
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstEnter"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        for (UIView * view in [XDTabBarViewController sharedXDTabBarViewController].bgView.subviews){
            if ([view isKindOfClass:[UIButton class]]){
                if (view.tag!=2000){
                    view.userInteractionEnabled = NO;
                }
            }
        }
        [[XDTabBarViewController sharedXDTabBarViewController].bgView addSubview:zdButton];
        jiantouIV.image = [UIImage imageNamed:@"shangjiantou"];
        choosecityView.hidden = NO;
        zdButton.hidden = NO;
    }else{
        for (UIView * view in [XDTabBarViewController sharedXDTabBarViewController].bgView.subviews){
            if ([view isKindOfClass:[UIButton class]]){
                if (view.tag !=2000){
                    view.userInteractionEnabled = YES;                
                }
            }
        }
        jiantouIV.image = [UIImage imageNamed:@"xiajiantou"];
        zdButton.hidden =YES;
        choosecityView.hidden =YES;
    }
}

-(void)letHiddenChooseCityView
{
    [self showChooseCityView:NO];
}

-(void)chooseBtnClick
{
    if (choosecityView.hidden) {
        [self showChooseCityView:YES];
    }else{
        [self showChooseCityView:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    DDLOG_CURRENT_METHOD;
//    [pageView closeTimerTask];
    [super viewWillDisappear:YES];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushNotificationName" object:nil];


}

//根据推送是发的消息展示页面
-(void)reloadTableViewWithPushinfo:(NSNotification *)info
{
    if ([XDTools getPushValueWithType:@"2"]){
        messageTool2.hidden = NO;
    }else{
        messageTool2.hidden = YES;
    }
    if ([XDTools getPushValueWithType:@"3"]){
        if (messageTool2.isHidden){
            messageTool.hidden = NO;
        }else{
            messageTool.hidden = YES;
        }
    }else{
        messageTool.hidden = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.leftBtn.hidden =YES;

    
    
    cityId = [[NSString alloc] init];
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"citymodel"]){
    
    }else{
        NSDictionary * dict  = @{@"cityname":@"全国",
                                 @"cityid":@""};
        [[NSUserDefaults standardUserDefaults] setValue:dict forKeyPath:@"citymodel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    cityId = [[[NSUserDefaults standardUserDefaults] valueForKey:@"citymodel"] valueForKey:@"cityid"];
    
    zdButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
    zdButton.backgroundColor = [UIColor blackColor];
    zdButton.alpha = 0.5;
    zdButton.tag = 2000;
    [zdButton addTarget:self action:@selector(letHiddenChooseCityView) forControlEvents:UIControlEventTouchUpInside];
    
//    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
//    //存登录信息
//    NSDictionary *userDic = @{@"name": @"maboyi"};
//    [userDef setObject:userDic forKey:kMMyUserInfo];
//    [userDef synchronize];



//    [self changeFrameWhenHiddenNavigationBar];

//    [[XDTools sharedXDTools] checkVersion:self isShowAlert:YES];
    dataArray = [[NSMutableArray alloc] init];
    bannerDataArray = [[NSMutableArray alloc] init];

    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH,self.contentView.frame.size.height-UI_TAB_BAR_HEIGHT)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:myTableView];
    
    headerView = [[MJRefreshHeaderView alloc] initWithScrollView:myTableView];
    headerView.delegate = self;

    breakNetLB = [XDTools addAlabelForAView:self.contentView withText:@"喵~网断啦" frame:CGRectMake(0,300,320,30) font:[UIFont systemFontOfSize:16] textColor:RGBA(146, 146, 146, 1)];
    breakNetLB.textAlignment = NSTextAlignmentCenter;
    breakNetLB.hidden = YES;
    [myTableView addSubview:breakNetLB];


    [self createMessageToolBar];
    [self createMessageToolBar2];

    if (ISLOGING) {
        [self autoLoginIn];
    }

    curpage = 1;
    totalCount = 0;

    [self getDataWithPageNum:@"1" api:API_HOMEPAGE];

//    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(100, 50, 100, 100) nomalTitle:@"detail test" hlTitle:nil titleColor:[UIColor yellowColor] bgColor:[UIColor redColor] nbgImage:nil hbgImage:nil action:@selector(go) target:self buttonTpye:UIButtonTypeCustom];
//    [self.view addSubview:btn];
    
    //版本更新
    [self updateVerson];
    
    choosecityView = [[ChooseCityView alloc] initWithFrame:CGRectMake(0, 0, 320, 1000)];
    choosecityView.delegate = self;
    [self.contentView addSubview:choosecityView];
    
//    UIView * vvv = [[UIView alloc] initWithFrame:[XDTabBarViewController sharedXDTabBarViewController].bgView.bounds];
//    vvv.backgroundColor = [UIColor redColor];
//    [[XDTabBarViewController sharedXDTabBarViewController].bgView addSubview:vvv];
    
    CGFloat cheight = IOS7?20:0;
    cityLB = [[UILabel alloc] initWithFrame:CGRectMake(345/2.0f, cheight+12, 40, 32)];
    cityLB.font = [UIFont systemFontOfSize:14];
    cityLB.textColor = [UIColor whiteColor];
    cityLB.backgroundColor = [UIColor clearColor];
    cityLB.text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"citymodel"] valueForKey:@"cityname"];
    [self.navigationBarView addSubview:cityLB];
    cityLB.hidden =YES;
    
    jiantouIV = [[UIImageView alloc] initWithFrame:CGRectMake(402/2.0f, aHeight+27, 11.5, 6)];
    jiantouIV.image = [UIImage imageNamed:@"xiajiantou"];
    [self.navigationBarView addSubview:jiantouIV];
    jiantouIV.hidden =YES;
    
    UIImageView * logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(215/2.0f, aHeight+16, 59, 20)];
    logoIV.image = [UIImage imageNamed:@"whirtLogo"];
    [self.navigationBarView addSubview:logoIV];
    
    chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.backgroundColor = [UIColor clearColor];
    chooseBtn.frame = CGRectMake(345/2.0f, cheight, 45, 44);
    chooseBtn.backgroundColor = [UIColor clearColor];
    [chooseBtn addTarget:self action:@selector(chooseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBarView addSubview:chooseBtn];
}

-(void)autoLoginIn{

    if (![XDTools NetworkReachable]) {
        [XDTools showTips:brokenNetwork toView:self.view];
        return;
    }

    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
    NSString * uid = infoDic[@"uid"];
    NSString * token = infoDic[@"token"];

    NSDictionary *dic = @{@"loginType":@"2",
                          @"uid":uid,
                          @"token":token};

    __block ASIFormDataRequest *request = [XDTools postRequestWithDict:dic API:API_LOGIN];

    [request setCompletionBlock:^{
        [XDTools hideProgress:self.view];

        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
        DDLOG(@"temdic == %@",tempDic);

        if([[tempDic objectForKey:@"result"]intValue] == 0){
            
            NSDictionary *subDict=[tempDic objectForKey:@"data"];
            NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
            //存登录信息

            [userDef setObject:subDict forKey:kMMyUserInfo];
            [userDef synchronize];

            NSString * uid = [[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] objectForKey:@"uid"];
            NSString * string = [NSString stringWithFormat:@"%@",uid];
//            [APService setTags:[NSSet setWithObject:[NSString stringWithFormat:@"%@",string]] callbackSelector:nil object:nil];

//
//            //            [XDTools showTips:@"登录成功" toView:self.contentView];


        }else{
//            [APService setTags:[NSSet setWithObject:@""] callbackSelector:nil object:nil];

//            [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];
        }

    }];

    [request setFailedBlock:^{
//        [APService setTags:[NSSet setWithObject:@""] callbackSelector:nil object:nil];

        [XDTools hideProgress:self.view];
        NSError *error = [request error];
        DDLOG(@"error=%@",error);
    }];
    
    //    [XDTools showProgress:self.view];
    [request startAsynchronous];
    
    
}

- (void)createMessageToolBar{
    messageTool = [[UIView alloc] initWithFrame:CGRectMake(0, UI_MAINSCREEN_HEIGHT-UI_TAB_BAR_HEIGHT-45, UI_SCREEN_WIDTH, 45)];
    messageTool.backgroundColor = [UIColor blackColor];
    messageTool.alpha = .7f;
    [self.contentView addSubview:messageTool];

    messageLB = [XDTools addAlabelForAView:messageTool withText:@"我已收到货了啦啦，请点击" frame:CGRectMake(10,10,180,25) font:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor]];
    checkBtn = [XDTools getAButtonWithFrame:CGRectMake(VIEW_POINT_MAX_X(messageLB)+10, 10, 65, 25) nomalTitle:@"已签收" hlTitle:@"已签收" titleColor:[UIColor whiteColor] bgColor:[UIColor orangeColor] nbgImage:nil hbgImage:nil action:@selector(checkProduct) target:self buttonTpye:UIButtonTypeCustom];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [messageTool addSubview:checkBtn];

    UIImageView * chazi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baichazi"]];
    chazi.frame = CGRectMake(290, 16, 13, 13);
    [messageTool addSubview:chazi];

    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(270, 0, 45, 45) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(hideTool) target:self buttonTpye:UIButtonTypeCustom];
    [messageTool addSubview:btn];
    
    messageTool.hidden = YES;
}

-(void)createMessageToolBar2
{
    messageTool2 = [[UIView alloc] initWithFrame:CGRectMake(0, UI_MAINSCREEN_HEIGHT-UI_TAB_BAR_HEIGHT-45, UI_SCREEN_WIDTH, 45)];
    messageTool2.backgroundColor = [UIColor blackColor];
    messageTool2.alpha = .7f;
    [self.contentView addSubview:messageTool2];
    
    messageLB2 = [XDTools addAlabelForAView:messageTool2 withText:@"喵~！本期账单还没还？猛戳这里" frame:CGRectMake(10,10,220,25) font:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor]];
    checkBtn2 = [XDTools getAButtonWithFrame:CGRectMake(VIEW_POINT_MAX_X(messageLB2)+10, 10, 65, 25) nomalTitle:@"马上还款" hlTitle:@"马上还款" titleColor:[UIColor whiteColor] bgColor:[UIColor orangeColor] nbgImage:nil hbgImage:nil action:@selector(checkProduct2) target:self buttonTpye:UIButtonTypeCustom];
    checkBtn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [messageTool2 addSubview:checkBtn2];
    
    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(270, 0, 45, 45) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(hideTool) target:self buttonTpye:UIButtonTypeCustom];
    
    messageTool2.hidden = YES;
}

- (void)go{
    GoodsDetailViewController * detail = [[GoodsDetailViewController alloc] init];
    detail.goodsId = @"6";
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)checkProduct{
    MyOrdersViewController * orderVC = [[MyOrdersViewController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
}

-(void)checkProduct2{
    MyBillsViewController * billsVC = [[MyBillsViewController alloc] init];
    [self.navigationController pushViewController:billsVC animated:YES];
}

- (void)hideTool{
    [XDTools setPushInfoType:@"3" andValue:@"0"];
    messageTool.hidden = YES;
}

- (void)createFourButtonsForView:(UIView *)view{
//    NSArray * nameArr = [NSArray arrayWithObjects:@"0首付",@"手续简单",@"在线还贷",@"最长20期", nil];
//    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, UI_SCREEN_WIDTH, 67)];
//    for (int i = 0; i < 4; i++) {
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setFrame:CGRectMake(i*80, 1, 80, 65)];
//        btn.backgroundColor = [UIColor whiteColor];
//        [bgView addSubview:btn];
//    }
//    [view addSubview:bgView];

    UIImageView * fourTabs = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, UI_SCREEN_WIDTH, 67.5f)];
    fourTabs.image = [UIImage imageNamed:@"fourTab"];
    [view addSubview:fourTabs];
}



#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row) {
        return 217;
    }else{
        return 163;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row) {
        NSString * cellIde0 = @"cell0";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde0];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            /*图片轮播*/
//            pageView = [[XYScrollView alloc] initPageScrollView:CGRectMake(0, 0, 320, 150) pageControllerFrame:CGRectMake(120,135, 100, 10) backgroudImage:nil pageNumber:PAGESCROLLVIEWNUMBER];
//            //如果有图片点击事件，就设置代理，没有则不设置
//            pageView.delegate = self;
//                        [cell.contentView addSubview:pageView];

            UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bannerPlaceholder"]];
            iv.frame = CGRectMake(0, 0, 320, 150);
            [cell.contentView addSubview:iv];
            
            pageScrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150) andPageControllRect:CGRectMake(110,135,100, 10)];
            pageScrollView.delegate = self;
            [cell.contentView addSubview:pageScrollView];
            
            [self createFourButtonsForView:cell.contentView];
            
            UIImageView * lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 216.5f, UI_SCREEN_WIDTH, .5f)];
            lineIV.image = [UIImage imageNamed:@"line"];
            [cell.contentView addSubview:lineIV];
        }

        //图片来源于网络
        NSMutableArray * imageUrlArray = [[NSMutableArray alloc] init];

        
        for (NSDictionary * dic in bannerDataArray) {
            [imageUrlArray addObject:dic[@"pic"]];
        }

        if (imageUrlArray.count){
            NSMutableArray * tArray = [[NSMutableArray alloc] init];
            for (NSString * str in imageUrlArray){
                NSDictionary * dict = @{@"image_url":str};
                [tArray addObject:dict];
            }
            pageScrollView.placeholderImg = [UIImage imageNamed:@"bannerPlaceholder"];
            pageScrollView.imageUrlArray = tArray;
        }
        return cell;
    }else{
        NSString * cellIde = @"cell";
        MainGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MainGoodsCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.goodsIV.backgroundColor = [UIColor grayColor];
            cell.bgIV.backgroundColor = [UIColor whiteColor];
            cell.bgIV.layer.borderWidth = .5f;
            cell.bgIV.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;

//            cell.normalLB.hidden = YES;
//            cell.shortLine.hidden = YES;
        }
        NSDictionary * dic = dataArray[indexPath.row-1];
        if (![dic[@"pic"] isKindOfClass:[NSNull class]]) {
            [cell.goodsIV setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:[UIImage imageNamed:@"homeGoods"]];
        }
        cell.VIPLB.text = [NSString stringWithFormat:@"￥%d",[dic[@"price"] intValue]/100];
        cell.normalLB.text = [NSString stringWithFormat:@"￥%d",[dic[@"marketPrice"] intValue]/100];
        cell.monthPayLB.text = [NSString stringWithFormat:@"0首付 月供%d元起",[dic[@"payment"] intValue]/100];
        cell.monthPayLB.attributedText = [XDTools getAcolorfulStringWithText1:@"0首付" Color1:[UIColor orangeColor] Font1:[UIFont systemFontOfSize:14] Text2:[NSString stringWithFormat:@"%d元",[dic[@"payment"] intValue]/100] Color2:[UIColor orangeColor] Font2:[UIFont systemFontOfSize:14] AllText:cell.monthPayLB.text];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row) {
        return;
    }
    GoodsDetailViewController * detail = [[GoodsDetailViewController alloc] init];
    detail.goodsId = dataArray[indexPath.row-1][@"productId"];
//    detail.picStr = dataArray[indexPath.row-1][@"pic"];
    [self.navigationController pushViewController:detail animated:YES];
//    MaterialsViewController * material = [[MaterialsViewController alloc] init];
//    [self.navigationController pushViewController:material animated:YES];
}

-(void)btnClick:(UIButton *)sender
{
    DDLOG_CURRENT_METHOD;
    if (sender.tag==1){
        [XDTools showTips:@"操作成功" toView:self.contentView];
    }else if (sender.tag ==2){
        [XDTools showProgress:self.contentView];
    }else if (sender.tag ==3){
        [XDTools showProgress:self.contentView showText:@"正在加载..."];
    }else if (sender.tag ==4){
    
    }else if (sender.tag ==5){
    
    }
}

- (void)getDataWithPageNum:(NSString *)page api:(NSString *)api{
    if ([XDTools NetworkReachable])
    {
        breakNetLB.hidden = YES;
        
//        NSString *requestURlString = [NSString stringWithFormat:@"%@%@?cityId=%@",HOST_URL,API_HOMEPAGE,cityId];
//        DDLOG(@"requesetUrl = %@",requestURlString);
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURlString]];
//        [XDTools getRequestWithDict:@{@"":@""} API:API_HOMEPAGE];

        NSDictionary * dic;
        if (IS_NOT_EMPTY(cityId)) {
            dic = @{@"cityId": cityId};
        }else{
            dic = @{@"cityId": @""};
        }

        ASIHTTPRequest * request = [XDTools postRequestWithDict:dic API:API_HOMEPAGE];

        __weak ASIHTTPRequest * mrequest = request;

        [request setCompletionBlock:^{

            [XDTools hideProgress:self.contentView];
            [headerView endRefreshing];
            [footerView endRefreshingWithoutIdle];

            NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

            if ([[tempDic objectForKey:@"result"] intValue] == 0)
            {
                [bannerDataArray removeAllObjects];
                [dataArray removeAllObjects];

                if (page.intValue == 1) {
                    bannerDataArray = [NSMutableArray arrayWithArray:tempDic[@"data"][@"topic"]];
                    dataArray = [NSMutableArray arrayWithArray:tempDic[@"data"][@"productList"]];
                }else{
                    [dataArray addObjectsFromArray:tempDic[@"data"][@"list"]];
                }
                [myTableView reloadData];
            }
            else
            {
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
        breakNetLB.hidden = NO;
        [headerView endRefreshing];
        [footerView endRefreshingWithoutIdle];
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
//    isRefresh = YES;
//    curpage = 1;
//    totalCount = 0;
    [self getDataWithPageNum:@"1" api:API_HOMEPAGE];

}


- (void)getNextData{
//    isGetMore = YES;
    if (totalCount == -999)
    {
        [headerView endRefreshing];
        [footerView endRefreshingWithoutIdle];
        [XDTools showTips:@"没有更多数据" toView:self.view];
        [self yoffset:dataArray andTableview:myTableView];
    }
    else
    {
        curpage++;
        [self getDataWithPageNum:@"1" api:API_HOMEPAGE];
        
    }
}

- (void)yoffset:(NSMutableArray *)arr andTableview:(UITableView *)tableview
{
    CGFloat y = tableview.contentOffset.y;
    tableview.contentOffset = CGPointMake(0, y-60);
    
}



////这个是XYScrollView中的代理方法，主要的功能可以实现里面每个imageview的点击事件的
//-(void)gestureClick:(UITapGestureRecognizer *)sender
//{
//    DDLOG_CURRENT_METHOD;
//    UIImageView * imageView =(UIImageView *)[pageView.myScrollView viewWithTag:sender.view.tag];
//    
//    //这里就写跳到下一的代码....imageView.tag-image_tag
//    DDLOG(@"imageView.tag = %d",imageView.tag);
//
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:bannerDataArray[imageView.tag-10001][@"url"]]];
//}

#pragma mark -轮播图点击的代理方法
-(void)gestureClick:(UITapGestureRecognizer *)sender andUrl:(NSString *)urlString
{
    int page = [urlString intValue];
    AboutViewController * aboutVC = [[AboutViewController alloc] init];
    aboutVC.titleString =[[bannerDataArray objectAtIndex:page-1] valueForKey:@"title"];
    aboutVC.urlString =[[bannerDataArray objectAtIndex:page-1] valueForKey:@"url"];
    [self.navigationController pushViewController:aboutVC animated:YES];

}


#pragma mark  版本更新
-(void)updateVerson{
    
    if(![XDTools NetworkReachable]){
        [XDTools showTips:brokenNetwork toView:self.view];
        return;
    }
    
    ASIHTTPRequest * request = [XDTools postRequestWithDict:@{} API:API_GETVIESION];
    __weak ASIHTTPRequest * mrequest = request;

    [request setCompletionBlock:^{
        NSString *str = [[NSString alloc] initWithData:mrequest.responseData encoding:NSUTF8StringEncoding];
        NSDictionary * tmpDict= [XDTools JSonFromString:str];
        
        if ([[tmpDict valueForKey:@"result"]intValue]==0){
            cityLB.hidden =NO;
            jiantouIV.hidden = NO;
            NSDictionary * dict =[tmpDict valueForKey:@"data"];
            
            NSMutableArray * sArray = [[NSMutableArray alloc] init];
            for (NSDictionary * dcci in [dict valueForKey:@"cityList"]){
                chooseCityModel * amodel = [[chooseCityModel alloc] initWithDic:dcci];
                [sArray addObject:amodel];
            }
            choosecityView.dataArray = sArray;
            
            [[NSUserDefaults standardUserDefaults] setValue:[dict valueForKey:@"ios_praise_url"] forKey:@"ios_praise_url"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSString *oldVerson = [[NSString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
            
            NSString *newVerson = [dict valueForKey:@"ios_version"];
            
            downUrl = [dict objectForKey:@"ios_url"];
            
            cString = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"ios_content"]];

            
            while (1){
                NSRange rangAnd = [cString rangeOfString:@"/n"];
                if (rangAnd.location == NSNotFound) {
                    break;
                }
                [cString replaceCharactersInRange:rangAnd withString:@"\n"];
            }

            if ([newVerson isEqualToString:oldVerson]) {
            
                [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"hasNewVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }else{
                
                [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"hasNewVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if ([[dict valueForKey:@"ios_force"] intValue]==1){
                    //强制更新
                    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"mustupdate"];
                    [[NSUserDefaults standardUserDefaults] setValue:dict forKeyPath:@"versioninfo"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:cString delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                    al.tag = 1000;
                    [al show];
                }else{
                    //不强制更新
                    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:cString delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"忽略本次", nil];
                    al.tag = 1000;
                    [al show];
                }
            }
        }else{
            [XDTools showTips:[tmpDict valueForKey:@"msg"] toView:self.view];
        }
        
    }];
    
    [request setFailedBlock:^{

        [XDTools showTips:@"网络请求超时" toView:self.view];
        
    }];
    
    [request startAsynchronous];
}

#pragma mark ChooseCityView Delegate
-(void)clickBgViewLetViewHidden
{
    [self showChooseCityView:NO];
}

-(void)chooseTheCity:(chooseCityModel *)model
{
    if ([model.cityName isEqualToString:@"其他"]){
        model.cityName = @"全国";
        cityId=@"";
        NSDictionary * dd = @{@"cityname":@"全国",
                              @"cityid":@""};
        [[NSUserDefaults standardUserDefaults] setValue:dd forKeyPath:@"citymodel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        NSDictionary * dd = @{@"cityname":model.cityName,
                              @"cityid":model.cityId};
        [[NSUserDefaults standardUserDefaults] setValue:dd forKeyPath:@"citymodel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    cityLB.text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"citymodel"] valueForKey:@"cityname"];
    if ([cityLB.text isEqualToString:@"其他"]) {
        cityLB.text = @"全国";
    }
    cityId = [[[NSUserDefaults standardUserDefaults] valueForKey:@"citymodel"] valueForKey:@"cityid"];
    [self getDataWithPageNum:@"1" api:API_HOMEPAGE];
}

#pragma mark- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000){
        if (buttonIndex == 0) {
            NSURL *url = [NSURL URLWithString:downUrl];
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
