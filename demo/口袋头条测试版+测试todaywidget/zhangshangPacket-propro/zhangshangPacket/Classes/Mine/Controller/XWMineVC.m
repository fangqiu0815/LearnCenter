//
//  XWMineVC.m
//  zhangshangnews
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineVC.h"
#import "XWMineHeaderCell.h"
#import "XWMidleCell.h"
#import "XWMineListCell.h"
#import "XWMineExitCell.h"
#import "XWMiddleCashCell.h"
#import "XWMineHelpVC.h"
#import "XWMineApprenticeVC.h"
#import "XWMineAboutUsVC.h"
#import "XWMineInCashVC.h"
#import "XWTaskListVC.h"
#import "XWPacketMidCell.h"
#import "XWMineApprenticeVC.h"
#import "XWPacketNewVC.h"
#import "XWPacketCashVC.h"
#import "ShoppingViewController.h"
#import "XWIncomeDetailInfoModel.h"
#import "XWIncomeDetailListTool.h"
#import "XWSysNoticeVCViewController.h"
#import "XWLoginVC.h"
#import "XWHomeDetailVC.h"
#import "XWPacketVC.h"
#import "XWPacketNewVC.h"
#import "XWMineFriendVC.h"
#import "XWPacketCashVC.h"
#import "XWLoginVC.h"
#import "XWTurnTableVC.h"
#import "XWMineImageView.h"
#import "XWMineSettingVC.h"
#import "XWCollectVC.h"
#import "XWMineUsefulToolsVC.h"

@interface XWMineVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_AlertView;
    UILabel *numLab;
    NSInteger g;
    UIImageView *_headerPullImage;
}
@property (nonatomic, strong) XWMineVC *mineVC;

/**
 * UIImageView
 */
@property (nonatomic, strong) UIImageView *bgImageView;

/**
 * midView
 */
@property (nonatomic, strong) UIView  *midView;

@property (nonatomic, strong) NSMutableArray *infoArr;

@property (nonatomic, strong) XWMiddleCashCell *cashCell;

@property (nonatomic, strong) NSArray *cellTitleArr;

@property (nonatomic, strong) NSArray *cellImage;

@property (nonatomic, strong) XWMineImageView *waveImage;



@end

@implementation XWMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [XWPacketVC sentValueClick:^(NSInteger b) {
        _shareIngot = b;
    }];
    [XWPacketVC sentValueClick:^(NSInteger a) {
        _signIngot = a;
    }];
    _allIngot = _homeIngot+_adIngot+_shareIngot+_signIngot+STUserDefaults.ingot;
    _cashCell.detailLab.text = [NSString stringWithFormat:@"%ld",(long)_allIngot];

    self.view.backgroundColor = MainBGColor;
    [self setupTableView];
    [self initAlertView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPerson) name:@"reloadPerson" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMessage) name:@"reloadMessage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAllIngot:) name:@"sendIngotToMine" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTaskUserData:) name:@"sendTaskUserData" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTurnTableData:) name:@"sendTurnIngotToMine" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendImageAndName:) name:@"SendNameAndImageToMine" object:nil];
#pragma mark ============== 添加调用微信分享或是转盘和提现需要判断是否绑定微信 ============
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatLogin) name:@"AlwaysWechatLogin" object:nil];
    
#pragma mark ============ 每10分钟请求一次同步数据接口并同步基础数据信息 =================
    //   每10分钟请求一次同步数据接口并同步基础数据信息
    //定时检查用户
    NSTimer  *timer = [NSTimer scheduledTimerWithTimeInterval:300.0 target:self selector:@selector(everyRequestUserInfo) userInfo:nil repeats:YES];
    //放到子线程
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //   本地定时每日0点刷新用户数据
//    [self everyDay0clockLoadUserInfo];
    
    if (STUserDefaults.ischeck == 1) {
        self.cellTitleArr = @[@"系统公告",@"帮助中心",@"实用工具"];
        self.cellImage = @[@"icon_user_horn",@"icon_user_help",@"icon_user_help"];
    } else {
        self.cellTitleArr = @[@"系统公告",@"帮助中心",@"意见反馈"];
        self.cellImage = @[@"icon_user_horn",@"icon_user_help",@"icon_user_feedback"];
    }
    
    XWPacketNewVC *newVC = [[XWPacketNewVC alloc]init];
    if (newVC.allIngot == _allIngot) {
        _cashCell.detailLab.text = [NSString stringWithFormat:@"%ld",(long)_allIngot];

    } else {
        _cashCell.detailLab.text = [NSString stringWithFormat:@"%ld",(long)newVC.allIngot];

    }
    
}

