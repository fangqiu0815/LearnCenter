//
//  XWPacketVC.m
//  zhangshangnews
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWPacketVC.h"
#import "XWPacketNewVC.h"
#import "XWPacketTigerVC.h"
#import "XWPacketExchangeVC.h"
#import "XWPacketWhatIsCoinVC.h"
#import "XWPacketMidCell.h"
#import "XWPacketAdView.h"
#import "XWPacketHeaderView.h"
#import "TXScrollLabelView.h"
#import "XWPaoMaView.h"
#import "XWTaskListHeaderCell.h"
#import "XWTaskMidCell.h"
#import "XWTaskImageCell.h"
#import "XWPublishView.h"
#import "XWImageCell.h"
#import "XWUserTaskModel.h"
#import "XWSysTaskInfoTool.h"
#import "XWTaskDetailInfoModel.h"
#import "XWSysTaskInfoListModel.h"
#import <UMSocialCore/UMSocialCore.h>
#import "XWShareRecoverModel.h"

@interface XWPacketVC ()<UITableViewDelegate,UITableViewDataSource,XFPublishViewDelegate,TXScrollLabelViewDelegate>
{
    NSArray *_dataArr;

    NSString *_shareStatus;
    NSString *_shareDesc;
    
    NSString *_signInStatus;
    NSString *_signInDesc;
    
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XWPacketAdView *adView;
@property (nonatomic, strong) XWPacketHeaderView *headerView;

@property (nonatomic, strong) XWPaoMaView *paomaView;

@property (nonatomic, strong) NSMutableArray *infoArr;

@property (nonatomic, strong) NSMutableArray *dataArray;

/** 上一次选中 tabBar 的索引*/
@property (nonatomic, strong) UIViewController *lastSelectedIndex;

@property (nonatomic, strong) XWPacketMidCell *taskArrayCell;

@property (nonatomic, strong) NSMutableArray *stypeArr1 ;

@property (nonatomic, strong) NSMutableArray *stypeArr2 ;

@property (nonatomic, strong) NSMutableArray *stypeArr3 ;

@property (nonatomic, strong) NSMutableArray *shareArr;

@property (nonatomic, strong) UIView *receiveView;

@property (nonatomic, strong) UIView *qrcodeView;

@property (nonatomic, strong) NSMutableArray *signInArr;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) TYAlertController *alertController;


@end

@implementation XWPacketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainBGColor;
    
    //通知方式去监测点击tabbar
//    // 监听 tabBar 点击的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:@"TabRefresh" object:nil];
    [SysUserTaskData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    
    //设置tableview
    [self setupTableView];
//    //添加刷新控件
//    [self setupRefresh];
//    [self loadTaskListData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginInAction) name:@"issignPacket" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTaskInfo) name:@"reloadTaskInfo" object:nil];
    
    [self.tableView.mj_header beginRefreshing];
    
    //设置实时公告
    [self setupNowNotice];
    //设置金币详情view
    [self setupCoinInfoView];

    [self issignPacket];
}

+ (void)sentValueClick:(intBlock)_sentBlock
{
    //签到
    
    XWPacketVC *vc = [[XWPacketVC alloc]init];
    NSInteger a = [vc.signInIngot integerValue];
    _sentBlock(a);
}

+ (void)sentValueClickb:(intBlockb)_sentBlock
{//分享app
    XWPacketVC *vc = [[XWPacketVC alloc]init];
    NSInteger b = [vc.shareIngot integerValue];
    _sentBlock(b);
}
//- (void)tabBarSelected{
//    
//    //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
//    if (self.lastSelectedIndex != self.tabBarController.selectedViewController && self.view.isShowingOnKeyWindow) {
//        
//        [self.tableView.mj_header beginRefreshing];
//        NSLog(@"%@--%@",self,self.parentViewController);
//    };
//    
//    self.lastSelectedIndex = self.tabBarController.selectedViewController;
//    
//}
//
//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    if (!self.lastSelectedIndex) {
//        self.lastSelectedIndex = self.tabBarController.selectedViewController;
//    }
//}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
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
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
    
    [self setStatusBarBackgroundColor:MainRedColor];

    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"任务大厅";
    label.font = [UIFont systemFontOfSize:18];
    
    self.navigationItem.titleView = label;
    //[self.tableView.mj_header beginRefreshing];

    //从后台转到前台任务列表自动刷新的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground)name:UIApplicationWillEnterForegroundNotification object:nil];
    
}