- (void)sendImageAndName:(NSNotification *)noti{
    [self.waveImage.iconImageView sd_setImageWithURL:[NSURL URLWithString:noti.userInfo[@"userImage"]] placeholderImage:MyImage(@"bg_user_nouser")];
    self.waveImage.nameLab.text = [NSString stringWithFormat:@"%@ (ID:%@)",noti.userInfo[@"nickName"],STUserDefaults.uid] ;
    
}

- (void)sendAllIngot:(NSNotification *)notification{
    
    NSInteger sendToMineIngot = [notification.userInfo[@"allingot"] integerValue];
    
    _allIngot = _allIngot + sendToMineIngot;

    _cashCell.detailLab.text = [NSString stringWithFormat:@"%ld",(long)_allIngot];
    
}

- (void)sendTaskUserData:(NSNotification *)noti{

    NSInteger sendToMineIngot = [noti.userInfo[@"taskingot"] integerValue];
    
    _allIngot = _allIngot + sendToMineIngot;
    _cashCell.detailLab.text = [NSString stringWithFormat:@"%ld",(long)_allIngot];
    
}

- (void)sendTurnTableData:(NSNotification *)noti{
    
    if (STUserDefaults.ischeck) {
        
    }else{
    
        NSDictionary *dic = [noti userInfo];
        NSString *str = [dic valueForKey:@"Info"];
        _allIngot = [str integerValue];
        JLLog(@"str----%@",str);
        _cashCell.detailLab.text = str;
    }
    
    
}


- (void)everyDay0clockLoadUserInfo
{
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateStyle:NSDateFormatterMediumStyle];
        [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateStr1 = [formatter1 stringFromDate:now];
        NSArray *array = [dateStr1 componentsSeparatedByString:@" "];
        JLLog(@"______________________________%@",[array objectAtIndex:1]);
        NSArray *array1 = [[array objectAtIndex:1] componentsSeparatedByString:@":"];
        JLLog(@"______________________________%@",[array1 objectAtIndex:0]);
        if ([[array1 objectAtIndex:0] intValue] == 0) {
            if (STUserDefaults.isLogin ) {
            
                JLLog(@"======= 时间到了1 ======");
                [self postPersonData];
                
                dispatch_queue_t mainQueue = dispatch_get_main_queue();
                //异步返回主线程，根据获取的数据，更新UI
                dispatch_async(mainQueue, ^{
                    [self.tableView reloadData];
                });
                
            } else {
                [SVProgressHUD showErrorWithStatus:@"请先登录"];
                [self wechatLogin];
            }
        
            JLLog(@"======= 时间到了2 ======");
        }

    });
    
}


+(void)sentValueClick:(intBlock)_sentBlock
{
    XWMineVC *vc = [[XWMineVC alloc] init];
    
    [XWPacketVC sentValueClick:^(NSInteger b) {
        vc.shareIngot = b;
    }];
    
    [XWPacketVC sentValueClick:^(NSInteger a) {
        vc.signIngot = a;
    }];
    
    vc.allIngot = vc.homeIngot+vc.adIngot+vc.signIngot+vc.shareIngot+STUserDefaults.ingot;
    _sentBlock(vc.allIngot);
    
}