#pragma mark ============ 从后台转到前台 任务列表自动刷新 ========================
- (void)applicationWillEnterForeground{
    
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark =============== 重刷新界面 ======================
- (void)reloadTaskInfo
{
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark =============== 签到状态 ====================
- (void)issignPacket
{
    // 签到状态
    if (STUserDefaults.issign == 1) {
        [self.headerView.signInBtn setTitle:@"已签到" forState:0];
        [self.headerView.signInBtn setBackgroundColor:MainMidLineColor];
        self.headerView.signInBtn.userInteractionEnabled = NO;
    } else {
        [self.headerView.signInBtn setTitle:@"签到" forState:0];
        [self.headerView.signInBtn setBackgroundColor:MainRedColor];

    }

}

//设置实时公告
#pragma mark =============== 提现公告跑马灯 ====================

- (void)setupNowNotice
{
    
    
}

- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index
{
    JLLog(@"--text-%@---index-%ld-",text,(long)index);
}

//设置金币详情view
#pragma mark =============== 签到头部view ====================
- (void)setupCoinInfoView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 210)];
    
    XWPacketHeaderView *headView = [[XWPacketHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 165)];
    headView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);

    [headView.signInBtn addTarget:self action:@selector(signInClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView.signInRulBtn addTarget:self action:@selector(signInRuleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.headerView = headView;
    [view addSubview:headView];
    
    XWPaoMaView *paomaView = [[XWPaoMaView alloc]initWithFrame:CGRectMake(0, 166, ScreenW, 40)];
    self.paomaView = paomaView;
    
    paomaView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    
    [view addSubview:paomaView];
    
    self.tableView.tableHeaderView = view;
}

#pragma mark - ================== 签到 =======================
//   签到
- (void)signInClick:(id)sender
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    JLLog(@"signInClick");
//    if (![STUserDefaults.phonenum isEqualToString:@""]) {
        JLLog(@"islogin");
        //签到接口
        [self signInNumberDay];
        
//    } else {
//        [SVProgressHUD dismiss];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
//    }
    
}

- (void)signInNumberDay
{
    
    [STRequest SignInNumberDataWithBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                NSString *cStr = [NSString stringWithFormat:@"%@",ServersData[@"c"]];
                if ([cStr isEqualToString:@"1"]) {
                    [SVProgressHUD dismiss];
                    NSDictionary *dicttemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    STUserDefaults.signstate = [dicttemp[@"signstate"] integerValue];
                    STUserDefaults.serialsign = [dicttemp[@"serialsign"] integerValue];
                    
                    _signInArr = [NSMutableArray arrayWithArray:dicttemp[@"taskstatus"]];
                    
                    if (_signInArr.count == 0) {
                        JLLog(@"无数据");
                    } else {
                        _signInIngot = _signInArr[0][@"ingot"];
                        _signInStatus = _signInArr[0][@"status"];
                        _signInDesc = _signInArr[0][@"desc"];
                        if (STUserDefaults.signstate == 1) {
                            [SVProgressHUD showSuccessWithStatus:@"签到成功"];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"issignPacket" object:nil];
                            if (_signInArr.count == 0) {
                                JLLog(@"签到奖励空列表");
                            }else{
                                if ([_signInStatus integerValue] == 0) {
                                    JLLog(@"签到任务进行中");
                                } else {
                                    JLLog(@"签到任务完成");
                                    [self setupAlertViewWithTitle:_signInIngot];
                                    
                                    NSString *str = [NSString stringWithFormat:@"签到成功\n＋%@元宝",_signInIngot];
                                    
                                    [SVProgressHUD showSuccessWithStatus:str];
                                    
                                    //刷新任务列表
                                    [self loadTaskListData];
                                }
                                
                            }
                            
                        }else{
                            [SVProgressHUD showSuccessWithStatus:@"签到失败"];
                            
                        }

                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadScoreAction" object:nil];
                    
                    
                } else {
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];

                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:@"服务器格式错误！"];
                
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"网络错误！"];
            [SVProgressHUD showErrorWithStatus:@"签到失败"];
        }
        
    }];
    
}

-(void)loginInAction{
    [self.headerView.signInBtn setTitle:@"已签到" forState:0];
    [self.headerView.signInBtn setBackgroundColor:MainTextColor];
    self.headerView. signInNumberLab.text = [NSString stringWithFormat:@"%ld",(long)STUserDefaults.serialsign];
    self.headerView.signInBtn.userInteractionEnabled = NO;
    
}

#pragma mark =============== 用户完成任务个数(弃用) ====================

//- (void)signInBackTaskList
//{
//    //1）	用户完成任务个数（客户端定时请求，5分钟左右）
//
//    [STRequest UserFinishTaskNumberDataBlock:^(id ServersData, BOOL isSuccess) {
//        if (isSuccess) {
//            [SVProgressHUD dismiss];
//            if ([ServersData isKindOfClass:[NSDictionary class]]) {
//                NSString *cStr = [NSString stringWithFormat:@"%@",ServersData[@"c"]];
//                if ([cStr isEqualToString:@"1"]) {
//                    NSDictionary *dicttemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
//                    
//                    STUserDefaults.rewardNum = [dicttemp[@"rewardNum"] integerValue];
//
//                } else {
//                    
//                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
//                    
//                }
//                
//            } else {
//                [SVProgressHUD showErrorWithStatus:@"服务器格式错误！"];
//                
//            }
//            
//        } else {
//            [SVProgressHUD showErrorWithStatus:@"网络错误！"];
//            
//        }
//        
//    }];
//
//}


- (void)signInRuleClick:(id)sender
{
    XWPacketWhatIsCoinVC *coinVC = [[XWPacketWhatIsCoinVC alloc]init];
    [self.navigationController pushViewController:coinVC animated:YES];
    
}

//设置tableview
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , ScreenW, ScreenH-60) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    //添加刷新控件
    [self setupRefresh];
    [self loadTaskListData];
    [self setupTaskInfoList];
    
}

- (void)setupTaskInfoList{
    [self.stypeArr1 removeAllObjects];
    [self.stypeArr2 removeAllObjects];
    [self.stypeArr3 removeAllObjects];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:XWPACKET_TASKINFO_CACHE_PATH];
    
    STUserDefaults.taskListArr = array;
    for (int i = 0; i < array.count; i++) {
        if ([array[i][@"stype"] intValue] == 1) {
            [self.stypeArr1 addObject:array[i]];
        }else if ([array[i][@"stype"] intValue] == 2){
            [self.stypeArr2 addObject:array[i]];
        }else{
            [self.stypeArr3 addObject:array[i]];
        }
    }
}


#pragma mark 添加刷新控件  ---- 任务列表
-(void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTaskListData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
}

/*  任务列表  */
- (void)loadTaskListData
{
    
    if (STUserDefaults.isLogin ) {
    
        [self.infoArr removeAllObjects];
        [self loadData];
        
    } else {
        
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        [self.tableView.mj_header endRefreshing];
    }

    
}