- (void)everyRequestUserInfo
{
    [STRequest TogetherUserDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        
        if (isSuccess) {
            if ([ServersData[@"c"] integerValue] == 1) {
                
                NSDictionary *ditempDict = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                
                STUserDefaults.ingot = [ditempDict[@"ingot"] integerValue];
                STUserDefaults.cash =  [NSString stringWithFormat:@"%.2f",[ditempDict[@"cash"] floatValue]/100.0];
                STUserDefaults.cashtotal = [NSString stringWithFormat:@"%.2f",[ditempDict[@"cashtotal"] floatValue]/100.0];
                STUserDefaults.cashconver = [NSString stringWithFormat:@"%.2f",[ditempDict[@"cashconver"] floatValue]/100.0];
                STUserDefaults.cashtoday = [NSString stringWithFormat:@"%.2f",[ditempDict[@"cashtoday"] floatValue]/100.0];
                
                JLLog(@"%ld-----%@---%@---%@----%@",(long)STUserDefaults.ingot,STUserDefaults.cash,STUserDefaults.cashtotal,STUserDefaults.cashyes,STUserDefaults.cashtoday);
                
            } else {
                [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
        }
    }];
    

}

-(void)reloadPerson
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)reloadMessage
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)setupHeaderView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 250*AdaptiveScale_W)];
    view.dk_backgroundColorPicker = DKColorPickerWithColors(MainRedColor,NightHeaderMainColor,MainRedColor);
    XWMineImageView *waveImage = [[XWMineImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 180*AdaptiveScale_W)];
    waveImage.dk_backgroundColorPicker = DKColorPickerWithColors(MainRedColor,NightHeaderMainColor,MainRedColor);
    
    self.waveImage = waveImage;
    [waveImage.setBtn addTarget:self action:@selector(settingUpClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:waveImage];
    
    XWMidleCell *midleCell = [[XWMidleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWMidleCell"];
    midleCell.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightHeaderMainColor,MainRedColor);
    midleCell.frame = CGRectMake(0, 180*AdaptiveScale_W, ScreenW, 70*AdaptiveScale_W);
    [midleCell.cashBtn addTarget:self action:@selector(cashClick:) forControlEvents:UIControlEventTouchUpInside];
    [midleCell.myApprenticeBtn addTarget:self action:@selector(myApprenticeClick:) forControlEvents:UIControlEventTouchUpInside];
    [midleCell.foundBtn addTarget:self action:@selector(foundClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [midleCell.cashBtn dk_setTitleColorPicker:DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor) forState:0];
    [midleCell.myApprenticeBtn dk_setTitleColorPicker:DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor) forState:0];
    [midleCell.foundBtn dk_setTitleColorPicker:DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor) forState:0];
    
    [view addSubview:midleCell];
    
    self.tableView.tableHeaderView = view;
    

}

- (void)settingUpClick
{
    XWMineSettingVC *settingVC = [XWMineSettingVC new];
    [self.navigationController pushViewController:settingVC animated:YES];
    JLLog(@"点击了设置");
}

- (void)loginClickMore
{

    JLLog(@"点击了头像和名字");
}

- (void)setupTableView
{
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,BlackColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    _headerPullImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    [_headerPullImage xw_setDayMode:^(UIView *view) {
        UIImageView *headPullImage = (UIImageView *)view;
        headPullImage.backgroundColor = MainRedColor;
    } nightMode:^(UIView *view) {
        UIImageView *headPullImage = (UIImageView *)view;
        headPullImage.backgroundColor = NightMainBGColor;
    }];
    
    [self.tableView addSubview:_headerPullImage];
    
    [self setupHeaderView];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //获取当前活动的tableview
    CGFloat  y = scrollView.contentOffset.y;
    if (scrollView == self.tableView) {
        if (y < 0) {
            CGRect frame = _headerPullImage.frame;
            frame.size.height =  - y ;
            frame.origin.y = y;
            _headerPullImage.frame = frame;
        }
    }
}