- (void)loadData{

    [STRequest PlayerTaskInfoDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        XWUserTaskModel *dataModel = [XWUserTaskModel mj_objectWithKeyValues:ServersData];

        if (isSuccess) {
                if (dataModel.c == 1) {
                    
                    if (dataModel.d.usertask.count == 0) {
                        JLLog(@"无更多数据");
                    } else {
                        
                        for (UserTask *detailModel in dataModel.d.usertask) {
                            [self.infoArr addObject:detailModel];
                            
                        }
                        
                        [self.tableView reloadData];
                    }
                    
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                    
                } else {
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                }
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:@"无网络"];
            [self.tableView.mj_header endRefreshing];
            
        }
    }];
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.stypeArr3.count == 0) {
        return 3;

    } else {
        return 4;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.stypeArr3.count == 0) {
        if (section == 0) {
            return 1;
        }else if(section == 1){
            return self.stypeArr1.count;
        }else{
            return self.stypeArr2.count;
        }
    } else {
        if (section == 0) {
            return 1;
        }else if(section == 1){
            return self.stypeArr1.count;
        }else if(section == 2){
            return self.stypeArr2.count;
        }else{
            return self.stypeArr3.count;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:XWPACKET_TASKINFO_CACHE_PATH];
    
    if (self.stypeArr3.count == 0) {
        if (indexPath.section == 0) {
            
            XWImageCell *myappreCell = [[XWImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWTaskListHeaderCell"];
            
            [myappreCell setDataCellWithImage:MyImage(@"icon_shareCoin")];
            
            return myappreCell;
            
        }else if(indexPath.section == 1)
        {
            static NSString *CellIdentifier = @"XWPacketMidCell";
            XWPacketMidCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[XWPacketMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            
            [cell setCellDataWithDict:self.stypeArr1[indexPath.row] andArray:self.infoArr];
            
            return cell;
            
        }else{
            
            static NSString *CellIdentifier1 = @"XWPacketMidCellID";
            XWPacketMidCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (!cell) {
                cell = [[XWPacketMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell setCellDataWithDict:self.stypeArr2[indexPath.row] andArray:self.infoArr];
            
            return cell;
            
        }

    } else {
        if (indexPath.section == 0) {
            
            XWImageCell *myappreCell = [[XWImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWTaskListHeaderCell"];
            
            [myappreCell setDataCellWithImage:MyImage(@"icon_shareCoin")];
            
            return myappreCell;
            
        }else if(indexPath.section == 1)
        {
            static NSString *CellIdentifier = @"XWPacketMidCell";
            XWPacketMidCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[XWPacketMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell setCellDataWithDict:self.stypeArr1[indexPath.row] andArray:self.infoArr];
            
            return cell;
            
        }else if(indexPath.section == 2){
            
            static NSString *CellIdentifier1 = @"XWPacketMidCellID";
            XWPacketMidCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (!cell) {
                cell = [[XWPacketMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell setCellDataWithDict:self.stypeArr2[indexPath.row] andArray:self.infoArr];
            
            return cell;
            
        }else{
            
            static NSString *CellIdentifier1 = @"XWPacketMidCellID";
            XWPacketMidCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (!cell) {
                cell = [[XWPacketMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell setCellDataWithDict:self.stypeArr3[indexPath.row] andArray:self.infoArr];
            return cell;
            
            
        }

    }
    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

- (NSMutableArray *)infoArr
{

    if (!_infoArr) {
        _infoArr = [NSMutableArray array];
        
    }
    return _infoArr;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90*AdaptiveScale_W;
    }else if(indexPath.section == 1){
        return 50*AdaptiveScale_W;
    }else if(indexPath.section == 2){
        return 50*AdaptiveScale_W;
    }else{
        return 50*AdaptiveScale_W;
    }
}

//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0){
//        if (STUserDefaults.isLogin) {
            XWPublishView *publishView = [[XWPublishView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            publishView.delegate = self;
//            [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelAlert;

            [publishView  show];
//        } else {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
//        }
        
    }
    
}

#pragma mark ===================== 分享app+分享和扫描二维码  ==========================
-(void)didSelectBtnWithBtnTag:(NSInteger)tag
{
    
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSString *titleStr = @"口袋头条";
    //创建网页内容对象
    NSString *urlStr = [NSString stringWithFormat:@"%@?uid=%@&name=%@",STUserDefaults.shareurl,STUserDefaults.uid,STUserDefaults.name];
//    NSString *inviteCodeStr = STUserDefaults.inviteCode;
    
    JLLog(@"urlStr ---- %@",urlStr);
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:titleStr descr:@"口袋头条,可以赚钱的APP！" thumImage:MyImage(@"icon-120*120")];
    //设置网页地址
    shareObject.webpageUrl = urlStr;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    if (tag == 1) {
        //朋友圈
        //分享到微信朋友圈
        if (![STUserDefaults.phonenum isEqualToString:@""]){
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                    [SVProgressHUD showErrorWithStatus:@"分享失败,获取奖励失败"];

                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                        //分享app回调
                        [self shareAppReturn];
                       
//                        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
//                        
//                        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                            
//                            
//                        }]];
//                        
//                        
//                        [self presentViewController:alert animated:YES completion:nil];
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
            }];
            
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
//                
//            }]];
//            [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }]];
//            
//            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    } else if(tag == 2){
        //微信好友
        if (![STUserDefaults.phonenum isEqualToString:@""]){
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                    [SVProgressHUD showErrorWithStatus:@"分享失败,获取奖励失败"];

                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        JLLog(@"response originalResponse data is %@\nresponse message is %@",resp.originalResponse,resp.message);
                        
                        
                        [self shareAppReturn];

//                        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
//                        
//                        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                            
//                            
//                        }]];
//                        
//                        
//                        [self presentViewController:alert animated:YES completion:nil];
                        
                    }else{
                        JLLog(@"response data is %@",data);
                    }
                }
            }];
            
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
//            {
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
//                [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    
//                    
//                }]];
//                
//                [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    
//                }]];
//                
//                [self presentViewController:alert animated:YES completion:nil];
//                
//            }
            
        }
        
    }else if (tag == 3){
    
        //二维码=====扫二维码下载app收徒 icon-120*120  创建弹出框
        
        NSString *str = [NSString stringWithFormat:@"%@?invitecode=%ld",STUserDefaults.codeShareUrl,[STUserDefaults.uid integerValue]+SYS_INVITECODE_ID];
        JLLog(@"str===%@",str);
        [self setupQRcodeAlertViewWithUrl:str];
        
        
    }

}

- (void)shareAppReturn
{
    [STRequest ShareAppBackDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"serversData----%@",ServersData);
        if (isSuccess) {
            if ([ServersData[@"c"] integerValue] == 1) {
                NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                
                if (dictemp.count == 0) {
                    JLLog(@"serverdata---%@",ServersData[@"d"]);
                }else{
                    _shareArr = [NSMutableArray arrayWithArray:dictemp[@"taskstatus"]];
                    if (_shareArr.count == 0) {
                        //无任务状态时，为空数组
                        JLLog(@"无任务状态");
                        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                    } else {
                        //有任务状态
                        _shareIngot = _shareArr[0][@"ingot"];
                        _shareStatus = _shareArr[0][@"status"];
                        _shareDesc = _shareArr[0][@"desc"];
                        
                        if ([_shareStatus integerValue] == 0) {
                            [SVProgressHUD showSuccessWithStatus:@"任务进行中"];
                        } else {
                            //成功后任务描述
                            //添加提示弹框
                            [self setupAlertViewWithTitle:_shareIngot];
                            NSString *str = [NSString stringWithFormat:@"%@\n＋%@元宝",_shareDesc,_shareIngot];
                            
                            [SVProgressHUD showSuccessWithStatus:str];
                        }
                    }
                    
                    [_shareArr removeAllObjects];
 
                }
            } else {
                //[SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                JLLog(@"%@",ServersData[@"m"]);
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            [self.tableView.mj_header endRefreshing];
            
        }

    }];

}

#pragma mark ========================== 创建获得元宝的弹出窗 =============================
- (void)setupAlertViewWithTitle:(NSString *)title
{
//    UIView *ReceiveBgView = [[UIView alloc]init];
//    self.receiveView = ReceiveBgView;
//    CGRect frame = ReceiveBgView.frame;
//    frame.size.height = IPHONE_H/20*9;
//    frame.size.width = IPHONE_W/3*2;
//    ReceiveBgView.frame = frame;
//    ReceiveBgView.center = self.view.center;
//    [self.view addSubview:ReceiveBgView];
//    
//    UIImageView *imgV = [[UIImageView alloc]initWithFrame:frame];
//    imgV.image = [UIImage imageNamed:@"bg_reward_get"];
//    [ReceiveBgView addSubview:imgV];
//    
//    UIImageView *numberV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_reward_text"]];
//    numberV.frame = CGRectMake(ReceiveBgView.frame.size.width/6, ReceiveBgView.frame.size.height/3, ReceiveBgView.frame.size.width/3*2, ReceiveBgView.frame.size.height/4);
//    [ReceiveBgView addSubview:numberV];
//    
//    self.numLab = [[UILabel alloc]initWithFrame:numberV.frame];
//    self.numLab.text = [NSString stringWithFormat:@"＋%@元宝",title];
//    self.numLab.textColor = [UIColor whiteColor];
//    self.numLab.textAlignment = NSTextAlignmentCenter;
//    self.numLab.font = [UIFont systemFontOfSize:23 weight:1];
//    [ReceiveBgView addSubview:self.numLab];
//    
//    UIButton *receiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    receiveBtn.frame = CGRectMake(ReceiveBgView.frame.size.width/4, ReceiveBgView.frame.size.height/6*4, ReceiveBgView.frame.size.width/2, ReceiveBgView.frame.size.height/7);
//    [receiveBtn setBackgroundImage:[UIImage imageNamed:@"icon_reward_button"] forState:UIControlStateNormal];
//    [receiveBtn addTarget:self action:@selector(receivesActive) forControlEvents:UIControlEventTouchUpInside];
//    [ReceiveBgView addSubview:receiveBtn];
//    [receiveBtn bringSubviewToFront:ReceiveBgView];
//    
//    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:ReceiveBgView preferredStyle:TYAlertControllerStyleAlert];
//    
//    [alertController setBlurEffectWithView:self.view];
//    [self presentViewController:alertController animated:YES completion:nil];

    //添加通知  提醒任务列表刷新 且 我的界面的元宝个数更新
    [self.tableView.mj_header beginRefreshing];
    
    NSDictionary *dict = @{
                           @"taskingot":title
                           };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTaskUserData" object:nil userInfo:dict];
    
    
}

#pragma mark ====================== 创建二维码的弹出框 ============================

- (void)setupQRcodeAlertViewWithUrl:(NSString *)urlStr
{
    UIView *ReceiveBgView = [[UIView alloc]init];
    self.qrcodeView = ReceiveBgView;
    [self.view addSubview:ReceiveBgView];
    ReceiveBgView.backgroundColor = WhiteColor;
    ReceiveBgView.layer.masksToBounds = YES;
    ReceiveBgView.layer.cornerRadius = 5;
    ReceiveBgView.userInteractionEnabled = YES;
    [ReceiveBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.width.mas_equalTo(5*ScreenW/6);
        make.height.mas_equalTo(ScreenH/2);
    }];
    
    UIImageView *qrcodeImage = [[UIImageView alloc]init];
    NSString *qrString = [NSString stringWithFormat:@"%@",urlStr];
    CIImage *qrCIImage = [QRUtility createQRForString:qrString];
    EWMImageImage = [QRUtility createNonInterpolatedUIImageFormCIImage:qrCIImage withSize:400];
    qrcodeImage.image = [QRUtility addIconToQRCodeImage:EWMImageImage withIcon:[UIImage imageNamed:@"icon-120*120"] withScale:4];
    [ReceiveBgView addSubview:qrcodeImage];
    [qrcodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ReceiveBgView.mas_top).offset(35*AdaptiveScale_W);
        make.centerX.mas_equalTo(ReceiveBgView);
        make.width.height.mas_equalTo(200*AdaptiveScale_W);
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"扫描二维码下载口袋头条";
    titleLab.font = [UIFont systemFontOfSize:RemindFont(17, 18, 19)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = MainQRCodeColor;
    [ReceiveBgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(qrcodeImage.mas_bottom).offset(30*AdaptiveScale_W);
        make.centerX.mas_equalTo(ReceiveBgView);
        
    }];
    
//    UILabel *inviteLab = [[UILabel alloc]init];
//    titleLab.text = str;
    
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:MyImage(@"close_share_icon") forState:0];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn bringSubviewToFront:ReceiveBgView];
    [ReceiveBgView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ReceiveBgView.mas_top).offset(5);
        make.right.mas_equalTo(ReceiveBgView.mas_right).offset(-5);
        make.width.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:ReceiveBgView preferredStyle:TYAlertControllerStyleAlert];
    self.alertController = alertController;
    [alertController setBlurEffectWithView:self.view style:BlurEffectStyleDarkEffect];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)receivesActive
{
    [self.receiveView hideView];
}