- (void)postPersonData
{
    //[SVProgressHUD showWithStatus:@"正在获取用户信息，请稍后" maskType:SVProgressHUDMaskTypeClear];
    NSString *osversion = DeviceInfo_shared->getOSVersion();
    NSString *devicetype = DeviceInfo_shared->getDeviceType();
    NSString *yueyu = DeviceInfo_shared->getYueYuState();
    NSString *phonecard = DeviceInfo_shared->getCardState();
    
    NSDictionary *param = @{
                            @"yueyu":yueyu,
                            @"phonecard":phonecard,
                            @"osversion":osversion,
                            @"devicetype":devicetype
                            };

    [STRequest downLoadUserDataTwoWithDict:param WithBlock:^(id ServersData, BOOL isSuccess) {
        STUserDefaults.isLogin = YES;
        if (isSuccess){
            JLLog(@"getinfo----%@",ServersData);
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSString *uid = [NSString stringWithFormat:@"%@",dictemp[@"uid"]];
                    NSString *userName=[NSString stringWithFormat:@"%@",dictemp[@"name"]];
                    
                    NSString *userImg = [NSString stringWithFormat:@"%@",dictemp[@"img"]];
                    
                    //                    NSString *usericon = STUserDefaults.img;
                    //                    NSString *username = STUserDefaults.name;
                    
                    NSString *phoneNum = [NSString stringWithFormat:@"%@",dictemp[@"phonenum"]];
                    NSString *token = [NSString stringWithFormat:@"%@",dictemp[@"token"]];
                    NSString *cash = [NSString stringWithFormat:@"%@",dictemp[@"cash"]];
                    NSString *cashyes = [NSString stringWithFormat:@"%@",dictemp[@"cashyes"]];
                    NSString *cashtoday = [NSString stringWithFormat:@"%@",dictemp[@"cashtoday"]];
                    NSString *cashconver = [NSString stringWithFormat:@"%@",dictemp[@"cashconver"]];
                    NSString *ingot = [NSString stringWithFormat:@"%@",dictemp[@"ingot"]];
                    NSString *isshare = [NSString stringWithFormat:@"%@",dictemp[@"isshare"]];
                    NSString *tasknum = [NSString stringWithFormat:@"%@",dictemp[@"tasknum"]];
                    NSString *isreward = [NSString stringWithFormat:@"%@",dictemp[@"isreward"]];
                    NSString *disciple = [NSString stringWithFormat:@"%@",dictemp[@"disciple"]];
                    NSString *disciplefee = [NSString stringWithFormat:@"%@",dictemp[@"disciplefee"]];
                    NSString *cashtotal = [NSString stringWithFormat:@"%@",dictemp[@"cahstotal"]];
                    
                    BOOL issign = [dictemp[@"issign"] boolValue];
                    
                    if ([phoneNum isEqualToString:@""]) {
                        JLLog(@"当前未绑定账户");
                    } else {
                        STUserDefaults.phonenum = phoneNum;

                    }
                    
                    STUserDefaults.isLogin = YES;
                    STUserDefaults.uid = uid;
                    STUserDefaults.name = userName;
                    STUserDefaults.img = userImg;
                    STUserDefaults.token = token;
                    
                    STUserDefaults.cash = [NSString stringWithFormat:@"%.2f",[cash floatValue]/100.0];
                    STUserDefaults.cashtotal = [NSString stringWithFormat:@"%.2f",[cashtotal floatValue]/100.0];
                    STUserDefaults.cashyes = [NSString stringWithFormat:@"%.2f",[cashyes floatValue]/100.0];
                    STUserDefaults.cashtoday = [NSString stringWithFormat:@"%.2f",[cashtoday floatValue]/100.0];
                    STUserDefaults.cashconver = [NSString stringWithFormat:@"%.2f",[cashconver floatValue]/100.0];
                    
                    STUserDefaults.ingot = [ingot intValue];
                    
                    STUserDefaults.isshare = [isshare boolValue];
                    
                    STUserDefaults.tasknum = [tasknum integerValue];
                    
                    STUserDefaults.isreward = [isreward boolValue];
                    
                    STUserDefaults.disciple = [disciple integerValue];
                    
                    STUserDefaults.disciplefee = [disciplefee integerValue];
                    
                    STUserDefaults.issign = issign;
                    
                    STUserDefaults.inviteCode = [NSString stringWithFormat:@"%d",[uid intValue]+SYS_INVITECODE_ID];
                    
                    [SVProgressHUD dismiss];
                }
                else
                {
                    NSLog(@"获取用户信息：%@",ServersData[@"m"]);
                    if ([self isBlankString:STUserDefaults.token]) {
                        STUserDefaults.isLogin = NO;
                    }
                    else
                    {
                        STUserDefaults.isLogin = NO;
                        [SVProgressHUD showErrorWithStatus:@"登录已过期，请到个人中心进行登录"];
                        XWLoginVC *VC = [[XWLoginVC alloc] init];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:VC animated:YES completion:nil];
                        // [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
                        STUserDefaults.uid = 0;
                        STUserDefaults.img = NULL;
                        STUserDefaults.token = @"";
                        STUserDefaults.name = @"";
                        STUserDefaults.cash = 0;
                        STUserDefaults.cashtotal = 0;
                        STUserDefaults.cashyes = 0;
                        STUserDefaults.cashtoday = 0;
                        STUserDefaults.cashconver = 0;
                        STUserDefaults.ingot = 0;
                        STUserDefaults.isshare = NO;
                        STUserDefaults.tasknum = 0;
                        STUserDefaults.isreward = NO;
                        STUserDefaults.disciple = 0;
                        STUserDefaults.disciplefee = 0;
                        STUserDefaults.inviteCode = 0;
                    }
                }
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
            }
        }
        else
        {
            
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
        }
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return (self.cellTitleArr.count);
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0){
        XWMiddleCashCell *cashCell = [[XWMiddleCashCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWMiddleCashCell"];
        cashCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cashCell = cashCell;
        if (STUserDefaults.ischeck == 1) {
            [cashCell setCellDataWithTitle:@"今日日期" andRightTitle:[self getCurrentTime] andRightTitleColor:MainRedColor andleftImage:MyImage(@"icon_user_ingot")];
        } else {
            [cashCell setCellDataWithTitle:@"今日获得元宝" andRightTitle:[NSString stringWithFormat:@"%ld",(long)_allIngot] andRightTitleColor:MainRedColor andleftImage:MyImage(@"icon_user_ingot")];
            
        }
        
        return cashCell;
        
    }else{
        XWMineListCell *listCell = [[XWMineListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWMineListCell"];
        listCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        listCell.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
        
        if (indexPath.row == self.cellTitleArr.count) {
            XWMineExitCell *quitCell = [[XWMineExitCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWMineExitCell"];
            quitCell.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
            quitCell.userInteractionEnabled = NO;
            quitCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return quitCell;
        }else{
            
            [listCell setCellDataWithImage:MyImage(self.cellImage[indexPath.row]) andTitle:self.cellTitleArr[indexPath.row]];
            return listCell;
            
        }
        
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            JLLog(@"今日获得元宝数");
        }else{
            
            /*
               奖励领取
             */
                if (STUserDefaults.isreward) {
                    [self getReward];

                } else {
                    JLLog(@"无奖励");
                }
            
        }
        
    }else{
        if(indexPath.row == 0)
        {
            XWSysNoticeVCViewController *helpVC = [[XWSysNoticeVCViewController alloc]init];
            [self.navigationController pushViewController:helpVC animated:YES];
            
        }else if(indexPath.row == 1){
            
            XWMineHelpVC *helpVC = [[XWMineHelpVC alloc]init];
            [self.navigationController pushViewController:helpVC animated:YES];
            
        }else if(indexPath.row == 2){
            //跳转反馈中心
            //mqq://im/chat?chat_type=wpa&uin=好友QQ号&version=1&src_type=web
            //客服QQ：
            if (STUserDefaults.ischeck == 1) {
                
                XWMineUsefulToolsVC *helpVC = [[XWMineUsefulToolsVC alloc]init];
                [self.navigationController pushViewController:helpVC animated:YES];
                
            } else {
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL  URLWithString:@"mqq://"]]){
                    NSString *str = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",STUserDefaults.serviceqq];
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"您需要先安装QQ"];
                }
            }
            
        }else{
            JLLog(@"版本 1.0.0");

        }
    }
}

- (void)getReward
{
    [STRequest getTaskAwardDataWithBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if (ServersData[@"c"]) {
                    
                    JLLog(@"%@",ServersData);
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    JLLog(@"%@",dictemp[@"ingot"]);
                    
                    NSInteger rewardIngot = [dictemp[@"ingot"] integerValue];
                    
                    if (rewardIngot == 0) {
                        
                        _AlertView.hidden = NO;
                        numLab.text = [NSString stringWithFormat:@"元宝+%ld",(long)rewardIngot];
                        
                    } else {
                        _AlertView.hidden = NO;
                        numLab.text = [NSString stringWithFormat:@"元宝+%ld",(long)rewardIngot];
                        
                        rewardIngot = STUserDefaults.ingot + rewardIngot;
                        _allIngot = rewardIngot;
                        
                    }
                    
                    
                } else {
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];

                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"网络故障"];

            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"无网络"];
        }
        
    }];


}

- (void)initAlertView{
    _AlertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_W, IPHONE_H+64)];
    _AlertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:_AlertView];
    //    [self.view addSubview:_AlertView];
    UIView *ReceiveBgView = [[UIView alloc]init];
    CGRect frame = ReceiveBgView.frame;
    frame.size.height = IPHONE_H/20*9;
    frame.size.width = IPHONE_W/3*2;
    ReceiveBgView.frame = frame;
    ReceiveBgView.center = _AlertView.center;
    [_AlertView addSubview:ReceiveBgView];
    [ReceiveBgView bringSubviewToFront:_AlertView];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:frame];
    imgV.image = [UIImage imageNamed:@"bg_reward_get"];
    [ReceiveBgView addSubview:imgV];
    
    UIImageView *numberV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_reward_text"]];
    numberV.frame = CGRectMake(ReceiveBgView.frame.size.width/6, ReceiveBgView.frame.size.height/3, ReceiveBgView.frame.size.width/3*2, ReceiveBgView.frame.size.height/4);
    [ReceiveBgView addSubview:numberV];
    
    numLab = [[UILabel alloc]initWithFrame:numberV.frame];
    numLab.text = @"元宝";
    numLab.textColor = [UIColor whiteColor];
    numLab.textAlignment = NSTextAlignmentCenter;
    numLab.font = [UIFont systemFontOfSize:23 weight:1];
    [ReceiveBgView addSubview:numLab];
    
    UIButton *receiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    receiveBtn.frame = CGRectMake(ReceiveBgView.frame.size.width/4, ReceiveBgView.frame.size.height/6*4, ReceiveBgView.frame.size.width/2, ReceiveBgView.frame.size.height/7);
    [receiveBtn setBackgroundImage:[UIImage imageNamed:@"icon_reward_button"] forState:UIControlStateNormal];
    [receiveBtn addTarget:self action:@selector(receivesActive) forControlEvents:UIControlEventTouchUpInside];
    [ReceiveBgView addSubview:receiveBtn];
    [receiveBtn bringSubviewToFront:ReceiveBgView];
    //    [[UIApplication sharedApplication].keyWindow addSubview:receiveBtn];
    _AlertView.hidden = YES;
    
    
    
}
-(void)receivesActive{
    _AlertView.hidden = YES;
    NSLog(@"隐藏");
}