- (void)closeClick
{
    [self.qrcodeView hideView];
    JLLog(@"closeClick");

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.alertController dismissViewControllerAnimated:YES completion:nil];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XWTaskListHeaderCell *cellView = [[XWTaskListHeaderCell alloc]initWithStyle:0 reuseIdentifier:@"XWTaskListHeaderCell"];
    cellView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    
    if (self.stypeArr3.count == 0) {
        if (section == 0) {
            [cellView setCellDataTitle:@"分享" andrightTitle:@""];
            return cellView;
        }else if(section == 1){
            
            [cellView setCellDataTitle:@"日常任务" andrightTitle:@"未完成"];
            return cellView;
            
        }else{
            [cellView setCellDataTitle:@"新手任务" andrightTitle:@"未完成"];
            return cellView;
        }
    } else {
        if (section == 0) {
            [cellView setCellDataTitle:@"分享" andrightTitle:@""];
            return cellView;
        }else if(section == 1){
            
            [cellView setCellDataTitle:@"日常任务" andrightTitle:@"未完成"];
            return cellView;
            
        }else if(section == 2){
            [cellView setCellDataTitle:@"新手任务" andrightTitle:@"未完成"];
            return cellView;
        }else{
            [cellView setCellDataTitle:@"其他任务" andrightTitle:@"未完成"];
            return cellView;
        }
    }
    
    
}


//奖励领取
- (void)setupGetThings
{
    
    JLLog(@"----setupGetThings-----");
}

-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadTaskInfo" object:nil];
    JLLog(@"dealloc");
}

-(NSMutableArray *)stypeArr1
{
    if (_stypeArr1 == nil)
    {
        _stypeArr1 = [NSMutableArray new];
    }
    return _stypeArr1;
}
-(NSMutableArray *)stypeArr2
{
    if (_stypeArr2 == nil)
    {
        _stypeArr2 = [NSMutableArray new];
    }
    return _stypeArr2;
}
-(NSMutableArray *)stypeArr3
{
    if (_stypeArr3 == nil)
    {
        _stypeArr3 = [NSMutableArray new];
    }
    return _stypeArr3;
}

- (NSMutableArray *)shareArr
{
    if (_shareArr == nil) {
        _shareArr = [NSMutableArray new];
    }
    return _shareArr;
}

- (NSMutableArray *)signInArr
{
    if (_signInArr == nil) {
        _signInArr = [NSMutableArray new];
    }
    return _signInArr;
}

@end