//钱包
- (void)cashClick:(id)sender
{
    if (STUserDefaults.ischeck == 1) {
        //收藏
        
        XWCollectVC *hisVC = [[XWCollectVC alloc]init];
        hisVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hisVC animated:YES];
        
    } else {
        XWPacketCashVC *cashVC = [[XWPacketCashVC alloc]init];
        cashVC.todayIngot = _allIngot;
        cashVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cashVC animated:YES];
        
    }
    
}

//师徒
- (void)myApprenticeClick:(id)sender
{
    if (STUserDefaults.ischeck == 1) {
        XWMineFriendVC *helpVC = [[XWMineFriendVC alloc]init];
        helpVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:helpVC animated:YES];
        
    } else {
        XWMineApprenticeVC *appVC = [[XWMineApprenticeVC alloc]init];
        appVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:appVC animated:YES];
    }
}

//发现
- (void)foundClick:(id)sender
{
//    XWPacketNewVC *newVC = [[XWPacketNewVC alloc]init];
//    [self.navigationController pushViewController:newVC animated:YES];
    
//    XWPacketNewVC *turnTableVC = [[XWPacketNewVC alloc]init];
//    turnTableVC.allIngot = _allIngot;
//    turnTableVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:turnTableVC animated:YES];
    
    XWTurnTableVC *turnVC = [XWTurnTableVC new];
    turnVC.allIngot = _allIngot;
    turnVC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:turnVC animated:YES completion:nil];
    
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 10;
    }
    
}

- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

- (void)dealloc
{
    JLLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getPersonData" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = MainRedColor;
    self.navigationController.navigationBarHidden = YES;

//    //从后台转到前台个人信息列表自动刷新的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground)name:UIApplicationWillEnterForegroundNotification object:nil];

}

#pragma mark ============ 从后台转到前台 个人信息列表自动刷新 ========================
//- (void)applicationWillEnterForeground{
//    
////    if (STUserDefaults.isLogin) {
//        [self postPersonData];
//
////    } else {
////        [self wechatLogin];
////    }
//    
//}

- (void)wechatLogin
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
        XWLoginVC *loginVC = [[XWLoginVC alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];

}

//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
